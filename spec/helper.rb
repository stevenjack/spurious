require 'pathname'
$: << File.join(Pathname.new(__FILE__).dirname.parent, 'lib')

require 'spurious/app'
require 'stringio'
gem 'docker-api'
require 'docker'
require 'spurious/server'

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end
