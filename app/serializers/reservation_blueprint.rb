class ReservationBlueprint < Blueprinter::Base
  identifier :id

  fields(
    :source_reservation_code,
    :start_date,
    :end_date,
    :nights,
    :guests,
    :adults,
    :children,
    :infants,
    :status,
    :currency,
    :payout_price,
    :security_price,
    :total_price
  )

  association :guest, blueprint: GuestBlueprint
end