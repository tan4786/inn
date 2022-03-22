class Rental < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :reservations, optional: true
  validates :address, {presence: true}
  validates :area, {presence: true}
  validates :price, {presence: true}
  validates :description, {presence: true}
end
