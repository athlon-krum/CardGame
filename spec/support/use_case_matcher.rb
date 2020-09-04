module Testspace
  module RSpec
    module Matchers
      extend ::RSpec::Matchers::DSL

      matcher :succeed do
        match(&:success?)

        failure_message do |use_case|
          "#{use_case.class} does not succeed. Errors: #{use_case.errors.full_messages}."
        end

        failure_message_when_negated do |_policy|
          "#{use_case.class} succeeds when it is expected to fail"
        end
      end

      matcher :have_errors do
        match do |use_case|
          result = use_case.errors.any?
          if @message.present? && @key.present?
            result &&= use_case.errors.key?(@key) && use_case.errors[@key].any? { |message| Regexp.new(@message).match message }
          elsif @message.present?
            result &&= use_case.errors.values.flatten.any? { |message| Regexp.new(@message).match message }
          elsif @key.present?
            result &&= use_case.errors.key?(@key)
          end
          result
        end

        chain :on do |key|
          @key = key.to_sym
        end

        chain :containing do |message|
          @message = message
        end

        failure_message do |use_case|
          message = "#{use_case.class} does not have errors"
          message += " on \"#{@key}\"" if @key.present?
          message += " containing \"#{@message}\"" if @message.present?
          message += ". Actual Errors - #{use_case.errors.to_json}" if @message.present? || @key.present?
          message
        end

        failure_message_when_negated do |use_case|
          message = "#{use_case.class} contains errors"
          message += " on \"#{@key}\"" if @key.present?
          message += " containing \"#{@message}\"" if @message.present?
          message += ". Actual Errors - #{use_case.errors.to_json}"
          message
        end
      end

      matcher :have_notes do
        match do |use_case|
          result = use_case.notes.any?
          if @message.present? && @key.present?
            result &&= use_case.notes.key?(@key) && use_case.notes[@key].any? { |message| Regexp.new(@message).match message }
          elsif @message.present?
            result &&= use_case.notes.values.flatten.any? { |message| Regexp.new(@message).match message }
          elsif @key.present?
            result &&= use_case.notes.key?(@key)
          end
          result
        end

        chain :on do |key|
          @key = key.to_sym
        end

        chain :containing do |message|
          @message = message
        end

        failure_message do |use_case|
          message = "#{use_case.class} does not have notes"
          message += " on \"#{@key}\"" if @key.present?
          message += " containing \"#{@message}\"" if @message.present?
          message += ". Actual Notes - #{use_case.notes.to_json}" if @message.present? || @key.present?
          message
        end

        failure_message_when_negated do |use_case|
          message = "#{use_case.class} contains notes"
          message += " on \"#{@key}\"" if @key.present?
          message += " containing \"#{@message}\"" if @message.present?
          message += ". Actual Notes - #{use_case.notes.to_json}"
          message
        end
      end

      matcher :have_warnings do
        match do |use_case|
          result = use_case.warnings.any?
          if @message.present? && @key.present?
            result &&= use_case.warnings.key?(@key) && use_case.warnings[@key].any? { |message| Regexp.new(@message).match message }
          elsif @message.present?
            result &&= use_case.warnings.values.flatten.any? { |message| Regexp.new(@message).match message }
          elsif @key.present?
            result &&= use_case.warnings.key?(@key)
          end
          result
        end

        chain :on do |key|
          @key = key.to_sym
        end

        chain :containing do |message|
          @message = message
        end

        failure_message do |use_case|
          message = "#{use_case.class} does not have warnings"
          message += " on \"#{@key}\"" if @key.present?
          message += " containing \"#{@message}\"" if @message.present?
          message += ". Actual Warnings - #{use_case.warnings.to_json}" if @message.present? || @key.present?
          message
        end

        failure_message_when_negated do |use_case|
          message = "#{use_case.class} contains warnings"
          message += " on \"#{@key}\"" if @key.present?
          message += " containing \"#{@message}\"" if @message.present?
          message += ". Actual Warnings - #{use_case.warnings.to_json}"
          message
        end
      end
    end

    module UseCaseExampleGroup
      include Testspace::RSpec::Matchers

      def self.included(base)
        base.metadata[:type] = :use_case
        super
      end
    end
  end
end
