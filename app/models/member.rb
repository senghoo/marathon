class Member < ActiveRecord::Base
  has_many :contributions
  def github_avatar_url
    "https://avatars.githubusercontent.com/u/#{github_id}?v=3"
  end
  def current_streak
    last = contributions.order(date: :desc).first
    if [Date.today, Date.today - 1, Date.today + 1].include? last.date
      last.streak
    else
      0
    end
  end

  def last_day_count
    contributions.order(date: :desc).first.count
  end


  def max_streak
    contributions.maximum(:streak)
  end

  def streak_image_url
    "https://github.com/users/#{name}/contributions"
  end
end
