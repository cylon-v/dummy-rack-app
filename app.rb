require './formatter'
require './format_error'

class App
  def initialize
    @formatter = Formatter.new
  end

  def call(rack_env)
    path = rack_env['PATH_INFO']
    query = Rack::Utils.parse_nested_query(rack_env['QUERY_STRING'])

    if path != '/format/'
      return [404, headers, ['Not found']]
    end

    unless query.has_key?('value')
      return [400, headers, ['Incorrect query']]
    end

    begin
      value = query['value']
      result = @formatter.format(value)
      return [200, headers, [result]]
    rescue FormatError
      return [400, headers, ['Incorrect input format']]
    end
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

end