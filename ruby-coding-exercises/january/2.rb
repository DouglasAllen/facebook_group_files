
# https://www.crondose.com/2017/01/using-ruby-doc-syntax-dynamically-generate-html-code/
require 'rspec'

# <!doctype html>

# <html lang="en">
# <head>
#   <meta charset="utf-8">
#
#   <title>Title Goes Here</title>
# </head>
#
# <body>
# </body>
# </html>

def html_generator(title)
  <<HTML
<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8">

    <title>#{title}</title>
  </head>

  <body>
  </body>
</html>
HTML
end

describe 'HTML generator' do
  it 'allows for a dynamic title' do
    expect(
      html_generator('My Site')
    ).to match(
      /My Site/
    )
  end
end

system 'rspec 2.rb' if __FILE__ == $PROGRAM_NAME
