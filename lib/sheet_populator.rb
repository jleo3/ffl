module FFN
  class SheetPopulator
    def initialize(doc)
      @worksheet = doc.worksheets[0]
    end

    def populate
      @worksheet.title = "QB"
      populate_column_headers
      populate_players

      @worksheet.save
    end

    private

    def populate_column_headers
      @worksheet[1,1] = "ID"
      @worksheet[1,2] = "Player"
      @worksheet[1,3] = "Team"
      @worksheet[1,4] = "Completions"
      @worksheet[1,5] = "Passing Yards"
      @worksheet[1,6] = "Passing TDs"
      @worksheet[1,7] = "INT"
      @worksheet[1,8] = "Rush Yards"
      @worksheet[1,9] = "Rush TDs"
      @worksheet[1,10] = "Fumbles Lost"
      @worksheet[1,11] = "Position Rank"
      @worksheet[1,12] = "Overall Rank"
    end

    def populate_players
      projections = FFNerd.draft_projections("QB")
      rankings = FFNerd.ppr_draft_rankings.select { |x| x.position == "QB" }

      projections.count.times do |i|
        player = projections[i]
        player_ranking = rankings.detect { |r| r.player_id == player.player_id }
        @worksheet[i+2,1] = player.player_id
        @worksheet[i+2,2] = player.display_name
        @worksheet[i+2,3] = player.team
        @worksheet[i+2,4] = player.completions
        @worksheet[i+2,5] = player.passing_yards
        @worksheet[i+2,6] = player.passing_td
        @worksheet[i+2,7] = player.passing_int
        @worksheet[i+2,8] = player.rush_yards
        @worksheet[i+2,9] = player.rush_td
        @worksheet[i+2,10] = player.fumbles
        @worksheet[i+2,11] = player_ranking.position_rank
        @worksheet[i+2,12] = player_ranking.overall_rank
      end
    end
  end
end

