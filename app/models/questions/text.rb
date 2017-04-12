module Questions
  class Text < Question
    def to_partial_path
      'surveys/questions/text'
    end

    def type
      'comment'
    end

    def to_h
      super.merge(colCount: 4, choices: %w(Yes No))
    end
  end
end
