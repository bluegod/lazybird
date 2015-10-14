require 'colorize'
require 'lazybird/version'
require 'lazybird/lazybird_facade'
require 'lazybird/cli/commands'
require 'rbconfig'

module Lazybird
  module Cli
    class CommandLine
      include Lazybird::Cli::Commands

      def initialize
        @facade = Lazybird::LazybirdFacade.new
        intro.display
        setup_check
        run_main_loop
      end

      private

      def setup_check
        if Lazybird::Config.db_file_exists?
          @facade.load_default_tasks
        else
          puts 'Type: '.bold + "setup \u{23ce}".red.bold + " as this is the first time running the app.\n".bold
        end
      end

      def run_main_loop
        loop do
          display_prompt
          command, *params = gets.chomp.split /\s/
          process_command(command, params) if command
        end
      end

      def newline
        puts
      end

      def process_command(command, params)
        command.downcase!
        if respond_to?(command)
          send(command, params)
        else
          puts 'Invalid command'.light_red
        end
      end

      def display_prompt
        prompt.yellow.display
      end

      def prompt
        @_prompt ||=
          begin
            os = RbConfig::CONFIG['host_os']
            icon = os.start_with?('darwin') ? "\u{1F425}" : ')<'
            "#{icon} Lazybird> "
          end
      end
    end
  end
end