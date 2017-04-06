# frozen_string_literal: true
class WorkshopRegistration < Survey
  title 'Workshop Registration'

  delegate :surveyjs_pages, to: :class
  delegate :baseline_questions, to: :class
  delegate :data_param_keys, to: :class

  def config
    super.merge(
      completedHtml: '<div class="alert alert-success" role="alert">Thanks for registering. Keep an eye out for details in the coming weeks.</div>'
    )
  end

  def chart_data
    baseline_questions.keys.map do |key|
      data.fetch(key.to_s, '0').to_i
    end
  end

  class << self
    def data_param_keys
      surveyjs_pages.flat_map { |p| p[:questions].map { |q| q[:name] } } - %w(type name email)
    end

    # rubocop:disable MethodLength
    def surveyjs_pages
      [
        {
          questions: [
            { type: 'text', name: 'type', isRequired: true, title: 'Type', visible: false },
            { type: 'text', name: 'name', isRequired: false, title: 'Name' },
            { type: 'text', name: 'email', isRequired: true, title: 'Email' }
          ]
        },
        {
          title: 'Baseline Questions',
          questions: [
            { type: 'matrix', name: 'data', title: 'Rate your familiarity with the following concepts:',
              columns: [{ value: 1, text: 'Huh?' },
                        { value: 2, text: ' ' },
                        { value: 3, text: 'Surface Level' },
                        { value: 4, text: ' ' },
                        { value: 5, text: 'Evil Genius' }],
              rows: surveyjs_baseline_questions }
          ]
        }
      ]
    end
    # rubocop:enable MethodLength

    def baseline_questions
      { ci: 'Continuous Integration',
        refactor: 'Refactoring',
        twelve_factor: '12 Factor App',
        benchmark: 'Benchmarking',
        authn: 'Authentication',
        pci: 'PCI Compliance' }
    end

    def surveyjs_baseline_questions
      baseline_questions.map do |value, text|
        { 'value': value.to_s, 'text': text.to_s }
      end
    end
  end
end
