class Survey < ApplicationRecord
  QUESTIONS = { ci: 'Continuous Integration',
                refactor: 'Refactoring',
                twelve_factor: '12 Factor App',
                benchmark: 'Benchmarking',
                authn: 'Authentication',
                pci: 'PCI Compliance' }

  belongs_to :user

  scope :active, -> { has_user.valid.where(active: true) }
  scope :has_user, -> { includes(:user).where.not(user: nil) }
  scope :valid,    -> { where.not(data: nil) }

  def self.surveyjs_matrix_questions
    QUESTIONS.map do |value, text|
      { 'value': value.to_s, 'text': text.to_s }
    end
  end

  def self.avg(key)
    return @_avg if @_avg && (@_key == key)
    @_key = key
    @_avg = (data(key).inject(0.0) { |k, v| k + v }) / Float(data(key).length)
  end

  def self.median(key)
    data(key).sort[data(key).length/2]
  end

  def self.var(key)
    data(key).inject(0.0) { |k, v| k + (v - avg(key))**2 } / Float(data(key).length)
  end

  def self.data(key)
    results.map { |survey| survey[key].to_i }
  end

  def self.results
    @_results ||= Survey.active.pluck(:data)
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
