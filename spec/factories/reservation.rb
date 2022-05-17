FactoryBot.define do
  factory :reservation do
    source_reservation_code { "SAMPLE_CODE" }
    start_date { Time.now.utc }
    end_date { Time.now.utc + 1.day }
    nights { 1 }
    guests { 1 }
    adults { 1 }
    children { 1 }
    infants { 1 }
    status { 1 }
    currency { 1 }
    payout_price { 1 }
    security_price { 1 }
    total_price { 1 }
  end
end