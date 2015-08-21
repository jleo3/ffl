module FFN
  class RBWorksheet

    def initialize(worksheet)
      @worksheet = worksheet
      @worksheet.title = "RB"
    end

    def save
      @worksheet.save
    end

    def populate_column_headers
      @worksheet[1,1] = "ID"
      @worksheet[1,2] = "Player"
      @worksheet[1,3] = "Team"

      @worksheet[1,4] = "Rush Yards"
      @worksheet[1,5] = "Rush TDs"
      @worksheet[1,6] = "Fumbles Lost"
      @worksheet[1,7] = "Receptions"
      @worksheet[1,8] = "Receiving Yards"
      @worksheet[1,9] = "Receiving TDs"

      @worksheet[1,10] = "Position Rank"
      @worksheet[1,11] = "Overall Rank"
    end

    def populate_players
      projections = FFNerd.draft_projections("RB")
      rankings = FFNerd.ppr_draft_rankings.select { |x| x.position == "RB" }

      projections.count.times do |i|
        player = projections[i]
        player_ranking = rankings.detect { |r| r.player_id == player.player_id }
        @worksheet[i+2,1] = player.player_id
        @worksheet[i+2,2] = player.display_name
        @worksheet[i+2,3] = player.team

        @worksheet[i+2,4] = player.rush_yards
        @worksheet[i+2,5] = player.rush_td
        @worksheet[i+2,6] = player.fumbles
        @worksheet[i+2,7] = player.rec
        @worksheet[i+2,8] = player.rec_yards
        @worksheet[i+2,9] = player.rec_td

        @worksheet[i+2,10] = player_ranking.position_rank
        @worksheet[i+2,11] = player_ranking.overall_rank
      end
    end

  end
end

=begin
#<OpenStruct playerId="2313", rushAtt="275", rushYards="1245", rushTD="10", fumbles="1", rec="42", recYards="344", recTD="2", fantasyPoints="229", displayName="Eddie Lacy", team="GB", player_id="2313", rush_att="275", rush_yards="1245", rush_td="10", rec_yards="344", rec_td="2", fantasy_points="229", display_name="Eddie Lacy">
#
=end

