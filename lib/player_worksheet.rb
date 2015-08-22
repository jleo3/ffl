module FFN
  class PlayerWorksheet

    def save
      @worksheet.save
    end

    def populate_column_headers
      @headers.each_with_index do |header, i|
        @worksheet[1,i+1] = header
      end
    end

    def populate_stats(player, row_index)
      @values.each_with_index do |value, j|
        @worksheet[row_index+2,j+1] = player.public_send(value)
      end
    end

    def populate_ranking(player, row_index, column_index)
      player_ranking = @adp.detect { |r| r.player_id == player.player_id }
      if !!player_ranking
        @worksheet[row_index+2,column_index] = player_ranking.overall_rank
        @worksheet[row_index+2,column_index+1] = player_ranking.position_rank
      end
    end

  end
end

