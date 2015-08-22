module FFN
  class SheetPopulator

    def initialize(doc)
      average_draft_positions = FFNerd.ppr_draft_rankings

      @qb_worksheet = QBWorksheet.new(
                        doc.worksheets[0],
                        average_draft_positions)

      @rb_worksheet = RBWorksheet.new(
                        doc.worksheets[1],
                        average_draft_positions)

      @wr_worksheet = WRWorksheet.new(
                        doc.worksheets[2],
                        average_draft_positions)

      @te_worksheet = TEWorksheet.new(
                        doc.worksheets[3],
                        average_draft_positions)

      @def_worksheet = DEFWorksheet.new(
                        doc.worksheets[4],
                        average_draft_positions)
    end

    def populate
      [@qb_worksheet, @rb_worksheet,
       @wr_worksheet, @te_worksheet,
       @def_worksheet].each do |ws|
        ws.populate_column_headers
        ws.populate_players
        ws.save
      end
    end

  end
end

