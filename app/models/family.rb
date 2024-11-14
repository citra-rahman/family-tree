class Family < ApplicationRecord
  validates :name, uniqueness: true

  has_many :members


  def ancestor
    members.order(:birth_date).first
  end
end
