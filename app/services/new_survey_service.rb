class NewSurveyService
  def self.process(**args)
    new(args).process
  end

  def initialize(user:, params: {}, cookies: [])
    @user ||= user || User.new
    @params = params
    @cookies = cookies
  end

  def process
    Survey.new(type: next_survey_type)
  end

  def next_survey_type
    return next_survey_type_from_params  if use_params_survey_type?
    return next_survey_type_from_user    if use_user_survey_type?
    return next_survey_type_from_cookies if use_cookie_survey_type?
    Null
  end

  def use_params_survey_type?
    survey_types.map(&:name).include?(@params['type'])
  end

  def use_cookie_survey_type?
    survey_types_taken_from_cookies.any? && next_survey_type_from_cookies.present?
  end

  def use_user_survey_type?
    survey_types_taken_by_user.any? && next_survey_type_from_user.present?
  end

  def next_survey_type_from_params
    @params['type']
  end

  def next_survey_type_from_cookies
    (survey_types - survey_types_taken_from_cookies).first
  end

  def next_survey_type_from_user
    (survey_types - survey_types_taken_by_user).first
  end

  def survey_types_taken_by_user
    @_uttby ||= @user.surveys.pluck(:types)
  end

  def survey_types_taken_from_cookies
    survey_types.select do |type|
      @cookies[type.cookie_name] == 'true'
    end
  end

  def survey_types_not_taken
    survey_types - [Null, *survey_types_taken_by_user, *survey_types_taken_from_cookies]
  end

  def survey_types
    Survey.types
  end
end
