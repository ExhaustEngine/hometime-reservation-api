require "rails_helper"

RSpec.describe Parser::Validation do
  describe ".get_and_validate_matched_mapping" do
    subject {
      described_class.get_and_validate_matched_mapping(payload: payload)
    }

    context "when payload matches FIRST_PAYLOAD" do
      let(:payload) {
        {
          guest: {
            first_name: "Wayne",
            last_name: "Woodbridge",
            phone: "639123456789",
            email: "wayne_woodbridge@bnb.com"
          },
          reservation_code: "YYY12345678",
          start_date: "2021-04-14",
          end_date: "2021-04-18",
          nights: 4,
          guests: 4,
          adults: 2,
          children: 2,
          infants: 0,
          status: "accepted",
          currency: "AUD",
          payout_price: "4200.00",
          security_price: "500",
          total_price: "4700.00"
        }
      }

      it 'should get the first payload mapping' do
        expect(subject).to eq(Parser::FIRST_PAYLOAD)
      end
    end

    context "when payload matches SECOND_PAYLOAD" do
      let(:payload) {
        {
          reservation: {
            guest_first_name: "Wayne",
            guest_last_name: "Woodbridge",
            guest_phone_numbers: "639123456789",
            guest_email: "wayne_woodbridge@bnb.com",
            code: "XXX12345678",
            start_date: "2021-03-12",
            end_date: "2021-03-16",
            expected_payout_amount: "3800.00",
            guest_details: {
              localized_description: "4 guests",
              number_of_adults: 2,
              number_of_children: 2,
              number_of_infants: 0
            },
            listing_security_price_accurate: "500.00",
            host_currency: "AUD",
            nights: 4,
            number_of_guests: 4,
            status_type: "accepted",
            total_paid_amount_accurate: "4300.00"
          }
        }
      }

      it 'should get the second payload mapping' do
        expect(subject).to eq(Parser::SECOND_PAYLOAD)
      end
    end

    context "when payload has NO match" do
      let(:payload) {
        {
          payload_sample: "sample"
        }
      }

      it 'should return nil' do
        expect(subject).to eq(nil)
      end
    end
  end

  describe ".valid_entity_mappings?" do
    subject {
      described_class.valid_entity_mappings?(
        payload: payload,
        mappings: mappings
      )
    }

    context "validating guest mappings" do
      let(:mappings) { Parser::FIRST_PAYLOAD[:guest] }

      context "when expecting FIRST_PAYLOAD" do
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

      context "when expecting SECOND_PAYLOAD" do
        let(:mappings) { Parser::SECOND_PAYLOAD[:guest] }
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

        it 'should return true' do
          expect(subject).to be_truthy
        end

        context "when payload with different structure is passed" do
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
  
          it 'should return false' do
            expect(subject).to be_falsey
          end
        end

        context "when payload have missing attributes" do
          let(:payload) {
            {
              reservation: {
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
      end
    end

    context "validating reservation" do
      let(:mappings) { Parser::FIRST_PAYLOAD[:reservation] }

      context "when expecting FIRST_PAYLOAD" do
        let(:payload) {
          {
            reservation_code: "YYY12345678",
            start_date: "2021-04-14",
            end_date: "2021-04-18",
            nights: 4,
            guests: 4,
            adults: 2,
            children: 2,
            infants: 0,
            status: "accepted",
            currency: "AUD",
            payout_price: "4200.00",
            security_price: "500",
            total_price: "4700.00"
          }
        }

        it 'should return true' do
          expect(subject).to be_truthy
        end

        context "when payload with different structure is passed" do
          let(:payload) {
            {
              reservation: {
                code: "XXX12345678",
                start_date: "2021-03-12",
                end_date: "2021-03-16",
                expected_payout_amount: "3800.00",
                guest_details: {
                  localized_description: "4 guests",
                  number_of_adults: 2,
                  number_of_children: 2,
                  number_of_infants: 0
                },
                listing_security_price_accurate: "500.00",
                host_currency: "AUD",
                nights: 4,
                number_of_guests: 4,
                status_type: "accepted",
                total_paid_amount_accurate: "4300.00"
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
              reservation_code: "YYY12345678",
              start_date: "2021-04-14",
              end_date: "2021-04-18",
              nights: 4,
              guests: 4,
              adults: 2,
              children: 2,
              infants: 0,
              status: "accepted",
              currency: "AUD",
              payout_price: "4200.00",
              security_price: "500"
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
