# frozen_string_literal: true

class Survey < ApplicationRecord
  belongs_to :user

  scope :active,    (-> { with_user.valid.where(active: true) })
  scope :with_user, (-> { includes(:user).where.not(user: nil) })
  scope :valid,     (-> { where.not(data: nil) })
  scope :type,      (->(type) { where(type: type) if type.present? })

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :email, to: :user, prefix: true, allow_nil: true

  after_initialize :initialize_data

  def initialize_data
    self['data'] ||= {}
  end

  def config
    {
      title: title,
      showProgressBar: "top",
      showQuestionNumbers: "false",
      cookieName: cookie_name,
      pages: surveyjs_pages,
      locale: "en",
      showTitle: false,
      showPageTitles: true
    }
  end

  def title
    "Generic Survey"
  end

  def short_code
    id.split('-').first
  end

  def chart_data
    []
  end

  def csv_row
    [type, user_name, finished_at, data]
  end

  def cookie_name
    [self.class.name.underscore, version].compact.join('_').prepend('_')
  end

  def version
    nil
  end

  def to_partial_path
    'surveys/survey'
  end

  class << self
    def types
      [Null, WorkshopRegistration, FourWeekFeedback, Graduation].freeze
    end

    def title(survey_title = "Generic Survey")
      return @title if @title.present?
      class_eval("def title;\"#{survey_title}\";end")
      @title = survey_title
    end

    def cookie_name(cookie_name = nil)
      if cookie_name
        class_eval("def cookie_name;\"#{cookie_name}\";end")
        return cookie_name
      end
      [name.underscore, 'session'].join('_').prepend('_')
    end

    # Use a counter cache mechanism to maintain statistics without
    # complex queries?
    def avg(key)
      return @_avg if @_avg && (@_key == key)
      @_key = key
      @_avg = (agg_data(key).inject(0.0) { |k, v| k + v }) / Float(agg_data(key).length)
    end

    def median(key)
      agg_data(key).sort[agg_data(key).length/2]
    end

    def var(key)
      agg_data(key).inject(0.0) { |k, v| k + (v - avg(key))**2 } / Float(agg_data(key).length)
    end

    def agg_data(key)
      results.map { |survey| survey[key].to_i }
    end

    def results
      @_results ||= types.flat_map(&:results)
    end
  end
end

class Null < Survey
  title 'Engineering Workshops'

  def to_partial_path
    'surveys/null_survey'
  end
end
