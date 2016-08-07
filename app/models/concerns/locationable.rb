module Locationable
  extend ActiveSupport::Concern

  included do
    # No validation on locationable in order to keep flow,
    # event if our google api didn't respond properly
    before_validation :fetch_coordinates, on: :create
    before_validation :fetch_coordinates, if: :address_changed?

    def fetch_coordinates
      self.latitude, self.longitude = Geocoder.coordinates(self.address)
    end
  end

  def coordinate
    [self.latitude, self.longitude]
  end
end
