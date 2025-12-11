# app/models/location.rb
class Location < ApplicationRecord
  has_many :events
end