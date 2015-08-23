module FFN
  class RBWorksheet < PlayerWorksheet

    def initialize(position, worksheet, average_draft_positions)
      super(position, worksheet, average_draft_positions)

      @ranking_column_start = 10
      @headers = display_headers + rb_headers + ranking_headers
      @values = display_values + rb_values
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

