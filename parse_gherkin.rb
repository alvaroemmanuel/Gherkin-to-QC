require 'gherkin_ruby'

result = GherkinRuby.parse(File.read('single_login.feature'))

p result.description
result.scenarios.first.steps.each do |step|
	p step
end
