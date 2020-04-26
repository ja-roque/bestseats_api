require 'rails_helper'

RSpec.describe Seat, type: :model do
  context "Seat" do
    it 'should create a new seat with valid params ' do
      new_seat = Seat.new(0,'a1',1,1)
      expect(new_seat).to be_an_instance_of(Seat)
    end

  end

end
