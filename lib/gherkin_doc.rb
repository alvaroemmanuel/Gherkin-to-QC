require 'gherkin/parser/parser'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'multi_json'


module GherkinDoc
  class Feature
    attr_reader :name, :description, :background, :scenarios, :tags

    def initialize(name, description='', background=nil, scenarios=[], tags=[])
      @name = name
      @description = description
      @background = background
      @scenarios = scenarios
      @tags = tags
    end
  end

  class Background
    attr_reader :steps

    def initialize(steps=[])
      @steps = steps
    end
  end

  class Scenario
    attr_reader :name, :steps, :tags

    def initialize(name, steps=[], tags=[])
      @name = name
      @steps = steps
      @tags = tags
    end
  end

  class Step
    attr_reader :name, :keyword

    def initialize(name, keyword)
      @name = name
      @keyword = keyword
    end
  end

  class Tag
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end

module GherkinDoc
  def self.parse(file)
    io = StringIO.new
    formatter = Gherkin::Formatter::JSONFormatter.new(io)
    gherkin = Gherkin::Parser::Parser.new(formatter)
    
    gherkin.parse(IO.read(file), file, 0)
    formatter.done
    
    feature = MultiJson.load(io.string, :symbolize_keys => true)[0]

    parser = Parser.new feature
    parser.get_feature
  end

  class Parser
    def initialize(feature)
      @json = feature
    end

    def get_feature
      name = @json[:name] || ''
      description = @json[:description] || ''
      background = get_background || nil
      scenarios = get_scenarios
      tags = get_tags 'Feature'

      Feature.new name, description, background, scenarios, tags
    end

    def get_background      
      steps = get_steps 'Background'

      Background.new steps
    end

    def get_scenarios
      scenarios = []

      elements = get_elements ['Scenario', 'Scenario Outline']

      elements.each do |scenario|
        name = scenario[:name]
        steps = get_steps name
        tags = get_tags name

        scenarios << Scenario.new(name, steps, tags)
      end

      scenarios
    end

    def get_tags(key)
      tags = []

      if key == 'Feature'
        element = @json
      else
        element = @json[:elements].select {|e| e[:name] == key}
        element = element[0]
      end

      if element.has_key? :tags
        element[:tags].each do |tag|
          tags << Tag.new(tag[:name])
        end
      end

      tags
    end

    def get_steps(key)
      steps = []

      if key == 'Background'
        element = @json[:elements].select {|e| e[:keyword] == key}
      else
        element = @json[:elements].select {|e| e[:name] == key}
      end

      element = element[0]

      unless element.nil? || element.empty?
        element[:steps].each do |step|
          steps << Step.new(step[:name], step[:keyword])
        end
      end

      steps
    end

    def get_elements(keys)
      elements = []
      
      keys.each do |key|
        elements += @json[:elements].select {|e| e[:keyword] == key}
      end

      elements
    end
  end
end
