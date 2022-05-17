# API

Provides the backend for the reservation endpoint

## 

## Prerequisites
- Postgresql on local

## Setup

1. Install gems `bundle install`

2. Setup RSpec `rails g rspec:install`

3. Setup DB `rails db:setup db:migrate`

## RSpec

To run tests: `bundle exec rspec` 

## Adding a payload structure

Currently there are two payload structures provided in the test.

To add a third payload structure, we just need to look for the file `services/parser.rb` and add a payload constant to map out the values of the payload vs the attributes of our models.

e.g. sample payload:
```
{
  "person": {
    "name": "Jasper"
  }
}
```

Sample model:
```
Person(name: string)
```

To map the values with our db attributes, we just need to add this constant under `services/parser.rb`
```
PERSON_PAYLOAD = {
  name: [:person, :name]
}
```

Then append it under the `REGISTERED_MAPPINGS` constant.
```
REGISTERED_MAPPINGS = [Parser::FIRST_PAYLOAD, Parser::SECOND_PAYLOAD, Parser::PERSON_PAYLOAD].freeze
```
