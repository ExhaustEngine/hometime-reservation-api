# API

Provides the backend for the reservation endpoint

## 

## Prerequisites
- Postgresql on local. See: https://www.postgresql.org/download/

## Setup

1. Install gems `bundle install`

2. Setup RSpec `rails g rspec:install`

3. Setup DB `rails db:setup db:migrate`

## RSpec

To run tests: `bundle exec rspec` 

## Adding a payload structure

Currently there are two payload structures provided in the Take Home Challenge.

To add a third payload structure, we just need to look for the file `services/parser.rb` and add a payload constant to map out the properties of the payload vs the attributes of our models.

e.g. sample payload:
```
{
  "reservation": {
    "code": {
      "value": "XX09678113"
    },
    "first_name": {
      "value": "FirstName"
    },
    "last_name": {
      "value": "LastName"
    },
    "email": {
      "value": "sample.email@gmail.com"
    }
  }
}
```

Sample models:
```
Guest(first_name: string, last_name: string, email: string)
Reservation(source_reservation_code: string)
```

To map the payload properties with our db attributes, we just need to add this constant under `services/parser.rb`
```
THIRD_RESERVATION_PAYLOAD = {
  reservation: {
    source_reservation_code: [:reservation, :code, :value]
  },
  guest: {
    first_name: [:reservation, :first_name, :value],
    last_name: [:reservation, :last_name, :value],
    email: [:reservation, :email, :value]
  }
}
```

Then append it under the `REGISTERED_MAPPINGS` constant.
```
REGISTERED_MAPPINGS = [Parser::FIRST_PAYLOAD, Parser::SECOND_PAYLOAD, Parser::THIRD_RESERVATION_PAYLOAD].freeze
```
