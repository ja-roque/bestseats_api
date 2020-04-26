class Venue
  attr_accessor :row_count, :column_count, :available_seats_hash, :data
  ALPH = ("a".."z").to_a

  def initialize( venue_data )
    @row_count = venue_data.dig(:venue, :layout, :rows)
    @column_count = venue_data.dig(:venue, :layout, :columns)

    char_to_num = ALPH.zip((0..@column_count*@row_count).step(@column_count).to_a).to_h

    @available_seats_hash = venue_data[:seats]

    venue = Array.new(@row_count)
    @data = venue.each_with_index do |_, rowindex|

      venue[rowindex] = Array.new(@column_count) do |colindex|
        id = "#{ALPH[rowindex]}#{colindex+1}".to_sym
        Seat.new( (rowindex * @column_count) + colindex, id, rowindex, colindex, @available_seats_hash[id].present? )
      end

    end

    @all_seats = @data.flatten
    @available_seats = @available_seats_hash.map { |id, data| @all_seats[char_to_num[data[:row]] + data[:column]-1] }
    @best_seat = get_best_seat
  end

  

end