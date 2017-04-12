class Page
  attr_accessor :title, :name, :questions

  def initialize(title:, name:, questions: [])
    @name = name
    @title = title
    @questions = questions
  end

  def to_h
    {
      title: title,
      questions: questions.map(&:to_h)
    }
  end
end
