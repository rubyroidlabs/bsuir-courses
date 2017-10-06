require "slim"
require "sass"
require "sinatra"
require "sass/plugin/rack"
require "./app"

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run Sinatra::Application
