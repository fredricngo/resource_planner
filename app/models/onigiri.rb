# app/models/onigiri.rb
class Onigiri < ApplicationRecord
  has_many :onigiri_events
  has_many :events, through: :onigiri_events
end