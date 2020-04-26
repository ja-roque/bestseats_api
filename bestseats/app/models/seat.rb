class Seat
  attr_accessor :best, :sequence_num, :seat_id, :row_num, :col_num, :available

  def initialize( sequence_num, seat_id, row_num, col_num, available = false, best = false )
    @best = best
    @sequence_num = sequence_num
    @seat_id = seat_id
    @row_num = row_num
    @col_num = col_num
    @available = available
  end

end