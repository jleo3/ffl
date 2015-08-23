module FFN
  class QBWorksheet < PlayerWorksheet

    def initialize(position, worksheet, average_draft_positions)
      super(position, worksheet, average_draft_positions)

      @ranking_column_start = 11
      @headers = display_headers + qb_headers + ranking_headers
      @values = display_values + qb_values
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

