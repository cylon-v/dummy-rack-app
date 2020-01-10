require_relative 'app'

use Rack::Reloader
run App.new