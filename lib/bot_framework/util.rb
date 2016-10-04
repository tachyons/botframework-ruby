module BotFramework
  module Util
    class << self
      def to_underscore(string)
        string = string.to_s unless string.is_a? String
        string.gsub(/::/, '/')
              .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
              .gsub(/([a-z\d])([A-Z])/, '\1_\2')
              .tr('-', '_')
              .downcase
      end

      def camel_case_lower(string)
        string = string.to_s unless string.is_a? String
        string.split('_').inject([]) { |buffer, e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
      end
    end
  end
end
