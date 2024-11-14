class Member < ApplicationRecord
  validates :name, uniqueness: true
  belongs_to :family

  enum :gender, male: "male", female: "female"

  validate :death_time_validation

  def death_time_validation
    message = "Birth date can't be greater than death date!"
    errors.add(:base, message) if death_date && (birth_date > death_date)
  end
end
