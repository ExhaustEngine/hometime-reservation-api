class GuestBlueprint < Blueprinter::Base
  identifier :id

  fields(
    :email,
    :first_name,
    :last_name,
    :phone_numbers
  )
end