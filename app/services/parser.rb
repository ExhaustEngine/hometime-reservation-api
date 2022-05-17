module Parser
  FIRST_PAYLOAD = {
    guest: {
      email: [:guest, :email],
      first_name: [:guest, :first_name],
      last_name: [:guest, :last_name],
      phone_numbers: [:guest, :phone]
    },
    reservation: {
      code: :reservation_code,
      start_date: :start_date,
      end_date: :end_date,
      nights: :nights,
      guests: :guests,
      adults: :adults,
      children: :children,
      infants: :infants,
      status: :status,
      currency: :currency,
      payout_price: :payout_price,
      security_price: :security_price,
      total_price: :total_price,
    }
  }.freeze

  SECOND_PAYLOAD = {
    guest: {
      email: [:reservation, :guest_email],
      first_name: [:reservation, :guest_first_name],
      last_name: [:reservation, :guest_last_name],
      phone_numbers: [:reservation, :guest_phone_numbers]
    },
    reservation: {
      code: [:reservation, :code],
      start_date: [:reservation, :start_date],
      end_date: [:reservation, :end_date],
      nights: [:reservation, :nights],
      guests: [:reservation, :number_of_guests],
      adults: [:reservation, :guest_details, :number_of_adults],
      children: [:reservation, :guest_details, :number_of_children],
      infants: [:reservation, :guest_details, :number_of_infants],
      status: [:reservation, :status_type],
      currency: [:reservation, :host_currency],
      payout_price: [:reservation, :expected_payout_amount],
      security_price: [:reservation, :listing_security_price_accurate],
      total_price: [:reservation, :total_paid_amount_accurate],
    }
  }.freeze

  REGISTERED_MAPPINGS = [Parser::FIRST_PAYLOAD, Parser::SECOND_PAYLOAD].freeze
end