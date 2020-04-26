require 'rails_helper'

RSpec.describe Venue, type: :model do
  context "Venue" do
    it 'should create a new Venue with a valid JSON input of available seats' do
      new_venue = Venue.new(test_params)
      expect(new_venue).to be_an_instance_of(Venue)
    end

    it 'should generate a list of all the possible seats' do
      new_venue = Venue.new(test_params)
      expect(new_venue.all_seats.length).to be( test_params[:venue][:layout][:rows] * test_params[:venue][:layout][:columns] )
    end

    it 'should fetch the best possible seat position' do
      new_venue = Venue.new(test_params)
      expect(new_venue.best_seat.seat_id).to be( :'a25' )
    end

    it 'should generate a list of available seats as objects' do
      new_venue = Venue.new(test_params)
      expect(new_venue.available_seats).to all(be_a(Seat))
    end

    it 'should generate a list if available seats as objects with same length of JSON availables' do
      new_venue = Venue.new(test_params2)
      expect(new_venue.available_seats.length).to be test_params2[:seats].length
    end

  end

  context 'Venue#find_best_available_seats' do
    it 'should get the best available seat when one seat is requested' do
      new_venue = Venue.new(test_params2)
      expect(new_venue.find_best_available_seats(1).first.first.seat_id).to eq :'b6'
    end

    it 'should get the best available seat group when more than one seat is requested' do
      new_venue = Venue.new(test_params2)
      expect(new_venue.find_best_available_seats(3).map(&:seat_id)).to eq [:h9, :h8, :h7]
    end
  end
end

def test_params
  {
      venue: {
          :layout => {
              :rows => 10,
              :columns => 50
          }
      },
      seats: {
          a1: {
              id: "a1",
              row: "a",
              column: 1,
              status: "AVAILABLE"
          },
          b5: {
              id: "b5",
              row: "b",
              column: 5,
              status: "AVAILABLE"
          },
          h7: {
              id: "h7",
              row: "h",
              column: 7,
              status: "AVAILABLE"
          }
      }
  }
end

def test_params2
  {
      venue: {
          :layout => {
              :rows => 10,
              :columns => 50
          }
      },
      seats: {
          a1: {
              id: "a1",
              row: "a",
              column: 1,
              status: "AVAILABLE"
          },
          b5: {
              id: "b5",
              row: "b",
              column: 5,
              status: "AVAILABLE"
          },
          b6: {
              id: "b6",
              row: "b",
              column: 6,
              status: "AVAILABLE"
          },
          h7: {
              id: "h7",
              row: "h",
              column: 7,
              status: "AVAILABLE"
          },
          "h8": {
              id: "h8",
              row: "h",
              column: 8,
              status: "AVAILABLE"
          },
          h9: {
              id: "h9",
              row: "h",
              column: 9,
              status: "AVAILABLE"
          }
      }
  }
end