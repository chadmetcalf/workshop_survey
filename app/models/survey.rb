class Survey < ApplicationRecord
  QUESTIONS = { ci: 'Continuous Integration',
                refactor: 'Refactoring',
                twelve_factor: '12 Factor App',
                benchmark: 'Benchmarking',
                authn: 'Authentication',
                pci: 'PCI Compliance' }

  belongs_to :user

  scope :has_user, -> { includes(:user).where.not(user: nil) }
  scope :valid,    -> { where.not(data: nil) }

  def self.surveyjs_matrix_questions
    QUESTIONS.map do |value, text|
      { 'value': value.to_s, 'text': text.to_s }
    end
  end

  delegate :name, to: :user, prefix: true, allow_nil: true

  def short_code
    id.split('-').first
  end

  def chart_data
    QUESTIONS.keys.map do |key|
      data.fetch(key.to_s, "0").to_i
    end
  end
end
