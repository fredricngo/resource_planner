# == Schema Information
#
# Table name: locations
#
#  id                :bigint           not null, primary key
#  location_distance :float
#  location_name     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Location < ApplicationRecord
  has_many  :events, class_name: "Event", foreign_key: "event_location", dependent: :destroy
end
