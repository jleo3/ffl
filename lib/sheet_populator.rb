module FFN
  class SheetPopulator

    def initialize(doc)
      @doc = doc
      @average_draft_positions = FFNerd.ppr_draft_rankings
    end

    def populate
      %w(QB RB WR TE DEF).each_with_index do |position, i|
        ws = Object.const_get("FFN::" + position + "Worksheet").new(position, @doc.worksheets[i], @average_draft_positions)
        print "\nPopulating #{ws.position}..."
        ws.populate_column_headers
        ws.populate_players
        ws.save
        print "Complete!"
      end
    end

  end
end

