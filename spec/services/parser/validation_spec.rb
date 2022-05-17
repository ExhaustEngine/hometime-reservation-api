require "rails_helper"

RSpec.describe Parser::Validation do
  describe ".valid_entity_mappings?" do
    subject {
      described_class.valid_entity_mappings?(
        payload: payload,
        mappings: mappings
      )
    }

    context "validating guest mappings" do
      context "when passing FIRST_PAYLOAD" do
        let(:mappings) { Parser::FIRST_PAYLOAD[:guest] }
        let(:payload) {
          {
            guest: {
              first_name: "Wayne",
              last_name: "Woodbridge",
              phone: "639123456789",
              email: "wayne_woodbridge@bnb.com"
            }
          }
        }

        it 'should return true' do
          expect(subject).to be_truthy
        end

        context "when payload with different structure is passed" do
          let(:payload) {
            {
              reservation: {
                guest_first_name: "Wayne",
                guest_last_name: "Woodbridge",
                guest_phone_numbers: "639123456789",
                guest_email: "wayne_woodbridge@bnb.com"
              }
            }
          }
  
          it 'should return false' do
            expect(subject).to be_falsey
          end
        end

        context "when payload have missing attributes" do
          let(:payload) {
            {
              guest: {
                last_name: "Woodbridge",
                phone: "639123456789",
                email: "wayne_woodbridge@bnb.com"
              }
            }
          }
  
          it 'should return false' do
            expect(subject).to be_falsey
          end
        end
      end
    end
  end
end
