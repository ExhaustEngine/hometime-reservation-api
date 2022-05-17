class ReservationsController < ApplicationController
  def create
    guest_attributes, reservation_attributes = Parser::Mapping.process_payload!(payload: params)

    guest       = update_or_initialize_guest(guest_attributes: guest_attributes)
    reservation = update_or_initialize_reservation(reservation_attributes: reservation_attributes, guest: guest)

    guest.save!
    reservation.save!
    render json: ReservationBlueprint.render(reservation), status: :ok
  end

  private

  def update_or_initialize_guest(guest_attributes:)
    guest = Guest.find_by(email: guest_attributes[:email])

    if guest.present?
      guest.assign_attributes(guest_attributes)
      return guest
    end

    Guest.new(guest_attributes)
  end

  def update_or_initialize_reservation(reservation_attributes:, guest:)
    reservation = Reservation.find_by(
      source_reservation_code: reservation_attributes[:source_reservation_code],
      guest_id: guest.id
    )

    if reservation.present?
      reservation.assign_attributes(reservation_attributes)
      return reservation
    end

    guest.reservations.build(reservation_attributes)
  end
end
