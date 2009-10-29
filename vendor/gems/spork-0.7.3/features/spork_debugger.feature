Feature: Spork Debugger integration
  As a developer
  I want to invoke the debugger my specs within Spork
  In order to drill in and figure out what's wrong

  Background: Rails App with RSpec and Spork

    Given a file named "spec/spec_helper.rb" with:
      """
      require 'rubygems'
      require 'spork'
      require 'spork/ext/ruby-debug'

      Spork.prefork do
        require 'spec'
      end

      Spork.each_run do
      end
      """

  Scenario: Invoking the debugger via 'debugger'
    Given a file named "spec/debugger_spec.rb" with:
      """
      require File.dirname(__FILE__) + '/spec_helper.rb'

      describe "Debugger" do
        it "should debug" do
          2.times do |count|
            @message = "count = #{count}"
            debugger
            @message = nil
          end
          puts "it worked!"
        end
      end
      """

    When I fire up a spork instance with "spork rspec"
    And I run this in the background: spec --drb spec/debugger_spec.rb

    Then the spork window should output a line containing "Debug Session Started"

    When I type this in the spork window: "e @message"
    Then the spork window should output a line containing "count = 0"

    When I type this in the spork window: "continue"

    When I type this in the spork window: "e @message"
    Then the spork window should output a line containing "count = 1"

    When I type this in the spork window: "continue"

    Then the spork window should output a line containing "Debug Session Terminated"
    And the output should contain "it worked!"

  Scenario: When ruby-debug is already required and started.
    Given a file named "spec/debugger_spec.rb" with:
      """
      require File.dirname(__FILE__) + '/spec_helper.rb'
      require 'ruby-debug'
      Debugger.start

      describe "Debugger" do
        it "should debug" do
          @message = "yup"
          debugger
          puts "it worked!"
        end
      end
      """

    When I fire up a spork instance with "spork rspec"
    And I run this in the background: spec --drb spec/debugger_spec.rb

    Then the spork window should output a line containing "Debug Session Started"

    When I type this in the spork window: "e @message"
    Then the spork window should output a line containing "yup"

    When I type this in the spork window: "continue"

    Then the spork window should output a line containing "Debug Session Terminated"
    And the output should contain "it worked!"
