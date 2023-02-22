# frozen_string_literal: true

module ISBN
  class ISBN
    def initialize(source)
      validate_source_string(source)

      @source_string = source
    end

    def check_digit
      source_sum = @source_string[0..11].split('').each_with_index.reduce(0) do |sum, (x, i)|
        sum + x.to_i * (i.even? ? 1 : 3)
      end

      check_digit = 10 - (source_sum % 10)
      check_digit == 10 ? 0 : check_digit
    end

    def isbn
      @source_string[0..11] + check_digit.to_s
    end

    private

    def validate_source_string(string)
      raise InvalidSourceStringError if string.size < 12 || string.size > 12
      raise InvalidSourceStringError unless numberic?(string)
    end

    def numberic?(string)
      string.scan(/\D/).empty?
    end
  end

  class InvalidSourceStringError < RuntimeError; end
end
