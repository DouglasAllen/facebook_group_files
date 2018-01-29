require_relative 'spec_helper' 

def report
  "This will output some kind of report"
end

describe 'spec matchers' do
  it 'must match the return' do
    report.must_match 'some'
  end

  it 'must_output matches output to STDOUT or STDERR using lambda' do
    -> {print report}.must_output "This will output some kind of report"
  end
end

