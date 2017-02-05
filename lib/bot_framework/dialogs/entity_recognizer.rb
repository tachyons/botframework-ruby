require 'chronic'
module BotFramework
  module Dialogs
    class EntityRecognizer
      DATE_REGEX = /^\d{4}-\d{2}-\d{2}/i
      YES_REGEX = /^(1|y|yes|yep|sure|ok|true)(\W|$)/i
      NO_REGX = /^(2|n|no|nope|not|false)(\W|$)/i
      NUMBER_REGEX = /[+-]?(?:\d+\.?\d*|\d*\.?\d+)/
      ORDINAL_WORDS_REGEX = /first|second|third|fourth|fifth|sixth|seventh|eigth|ninth|tenth/
      def initialize(*args); end

      def self.find_entity(entities, type)
        # raise ArgumentError unless entities.is_a? Hash
        entities.find { |entity| entity[:type] == type }
      end

      def self.find_all_entities(entities, type)
        entities.find_all { |entity| entity[:type] == type }
      end

      def self.parse_time(entities)
        entities = [EntityRecognizer.recognize_time(entities)] if entities.is_a? String
        EntityRecognizer.resolve_time(entities)
      end

      def self.resolve_time(entities)
        now = DateTime.now
        resolved_date = nil
        time = nil
        entities.each do |entity|
          next unless entity[:resolution]
          case entity[:resolution][:resolution_type] || entity[:type]
          when 'builtin.datetime'
          when 'builtin.datetime.date'
          when 'builtin.datetime.time'
            time = entity[:resolution][:time]
          when 'chronic.time'
            duration = entity
            time = entity[:resolution][:time]
            resolved_date = duration[:resolution][:time]
          end
        end
        date = now if !resolved_date && (date || time)
        time
      end

      def self.recognize_time(utterance, reference_date = {})
        time = Chronic.parse(utterance, reference_date)
        return false unless time
        {
          type: 'chronic.time',
          entity: time.to_s,
          resolution: {
            resolution_type: 'chronic.time',
            time: time
          }
        }
      end

      def self.parse_number(entities)
        entity = nil
        entity = if entities.is_a? String
                   { type: 'text', entity: entities.strip }
                 else
                   find_entity(entities, 'builtin.number')
                 end

        if entity
          match = NUMBER_REGEX.match(entity[:entity])
          return match[0] if match
        end
      end

      def self.parse_boolean(utterance)
        utterance.strip!
        if YES_REGEX =~ utterance
          true
        elsif NO_REGX =~ utterance
          false
        end
      end

      def self.find_best_match(choices, utterance, threshhold = 0.6)
        matches = find_all_matches(choices, utterance, threshhold)
        matches.max { |entry| entry[:score] }
      end

      def self.find_all_matches(choices, utterance, threshold = 0.6)
        matches = []
        utterance = utterance.strip.downcase
        tokens = utterance.split

        expand_choices(choices).each_with_index do |choice, index|
          score = 0.0
          value = choice.strip.downcase
          if value.include?(utterance)
            score = utterance.size.to_f / value.size
          elsif utterance.include? value
            score = [0.5 + (value.size.to_f / utterance.size), 0.9].min
          else
            matched = ''
            tokens.each { |token| matched += token if value.include? token }
            score = matched.size / value.size
          end
          if score > threshold
            matches.push(index: index, entity: choice, score: score)
          end
        end
        matches
      end

      def self.expand_choices(choices)
        case choices
        when nil then []
        when Array then choices.map(&:to_s)
        when Hash then choices.keys.map(&:to_s)
        when String then choices.split('|')
        else [choices.to_s]
        end
      end
    end
  end
end
