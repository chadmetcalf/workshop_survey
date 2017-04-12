module Questions
  class Baseline
    attr_accessor :data

    delegate :labels, to: :class
    delegate :questions, to: :class
    delegate :rows, to: :class

    def initialize(data: {})
      @data = data
    end

    def name
      'baseline'
    end

    def to_partial_path
      'surveys/questions/baseline'
    end

    def to_h
      { type: 'matrix', name: 'baseline', title: 'Rate your familiarity with the following concepts:',
        columns: [{ value: 1, text: 'Huh?' },
                  { value: 2, text: ' ' },
                  { value: 3, text: 'Surface Level' },
                  { value: 4, text: ' ' },
                  { value: 5, text: 'Evil Genius' }],
        rows: rows }
    end

    def chart_data
      questions.keys.map do |key|
        data.fetch(key.to_s, '0').to_i
      end
    end

    class << self
      # Baseline questions
      def questions
        { ci: 'Continuous Integration',
          refactor: 'Refactoring',
          twelve_factor: '12 Factor App',
          benchmark: 'Benchmarking',
          authn: 'Authentication',
          pci: 'PCI Compliance' }
      end

      def rows
        questions.map do |value, text|
          { 'value': value.to_s, 'text': text.to_s }
        end
      end

      def labels
        questions.values.map { |v| v[/[a-zA-Z]/ =~ v] }
      end
    end
  end
end
