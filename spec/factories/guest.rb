FactoryBot.define do
  factory :guest do
    first_name { "John" }
    last_name  { "Doe" }
    email { "john.doe@sample.com" }
    phone_numbers { "0980980" }
  end
end