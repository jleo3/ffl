module FFN
  class WRWorksheet < PlayerWorksheet

    def initialize(position, worksheet, average_draft_positions)
      super(position, worksheet, average_draft_positions)

      @headers = display_headers + wr_headers + ranking_headers
      @values = display_values + wr_values
    end

    def populate_players
      @projections.count.times do |i|
        player = @projections[i]
        populate_stats(player, i)
        populate_ranking(player, i, 10)
      end
    end

    private

    def wr_headers
      ["Receptions", "Receiving Yards", "Receiving TDs","Rush Yards",
       "Rush TDs", "Fumbles Lost"]
    end

    def wr_values
      [:rec, :rec_yards, :rec_td, :rush_yards, :rush_td, :fumbles]
    end

  end
end

