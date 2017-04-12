module Questions
  class Boolean < Question
    def to_partial_path
      'surveys/questions/boolean'
    end

    def type
      'radiogroup'
    end

    def to_h
      super.merge(colCount: 4,
                  choices: %w(Yes No))
    end
  end
end
