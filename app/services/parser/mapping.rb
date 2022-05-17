module Parser
  module Mapping
    class << self
      def process_payload!(payload:)
        mapping = Parser::Validation.get_and_validate_matched_mapping(payload: payload)

        if mapping.nil?
          raise Errors::UnprocessableEntity, "Payload is invalid. Please contact the admin of this API."
        end

        guest_attributes = assign_attributes(payload: payload, attribute_mappings: mapping[:guest])
        reservation_attributes = assign_attributes(payload: payload, attribute_mappings: mapping[:reservation])

        [guest_attributes, reservation_attributes]
      end

      def assign_attributes(payload:, attribute_mappings:)
        attribute_mappings.keys.map { |attribute|
          [attribute, payload.dig(*attribute_mappings[attribute])]
        }.to_h
      end
    end
  end  
end
