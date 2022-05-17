class ReservationsController < ApplicationController
  def create
    guest_attributes, reservation_attributes = Parser::Mapping.process_payload!(payload: params)

    guest       = Guest.new(guest_attributes)
    reservation = guest.reservations.build(reservation_attributes)

    if guest.save!
      render json: ReservationBlueprint.render(reservation), status: :ok
    end
  end
end
