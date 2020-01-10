require './format_error'

class Formatter
  def format(value)
    raise FormatError, 'Input format is incorrect' if value.empty?

    value.reverse.upcase
  end
end