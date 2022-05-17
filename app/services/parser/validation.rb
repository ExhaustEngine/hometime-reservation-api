module Parser
  module Validation
    class << self
      def get_and_validate_matched_mapping!(payload:)
        mapping = Parser::REGISTERED_MAPPINGS.find { |payload_mapping|
          matched_payload_mapping?(payload_mapping: payload_mapping)
        }

        if mapping.nil?
          # raise Errors::UnprocessableEntity, "Payload is not valid. Please contact the app admin to register payload structure."
        end

        mapping
      end

      def matched_payload_mapping?(payload_mapping:)
        guest_mappings       = payload_mapping[:guest]
        reservation_mappings = payload_mapping[:reservation]

        valid_guest       = valid_entity_mappings?(payload: payload, mappings: guest_mappings)
        valid_reservation = valid_entity_mappings?(payload: payload, mappings: reservation_mappings)

        valid_guest && valid_reservation
      end

      def valid_entity_mappings?(payload:, mappings:)
        expected_attributes = mappings.keys

        expected_attributes.all? { |attribute|
          keys = mappings[attribute]

          if keys.is_a?(Array)
            parent_keys  = keys.slice(0, keys.length - 1)
            expected_key = keys.last
            next payload.dig(*parent_keys)&.key?(expected_key)
          end

          next payload[keys].present?
        }
      end
    end
  end
end