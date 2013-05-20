# require spreadsheetx

current_path = File.dirname(__FILE__)

document = []
document << {
							subject: '02 - System Test\Path\To\QC\Folder',
							test_case_name: 'Test1',
							step_name: 'Step 1',
							description: %Q|This is a test case.
                             Here goes the test case body,
                             it means, the description.|,
							expected_result: 'The result of the test case',
							execution_proof: 'N',
							test_case_type: 'System',
							test_category: 'Functional',
							designer: 'vieyal01',
							test_case_status: '3-Ready for Review',
							positive_negative: 'Positive/Nominal',
							regression_candidate: '3-Unknown',
							test_case_number: 1
						}

document << {
							subject: '',
							test_case_name: '',
							step_name: 'Step 2',
							description: %Q|This is another test case.
                             Here goes the test case body,
                             this one is different.|,
							expected_result: 'The result of the new test case',
							execution_proof: 'Y',
							test_case_type: 'System',
							test_category: 'Functional',
							designer: 'vieyal01',
							test_case_status: '3-Ready for Review',
							positive_negative: 'Positive/Nominal',
							regression_candidate: '3-Unknown',
							test_case_number: ''
						}

print "{\n"

document.each do |row|
	print "\t{\n"
	row.each do |key, value|
		print "\t\t#{key}: #{value}\n"
	end
	print "\t}\n"
end

print "\n}\n"

xlsx_template = "#{current_path}/../templates/TnV Latam - Test Design Template.xlsx"

workbook = SpreadsheetX.open xlsx_template
p workbook.worksheets.last.name
