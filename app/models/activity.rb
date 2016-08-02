class Activity < ActiveRecord::Base
  enum action_type: [I18n.t("activity.user_create"),
    I18n.t("activity.user_update"), I18n.t("activity.follow"),
    I18n.t("activity.unfollow"), I18n.t("activity.lesson_create"),
    I18n.t("activity.lesson_do"), I18n.t("activity.user_login"),
    I18n.t("activity.user_logout")]

  belongs_to :user
  belongs_to :lesson

  validates :user_id, presence: true
end
