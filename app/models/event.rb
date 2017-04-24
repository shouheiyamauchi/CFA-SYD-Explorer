class Event < ApplicationRecord
  has_many :attendances
  belongs_to :user

  scope :approved, -> { where(event_approved: "true") }
  scope :pending, -> { where(event_approved: "false") }
  scope :rejected, -> { where(event_approved: "rejected") }
  scope :future, -> { where("event_date >= ?", Date.today ) }
  scope :past, -> { where("event_date < ?", Date.today ) }
  scope :owner, lambda { |user| where("user_id = ?", user.id)}
end
