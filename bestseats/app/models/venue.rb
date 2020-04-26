class Venue
  attr_accessor :row_count, :column_count, :available_seats_hash, :data

  def initialize( venue_data )
    @row_count = venue_data.dig(:venue, :layout, :rows)
    @column_count = venue_data.dig(:venue, :layout, :columns)
    @available_seats_hash = venue_data[:seats]

    venue = Array.new(@row_count)
    @data = venue.each_with_index do |_, rowindex|

      venue[rowindex] = Array.new(@column_count) do |colindex|
        id = "#{ALPH[rowindex]}#{colindex+1}".to_sym
        Seat.new( (rowindex * @column_count) + colindex, id, rowindex, colindex, @available_seats_hash[id].present? )
      end

    end
  end

end