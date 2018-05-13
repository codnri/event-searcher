class Event < ApplicationRecord
  belongs_to :user
  # after_initialize :set_defaults



  #venue -> geo location
  geocoded_by :venue   # can also be an IP address
  after_validation :geocode     # auto-fetch coordinates


  # def set_defaults
  #   self.event_date = "My Default Value" if self.new_record?
  # end
end
