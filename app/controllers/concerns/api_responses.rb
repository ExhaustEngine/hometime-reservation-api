module ApiResponses
  extend ActiveSupport::Concern

  def unprocessable(error = nil)
    error_message = determine_error(error) || "Unprocessable Entity"
    render json: { error: error_message }, status: :unprocessable_entity
  end

  def determine_error(error)
    return if error.nil? || error.try(:message) == error.class.name
    return error.message if error.respond_to?(:message)
    return error.messages.first if error.respond_to?(:messages)
    error
  end

  def self.included(base)
    base.rescue_from Errors::UnprocessableEntity, with: :unprocessable
    base.rescue_from ActiveRecord::RecordInvalid, with: :unprocessable
  end
end