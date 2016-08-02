class Activity < ActiveRecord::Base
  enum action_type: [:learn, :learned, :follow, :unfollow, :register]

  belongs_to :user
  belongs_to :lesson

  validates :user_id, presence: true
end
