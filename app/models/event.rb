class Event < ActiveRecord::Base
  KINDS = %w[new_discussion discussion_title_edited discussion_description_edited new_comment
             new_motion new_vote motion_blocked motion_close_date_edited
             motion_closing_soon motion_closed membership_requested
             user_added_to_group comment_liked user_mentioned]

  has_many :notifications, :dependent => :destroy
  belongs_to :eventable, :polymorphic => true
  belongs_to :user

  validates_inclusion_of :kind, :in => KINDS
  validates_presence_of :eventable

  attr_accessible :kind, :eventable, :user, :discussion_id

  def notify!(user)
    notifications.create!(user: user)
  end
end
