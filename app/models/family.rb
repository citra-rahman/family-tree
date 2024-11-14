class Family < ApplicationRecord
  validates :name, uniqueness: true
end
