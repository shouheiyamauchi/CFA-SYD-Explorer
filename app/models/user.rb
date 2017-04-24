class User < ApplicationRecord
  # validates :dob, presence: true
  validates :first_name, presence: true

  has_many :attendances
  has_many :events

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
