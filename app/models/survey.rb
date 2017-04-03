# frozen_string_literal: true
class Survey < ApplicationRecord
  belongs_to :user

  scope :active, -> { has_user.valid.where(active: true) }
  scope :has_user, -> { includes(:user).where.not(user: nil) }
  scope :valid,    -> { where.not(data: nil) }

  delegate :name, to: :user, prefix: true, allow_nil: true

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
    questions.keys.map do |key|
      data.fetch(key.to_s, "0").to_i
    end
  end

  def cookie_name
    [self.class.name.underscore, 'session'].join('_').prepend('_')
  end

  class << self
    def types
      distinct.pluck(:type)
    end

    def title(survey_title = "Generic Survey")
      class_eval("def title;\"#{survey_title}\";end")
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
      @_avg = (data(key).inject(0.0) { |k, v| k + v }) / Float(data(key).length)
    end

    def median(key)
      data(key).sort[data(key).length/2]
    end

    def var(key)
      data(key).inject(0.0) { |k, v| k + (v - avg(key))**2 } / Float(data(key).length)
    end

    def data(key)
      results.map { |survey| survey[key].to_i }
    end

    def results
      @_results ||= Survey.active.pluck(:data)
    end
  end
end
