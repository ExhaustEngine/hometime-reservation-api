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

  REGISTERED_MAPPINGS = [Parser::FIRST_PAYLOAD].freeze
end