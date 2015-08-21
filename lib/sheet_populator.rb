module FFN
  class SheetPopulator

    def initialize(doc)
      @qb_worksheet = QBWorksheet.new(doc.worksheets[0])
      @rb_worksheet = RBWorksheet.new(doc.worksheets[1])
    end

    def populate
      @qb_worksheet.populate_column_headers
      @qb_worksheet.populate_players
      @qb_worksheet.save

      @rb_worksheet.populate_column_headers
      @rb_worksheet.populate_players
      @rb_worksheet.save
    end

  end
end

