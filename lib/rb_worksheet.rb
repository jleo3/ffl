module FFN
  class RBWorksheet < PlayerWorksheet

    def initialize(position, worksheet, average_draft_positions)
      super(position, worksheet, average_draft_positions)

      @headers = display_headers + rb_headers + ranking_headers
      @values = display_values + rb_values
    end

    def populate_players
      @projections.count.times do |i|
        player = @projections[i]
        populate_stats(player, i)
        populate_ranking(player, i, 10)
      end
    end

    private

    def rb_headers
      ["Rush Yards", "Rush TDs", "Fumbles Lost", "Receptions",
       "Receiving Yards", "Receiving TDs"]
    end

    def rb_values
      [:rush_yards, :rush_td, :fumbles, :rec, :rec_yards, :rec_td]
    end

  end
end

