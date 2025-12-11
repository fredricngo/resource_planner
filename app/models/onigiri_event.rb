# app/models/onigiri_event.rb
class OnigiriEvent < ApplicationRecord
  belongs_to :onigiri
  belongs_to :event
end