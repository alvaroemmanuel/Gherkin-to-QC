require 'axlsx'
require_relative 'lib/gherkin_doc.rb'

file = File.expand_path(File.dirname(__FILE__) + '/features/login.feature')

f = GherkinDoc.parse file

package = Axlsx::Package.new
wb = package.workbook


@tc_count = 1
@step_count = 1
@prev_step = nil


def step_text(step, col)

  case col
  when :description
    if @step_count == 1
      value = step.keyword + step.name
      @prev_step = :description
    else
      case step.keyword.strip
      when 'Given', 'When'
        value = step.keyword + step.name
        @prev_step = :description
      when 'And', 'But'
        value = @prev_step == :description ? step.keyword + step.name : ''
      end
    end
  when :result
    case step.keyword.strip
    when 'Then'
      value = step.keyword + step.name
      @prev_step = :result
    when 'And', 'But'
      value = @prev_step == :result ? step.keyword + step.name : ''
    end
  end

  value.nil? ? value : value.gsub(/["<>]/, '"' => '', '<' => '<<<', '>' => '>>>')
end


wb.add_worksheet(:name => 'Test Design') do |sheet|
  sheet.add_row [
                  'Subject',
                  'Test Case Name',
                  'Step Name',
                  'Description',
                  'Expected Result',
                  'Execution Proof',
                  'Test Case Type',
                  'Test Category',
                  'Designer',
                  'Test Case Status',
                  'Positive/Negative',
                  'Regression Candidate',
                  'Test Case Number'
                ]

  f.scenarios.each do |tc|
    p "TC: #{@tc_count}"
    @step_count = 1
    tc.steps.each do |step|
      p "Step: #{@step_count}"
      sheet.add_row [
                      @step_count == 1 ? "02 - System Test\\" + f.name : '',
                      @step_count == 1 ? tc.name : '',
                      'Step ' + @step_count.to_s,
                      step_text(step, :description),
                      step_text(step, :result),
                      'N',
                      'System',
                      'Functional',
                      'vieyal01',
                      '3-Ready for Review',
                      'Positive/Nominal',
                      '3-Unknown',
                      @step_count == 1 ? @tc_count : ''
                    ]

      @step_count += 1
    end

    @tc_count += 1
  end
end

package.serialize 'C:\Users\emmakun\Documents\Nielsen\Automation\salida.xlsx'
