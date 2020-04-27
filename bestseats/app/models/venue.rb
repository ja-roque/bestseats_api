class Venue
  attr_accessor :row_count, :column_count, :available_seats_hash, :data, :best_seat, :all_seats, :available_seats
  ALPH = ("a".."z").to_a

  def initialize( venue_data )
    venue_data =  venue_data.to_h

    @row_count = venue_data.dig(:venue, :layout, :rows)&.to_i
    @column_count = venue_data.dig(:venue, :layout, :columns)&.to_i

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
    @available_seats = @available_seats_hash.map { |id, data| @all_seats[char_to_num[data[:row]] + data[:column]&.to_i - 1] }
    @best_seat = get_best_seat
  end

  def find_best_available_seats(count)
    seats_with_distance = @available_seats.map{ |available_seat| [available_seat, (available_seat.row_num - @best_seat.row_num).abs + (available_seat.col_num - @best_seat.col_num).abs] }
    puts seats_with_distance
    sorted_seats_by_distance = seats_with_distance.sort_by { |seat| seat.last }
    if count > 1
      best_group = get_best_group(sorted_seats_by_distance, @all_seats, count)
      return best_group if best_group
    end
    best_seat = sorted_seats_by_distance.first(count).each{ |seat| seat.first.best = true}
    best_seat
  end

  private

  def get_best_seat
    @data.first[(@data.first.length - 1)/2]
  end

  def get_best_group(sorted_seats_by_distance, all_seats, count)
    checked_seats = []
    sorted_seats_by_distance.each do |good_seat|
      good_seat = good_seat.first
      next if checked_seats.include? good_seat

      seat_group = [good_seat]

      1.upto(count) do |i|
        ungroupable = []

        left_seat = all_seats[good_seat.sequence_num - i]
        right_seat = all_seats[good_seat.sequence_num + i]

        unless ungroupable.include?(left_seat) || seat_group.include?(left_seat)
          if left_seat.row_num == good_seat.row_num && left_seat.available
            seat_group << left_seat
            checked_seats << left_seat
            added_new_seat = true
            if seat_group.length == count
              seat_group.each { |seat| seat.best = true }
              puts seat_group.each(&:best)
              return seat_group
            end
          else
            ungroupable << left_seat
          end
        end

        unless ungroupable.include?(right_seat) || seat_group.include?(right_seat)
          if right_seat.row_num == good_seat.row_num && right_seat.available
            seat_group << right_seat
            checked_seats << left_seat
            added_new_seat = true
            if seat_group.length == count
              seat_group.each { |seat| seat.best = true }
              puts seat_group.each(&:best)
              return seat_group
            end
          else
            ungroupable << right_seat
          end
        end

        break unless added_new_seat
      end


    end

    nil
  end

end