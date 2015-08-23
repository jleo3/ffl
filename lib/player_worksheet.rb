module FFN
  class PlayerWorksheet

    attr_reader :position

    def initialize(position, worksheet, average_draft_positions)
      @position = position
      @adp = average_draft_positions.select { |x| x.position == position }
      @projections = FFNerd.draft_projections(position)
      @worksheet = worksheet
      @worksheet.title = position
    end

    def save
      @worksheet.save
    end

    def populate_players
      @projections.count.times do |i|
        player = @projections[i]
        populate_stats(player, i)
        populate_ranking(player, i, @ranking_column_start)
      end
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

    def display_headers
      ["ID", "Player", "Team"]
    end

    def display_values
      [:player_id, :display_name, :team]
    end

    def ranking_headers
      ["Overall ADP", "Poition ADP"]
    end
  end
end

