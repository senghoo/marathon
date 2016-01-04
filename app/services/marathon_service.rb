require 'github_api'
require 'open-uri'

class MarathonService
  def initialize
    github_id = ENV['GITHUB_ID']
    github_secret = ENV['GITHUB_SECRET']
    @github = Github.new basic_auth: "#{github_id}:#{github_secret}"
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

      streak = 0
      conb.contributions.each do |date, count|
        if count == 0
          streak = 0
        else
          streak += 1
          contrib = member.contributions.find_by(date: date) || Contribution.new(date: date, member: member )
          contrib.count = count
          contrib.streak = streak
          contrib.save
        end
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
    @svg ||= open(url).read
  end

  def xml
    @xml ||= Nokogiri::XML(svg)
  end

  def contributions
    Hash[xml.xpath("/svg/g/g/rect").collect { |e| [Date.parse(e['data-date']), e['data-count'].to_i]}].sort.to_h
  end


end
