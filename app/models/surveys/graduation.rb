# frozen_string_literal: true
class Graduation < Survey
  delegate :surveyjs_pages, to: :class
  delegate :data_param_keys, to: :class

  title 'Pilot Completion'

  def version
    '1'
  end

  def to_partial_path
    'surveys/graduation'
  end

  def baseline_question
    Questions::Baseline.new(data: (data['baseline'] || data))
  end

  def chart_data
    [baseline_question.data.values,
     workshop_registration_chart_data].compact
  end

  def workshop_registration_chart_data
    user.workshop_registration.try(:chart_data)
  end

  def feedback_questions
    [
      Questions::Boolean.new(data: data.fetch('value', nil),
                             title: 'Is there enough value in the workshops to roll the program out to more folks?',
                             name:  'value'),
      Questions::Boolean.new(data: data.fetch('impact', nil),
                             title: 'Have the workshops had an influence on how you approach your work?',
                             name:  'impact'),
      Questions::Text.new(data: data.fetch('group_size', nil),
                          title: 'How has the group size affected discussion?',
                          name:  'group_size'),
      Questions::Text.new(data: data.fetch('learning_culture', nil),
                          title: 'What areas have the workshops had a role in triggering your curiosity?',
                          name:  'learning_culture'),
      Questions::Text.new(data: data.fetch('time_commitment', nil),
                          title: 'How has the time commitment impacted your other responsibilities?',
                          name:  'time_commitment'),
      Questions::Text.new(data: data.fetch('midpoint_comparison', nil),
                          title: 'How would you compare the value of the overview sessions versus the kata sessions?',
                          name:  'midpoint_comparison')
    ]
  end

  def questions
    pages.flat_map(&:questions)
  end

  def pages
    [
      Page.new(name: :baseline, questions: [baseline_question], title: 'Workshop Baseline'),
      Page.new(name: :feedback, questions: feedback_questions, title: 'We are looking to see if the workshops are scratching the right itch for MSTS. Please take a sec to leave some feedback on how the pilot program is going.')
    ]
  end

  class << self
    def feedback_questions(answer_data = {})
      [
        Questions::Boolean.new(data: answer_data.fetch('value', nil),
                               title: 'Is there enough value in the workshops to roll the program out to more folks?',
                               name:  'value'),
        Questions::Boolean.new(data: answer_data.fetch('impact', nil),
                               title: 'Have the workshops had an influence on how you approach your work?',
                               name:  'impact'),
        Questions::Text.new(data: answer_data.fetch('group_size', nil),
                            title: 'How has the group size affected discussion?',
                            name:  'group_size'),
        Questions::Text.new(data: answer_data.fetch('learning_culture', nil),
                            title: 'What areas have the workshops had a role in triggering your curiosity?',
                            name:  'learning_culture'),
        Questions::Text.new(data: answer_data.fetch('time_commitment', nil),
                            title: 'How has the time commitment impacted your other responsibilities?',
                            name:  'time_commitment')
      ]
    end

    def pages
      [
        Page.new(name: :baseline, questions: [baseline_question], title: 'Baseline'),
        Page.new(name: :feedback, questions: feedback_questions, title: 'We are looking to see if the workshops are scratching the right itch for MSTS. Please take a sec to leave some feedback on how the pilot program went.')
      ]
    end

    def baseline_question
      Questions::Baseline.new
    end

    def questions
      pages.flat_map(&:questions)
    end

    def surveyjs_pages
      [
        {
          questions: [
            { type: 'text', name: 'type', isRequired: true, title: 'Type', visible: false },
            { type: 'text', name: 'email', isRequired: true, title: 'Email' }
          ]
        }
      ] + pages.map(&:to_h)
    end

    def data_param_keys
      questions.flat_map(&:name) - %w(type name email)
    end

    def results
      @_results ||= active.pluck(:data).map { |d| d['baseline'] }
    end
  end
end
