require 'github_api'
require 'open-uri'

class MarathonService
  def initialize
    @github = Github.new
  end
  def declarations
    issues = @github.issues.list user: 'geekan', repo: 'coding_marathon'
    Hash[issues.collect { |issue| [issue.user.login, issue] }]
  end

  def contributions(name)
    Contributions.new name
  end

  def sync
    declarations.each do |name, issue|
      conb = contributions(name)
      member = Member.find_by_name(name) || Member.new(name: name)
      member.home = issue.user.html_url
      member.github_id = issue.user.id
      member.svg = conb.svg
      member.save

      conb.contributions.each do |date, count|
        contrib = member.contributions.find_by(date: date) || Contribution.new(date: date, member: member )
        contrib.count = count
        contrib.save
      end
    end
  end
end


class Contributions
  def initialize(name)
    @name = name
  end

  def url
    "https://github.com/users/#{@name}/contributions"
  end

  def svg
    open(url).read
  end

  def xml
    @xml ||= Nokogiri::XML(url)
  end

  def contributions
    Hash[xml.xpath("/svg/g/g/rect").collect { |e| [Date.parse(e['data-date']), e['data-count'].to_i]}].sort.to_h
  end


end
