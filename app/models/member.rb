class Member < ActiveRecord::Base
  has_many :contributions
  def github_avatar_url
    "https://avatars.githubusercontent.com/u/#{github_id}?v=3"
  end
  def current_streak
    last_no_commit = contributions.where("count = 0 and date != ?", Date.today).order(date: :desc).first.date
    (Date.today - last_no_commit).to_i
  end

  def streak_image_url
    "https://github.com/users/#{name}/contributions"
  end
end
