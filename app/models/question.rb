class Question
  attr_accessor :data, :name, :title

  def initialize(data:, name:, title:)
    @data = data
    @name = name
    @title = title
  end

  def required?
    false
  end

  def to_h
    { type: type, name: name, title: title }
  end

  def questions
    { ci: 'Continuous Integration',
      refactor: 'Refactoring',
      twelve_factor: '12 Factor App',
      benchmark: 'Benchmarking',
      authn: 'Authentication',
      pci: 'PCI Compliance' }
  end
end
