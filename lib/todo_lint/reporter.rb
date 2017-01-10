# frozen_string_literal: true
module TodoLint
  # We want to be able to report to users about the todos in their code, and
  # the Reporter is responsible for passing judgment and generating output
  class Reporter
    # Accept a todo and a path to check for problems
    # @example
    #   Reporter.new(todo,
    #     judge: Judge.new(todo))
    # @api public
    def initialize(todo, judge: RequiredArg.new)
      @todo = todo
      @path = todo.path
      @judge = judge
    end

    # Generate the output to show the user about their todo
    # @example
    #   reporter.report
    # @return [String] if the todo is problematic
    # @return [NilClass] if the todo is fine
    # @api public
    def report
      return if judge.charge.nil?

      "#{todo_location} #{problem}\n" \
      "#{todo.line.chomp.lstrip}\n" \
      "#{spaces}#{carets}"
    end

    private

    # The todo being reported on
    # @return [Todo]
    # @api private
    attr_reader :todo

    # The path to the file containing the todo
    # @return [String]
    # @api private
    attr_reader :path

    # The object responsible for charging the todo with a crime, or not
    # @return [Judge]
    # @api private
    attr_reader :judge

    # Which file, line, and character can the todo be found at?
    # @return [String]
    # @api private
    def todo_location
      Rainbow(path).green + ":#{todo.line_number}:#{todo.character_number}"
    end

    # The reason we are reporting on this todo
    # @return [String]
    # @api private
    def problem
      Rainbow(judge.charge).red
    end

    # Generate the indentation before the carets
    # @return [String]
    # @api private
    def spaces
      " " * number_of_spaces
    end

    # How many spaces before the carets should there be?
    # @return [Fixnum]
    # @api private
    def number_of_spaces
      todo.character_number - 1 - (todo.line.length - todo.line.lstrip.length)
    end

    # Generate the ^^^^ characters to point at the flag
    # @return [String]
    # @api private
    def carets
      "^" * todo.flag.length
    end
  end
end
