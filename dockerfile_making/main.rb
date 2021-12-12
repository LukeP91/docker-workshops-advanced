require 'bundler' ; Bundler.require

set :show_exceptions, true
set :bind, '0.0.0.0'
set :server, %w[thin]

get '/' do
  ENV.fetch("HELLO", "hello world")
end

get '/healthcheck' do
  "ok"
end
