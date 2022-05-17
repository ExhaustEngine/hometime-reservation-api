module Parser
  module Mapping
    class << self
      def mapped_payload(payload:)
        mapping = Parser::Validation.get_and_validate_matched_mapping(payload: payload)

        # TODO: mapping values to model
      end
    end
  end  
end
