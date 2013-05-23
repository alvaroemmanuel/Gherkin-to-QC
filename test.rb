require_relative 'lib/gherkin_doc'

file = File.expand_path(File.dirname(__FILE__) + '/features/login.feature')

f = GherkinDoc.parse file

p f.class

p f.name
p f.description

p 'Feature Tags:'
f.tags.each do |tag|
  p tag.name
end

p 'Background Steps:'
f.background.steps.each do |step|
  p step.keyword
  p step.name
end

p 'Scenarios:'
f.scenarios.each do |scenario|
  p "Name: #{scenario.name}"
  p 'Steps:'
  scenario.steps.each do |step|
    p step.keyword
    p step.name
  end
  p 'Scenario Tags:'
  scenario.tags.each do |tag|
    p tag.name
  end
end

f.scenarios.each do |s|
  p s == f.scenarios.first
end

str = 'When I enter the username "<username>"'
p str.gsub(/["<>]/, '"' => '', '<' => '<<<', '>' => '>>>')
