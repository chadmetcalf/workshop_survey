# frozen_string_literal: true
class FourWeekFeedback < Survey
  title 'Four Week Feedback'

  delegate :surveyjs_pages, to: :class
  delegate :baseline_questions, to: :class
  delegate :data_param_keys, to: :class

  class << self
    def data_param_keys
      surveyjs_pages.flat_map { |p| p[:questions].map { |q| q[:name] } } - %w(type name email)
    end

    def surveyjs_pages
      [
        {
          questions: [
            { type: 'text', name: 'type', isRequired: true, title: 'Type', visible: false },
            { type: 'text', name: 'email', isRequired: true, title: 'Email' }
          ]
        },
        surveyjs_baseline_page,
        surveyjs_feedback_page
      ]
    end

    # Baseline questions
    def baseline_questions
      { ci: 'Continuous Integration',
        refactor: 'Refactoring',
        twelve_factor: '12 Factor App',
        benchmark: 'Benchmarking',
        authn: 'Authentication',
        pci: 'PCI Compliance' }
    end

    def surveyjs_baseline_page
      {
        title: 'Workshop Baseline',
        questions: surveyjs_baseline_questions
      }
    end

    def surveyjs_baseline_questions
      [
        { type: 'matrix', name: 'baseline', title: 'Rate your familiarity with the following concepts:',
          columns: [{ value: 1, text: 'Huh?' },
                    { value: 2, text: ' ' },
                    { value: 3, text: 'Surface Level' },
                    { value: 4, text: ' ' },
                    { value: 5, text: 'Evil Genius' }],
          rows: surveyjs_baseline_familiarity_rows }
      ]
    end

    def surveyjs_baseline_familiarity_rows
      baseline_questions.map do |value, text|
        { 'value': value.to_s, 'text': text.to_s }
      end
    end

    # Feedback questions
    # rubocop:disable MethodLength
    def surveyjs_feedback_questions
      [
        { title: 'Is there enough value in the workshops to roll the program out to more folks?',
          type: 'radiogroup',
          colCount: 4,
          choices: %w(Yes No),
          name:  'value' },
        { title: 'Have the workshops had an influence on how you approach your work?',
          type: 'radiogroup',
          colCount: 4,
          choices: %w(Yes No),
          name:  'impact' },
        { title: 'How has the group size affected discussion?',
          type:  'comment',
          name:  'group_size' },
        { title: 'What areas have the workshops had a role in triggering your curiosity?',
          type:  'comment',
          name:  'learning_culture' },
        { title: 'How has the time commitment impacted your other responsibilities?',
          type:  'comment',
          name:  'time_commitment' }
      ]
    end
    # rubocop:enable MethodLength

    # rubocop:disable Metrics/LineLength
    def surveyjs_feedback_page
      {
        title: 'We are looking to see if the workshops are scratching the right itch for MSTS. Please take a sec to leave some feedback on how the pilot program is going.',
        questions: surveyjs_feedback_questions
      }
    end
    # rubocop:enable Metrics/LineLength
  end
end
