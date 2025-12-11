# == Schema Information
#
# Table name: onigiris
#
#  id             :bigint           not null, primary key
#  onigiri_flavor :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Onigiri < ApplicationRecord
  has_many  :onigiri_events, class_name: "OnigiriEvent", foreign_key: "onigiri_id", dependent: :destroy
  has_many :events, through: :onigiri_events, source: :event
end
