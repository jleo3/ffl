module FFN
  class QBWorksheet < PlayerWorksheet

    def initialize(position, worksheet, average_draft_positions)
      super(position, worksheet, average_draft_positions)

      @headers = display_headers + qb_headers + ranking_headers
      @values = display_values + qb_values
    end

    def populate_players
      @projections.count.times do |i|
        player = @projections[i]
        populate_stats(player, i)
        populate_ranking(player, i, 11)
      end
    end

    private

    def qb_headers
      ["Completions", "Passing Yards", "Passing TDs", "INT",
       "Rush Yards", "Rush TDs", "Fumbles Lost"]
    end

    def qb_values
      [:completions, :passing_yards, :passing_td, :passing_int,
       :rush_yards, :rush_td, :fumbles]
    end

  end
end

