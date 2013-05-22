# require 'gherkin_ruby'
# require 'shallot'

# result = GherkinRuby.parse(File.read('features/single_login.feature'))

# result.scenarios.first.steps.each do |step|
# 	p "#{step.keyword} #{step.name}"
# end

# Logical skeleton for Gherkin document.
# Includes all the basic "keywords", each on its own class.
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
	def self.parse
		# Parse document main method.
	end

	class Parser
		# TODO: Implement parser logic.
	end
end
