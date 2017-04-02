# Allow for a user to take a series of surveys
# depending on where they are in a process
#
# User can only take a type of survey one time
#
# current_user is kept as jwt in session cookie?
# Use knock?
#
# The SurveyController determines the next survey not taken
# SurveyController#next_survey_for(current_user)
#
# Ask for email address if a completed survey cookies
# is found, but there is not a current user jwt token:
# <--
# You've completed the Workshop Registration Survey.
# Please complete the Workshop 4-Week Feedback Survey.
#
# email: [________]
# -->
#
# A User takes(has_many) :surveys
# Survey STI with type: string
#
# Each type cooresponds with a SurveyTypeTemplate name:string,
# questions: jsonb, config: jsonb

# Survey#questions for the :workshop_registration type is aliases
# to WorkshopRegistrationSurveyTemplate#questions
#
# Admin can see the results of different surveys
# A sort by type admin ui (possibly with turbo links or vuejs)
#
# If a user has taken mutliple surveys with common questions
# there is a way to see an overlaid radar chart of the results.
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
    # alias to template_questions?
    QUESTIONS.map do |value, text|
      { 'value': value.to_s, 'text': text.to_s }
    end
  end

  # move statistics to the SurveyTypeApplicationTemplate?
  # WorkshopRegistrationTemplate.avg
  # Use a counter cache mechanism to maintain statistics without
  # complex queries?
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
    # template_questions.chart_data
    QUESTIONS.keys.map do |key|
      data.fetch(key.to_s, "0").to_i
    end
  end
end
