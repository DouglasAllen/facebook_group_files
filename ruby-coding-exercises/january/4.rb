
# https://www.crondose.com/2017/01/ruby-coding-exercise-use-ruby-refinements-adds-methods-customized-classes/
require 'rspec'
# doc
module RubyContent
  refine String do
    def commentize
      "# #{self}"
    end
  end
end
# doc
module HtmlContent
  refine String do
    def commentize
      "<!-- #{self} -->"
    end
  end
end
# doc
class ContentController
  using RubyContent

  def initialize(word)
    @word = word
  end

  def hidden_content
    @word.commentize
  end
end
# doc
class HtmlController
  using HtmlContent

  def initialize(word)
    @word = word
  end

  def hidden_content
    @word.commentize
  end
end

cc = ContentController.new('My String')
p cc.hidden_content

html = HtmlController.new('My Html Content')
p html.hidden_content

describe 'Refining Strings for a specific module' do
  it 'changes behavior of commentize method for rendering comments' do
    cc = ContentController.new('My String')
    expect(cc.hidden_content).to eq('# My String')
  end
end

system 'rspec 4.rb' if __FILE__ == $PROGRAM_NAME
