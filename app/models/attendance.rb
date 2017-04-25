class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  scope :pending, -> { where(attendance_status: "pending").joins(:event).merge(Event.future) }
  scope :approved, -> { where(attendance_status: "approved").joins(:event).merge(Event.future) }
  scope :rejected, -> { where(attendance_status: "rejected").joins(:event).merge(Event.future) }
  scope :attended, -> { where(attendance_status: "attended") }
  scope :unattended, -> { where(attendance_status: ["pending", "accepted", "rejected"]).joins(:event).merge(Event.past) }
  scope :today, -> { where(attendance_status: "approved").joins(:event).merge(Event.today) }
end
