if defined? Survey
  %w(WorkshopRegistration FourWeekFeedback Null).each do |survey_type|
    Survey.find_or_create_by(active: false, type: survey_type)
  end
end
