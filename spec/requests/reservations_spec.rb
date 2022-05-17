require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "POST /create" do
    subject { post "/reservations", params: payload }

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

      it 'is expected to create the guest and reservation record' do
        expect { subject }.to change { Guest.all.count }.from(0).to(1)
          .and change { Reservation.all.count }.from(0).to(1)

        expect(response).to have_http_status(:ok)

        guest = Guest.first
        expect(guest).to have_attributes(
          email: "wayne_woodbridge@bnb.com",
          first_name: "Wayne",
          last_name: "Woodbridge",
          phone_numbers: "639123456789",
        )
        expect(Reservation.first).to have_attributes(
          source_reservation_code: "YYY12345678",
          guest_id: guest.id,
          start_date: be_within(1.day).of(DateTime.parse("2021-04-14")),
          end_date: be_within(1.day).of(DateTime.parse("2021-04-18")),
          nights: 4,
          guests: 4,
          adults: 2,
          children: 2,
          infants: 0,
          status: "accepted",
          currency: "AUD",
          payout_price: 4200.00,
          security_price: 500,
          total_price: 4700.00
        )
      end

      context "when a field is missing" do
        let(:payload) {
          {
            guest: {
              first_name: "Wayne",
              last_name: "Woodbridge",
              phone: "639123456789",
              email: "wayne_woodbridge@bnb.com"
            },
            reservation_code: "YYY12345678",
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

        it 'should fail' do
          expect { subject }.to not_change { Guest.all.count }.from(0)
            .and not_change { Reservation.all.count }.from(0)

          expect(response).to have_http_status(:unprocessable_entity)

          parsed_body = JSON.parse(response.body)
          expect(parsed_body['error']).to eq("Payload is invalid. Please contact the admin of this API.")
        end
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

      it 'is expected to create the guest and reservation record' do
        expect { subject }.to change { Guest.all.count }.from(0).to(1)
          .and change { Reservation.all.count }.from(0).to(1)
        
        expect(response).to have_http_status(:ok)

        guest = Guest.first
        expect(guest).to have_attributes(
          email: "wayne_woodbridge@bnb.com",
          first_name: "Wayne",
          last_name: "Woodbridge",
          phone_numbers: "639123456789",
        )
        expect(Reservation.first).to have_attributes(
          source_reservation_code: "XXX12345678",
          guest_id: guest.id,
          start_date: be_within(1.day).of(DateTime.parse("2021-03-12")),
          end_date: be_within(1.day).of(DateTime.parse("2021-03-16")),
          nights: 4,
          guests: 4,
          adults: 2,
          children: 2,
          infants: 0,
          status: "accepted",
          currency: "AUD",
          payout_price: 3800.00,
          security_price: 500,
          total_price: 4300.00
        )
      end

      context "when a field is missing" do
        let(:payload) {
          {
            reservation: {
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

        it 'should fail' do
          expect { subject }.to not_change { Guest.all.count }.from(0)
            .and not_change { Reservation.all.count }.from(0)

          expect(response).to have_http_status(:unprocessable_entity)

          parsed_body = JSON.parse(response.body)
          expect(parsed_body['error']).to eq("Payload is invalid. Please contact the admin of this API.")
        end
      end
    end

    context "when invalid payload" do
      let(:payload) {
        {
          sample_key: "Random Value"
        }
      }

      it 'should fail' do
        expect { subject }.to not_change { Guest.all.count }.from(0)
          .and not_change { Reservation.all.count }.from(0)

        expect(response).to have_http_status(:unprocessable_entity)

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq("Payload is invalid. Please contact the admin of this API.")
      end
    end
  end
end
