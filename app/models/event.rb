# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :onigiri_events
  has_many :onigiris, through: :onigiri_events
end