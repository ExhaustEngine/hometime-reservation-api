require "rails_helper"

RSpec.describe Parser::Mapping do
  describe ".process_payload!" do
    subject {
      described_class.process_payload!(payload: payload)
    }

    context "for FIRST_PAYLOAD" do
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
      let(:expected_guest_attributes) {
        {
          first_name: "Wayne",
          last_name: "Woodbridge",
          phone_numbers: "639123456789",
          email: "wayne_woodbridge@bnb.com"
        }
      }

      let(:expected_reservation_attributes) {
        {
          source_reservation_code: "YYY12345678",
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

      it 'should return the guest and reservation attributes' do
        expect(subject).to eq(
          [expected_guest_attributes, expected_reservation_attributes]
        )
      end
    end

    context "for SECOND_PAYLOAD" do
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
      let(:expected_guest_attributes) {
        {
          first_name: "Wayne",
          last_name: "Woodbridge",
          phone_numbers: "639123456789",
          email: "wayne_woodbridge@bnb.com"
        }
      }
      let(:expected_reservation_attributes) {
        {
          source_reservation_code: "XXX12345678",
          start_date: "2021-03-12",
          end_date: "2021-03-16",
          nights: 4,
          guests: 4,
          adults: 2,
          children: 2,
          infants: 0,
          status: "accepted",
          currency: "AUD",
          payout_price: "3800.00",
          security_price: "500.00",
          total_price: "4300.00"
        }
      }

      fit 'should return the guest and reservation attributes' do
        expect(subject).to eq(
          [expected_guest_attributes, expected_reservation_attributes]
        )
      end
    end
  end

  describe ".assign_attributes" do
    subject {
      described_class.assign_attributes(payload: payload, attribute_mappings: attribute_mappings)
    }

    context "assigning attributes for guest" do
      context "for FIRST_PAYLOAD" do
        let(:attribute_mappings) { Parser::FIRST_PAYLOAD[:guest] }
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

        it 'should map the values properly' do
          expect(subject).to eq(
            {
              email: "wayne_woodbridge@bnb.com",
              phone_numbers: "639123456789",
              first_name: "Wayne",
              last_name: "Woodbridge"
            }
          )
        end
      end

      context "for SECOND_PAYLOAD" do
        let(:attribute_mappings) { Parser::SECOND_PAYLOAD[:guest] }
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

        it 'should map the values properly' do
          expect(subject).to eq(
            {
              email: "wayne_woodbridge@bnb.com",
              phone_numbers: "639123456789",
              first_name: "Wayne",
              last_name: "Woodbridge"
            }
          )
        end
      end
    end

    context "assigning attributes for reservation" do
      let(:attribute_mappings) { Parser::FIRST_PAYLOAD[:reservation] }

      context "for FIRST_PAYLOAD" do
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

        it 'should map the values properly' do
          expect(subject).to eq(
            {
              source_reservation_code: "YYY12345678",
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
          )
        end
      end
    end
  end
end
