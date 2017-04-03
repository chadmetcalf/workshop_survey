class UserSurveySelector
  def self.process(**args)
    new(args).process
  end

  def initialize(params: {}, cookies: [])
    @params = params
    @cookies = cookies
  end

  def process
    return survey_from_param_type if param_type?
    return survey_from_cookies if survey_cookies?
    WorkshopRegistration.new
  end

  def param_type?
    @params.has_key?('type')
    Survey.types.include?(@params['type'])
  end

  def survey_from_param_type
    @params['type'].safe_constantize.new
  end

  def survey_from_cookies
    surveys.first.safe_constantize.new
  end

  def survey_cookies?
    surveys.delete_if do |klass_name|
      @cookies[klass_name.safe_constantize.cookie_name] == 'true'
    end
  end

  def surveys
    @surveys ||= Survey.types.dup
  end
end
