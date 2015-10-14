module Lazybird
  module Cli
    module Commands

      def config(params)
        @facade.config(params)
        display_done
      end

      def setup(params)
        @facade.init
        display_done
      end

      def add(params)
        @facade.add_task params.first
        display_done
      end

      def my_tasks(params)
        @facade.current_tasks.join("\n").green.display
        newline
      end

      def rem(params)
        @facade.rem_task(params.first)
        display_done
      end

      def run(params)
        cursor = -> () do
          display_prompt
        end
        @facade.run_tasks(params, &cursor)
      end

      def my_run(params)
        @facade.run_info.green.display
        newline
      end

      def exit(params)
        Kernel.exit(true)
      end

      def intro
        "Lazybird v#{Lazybird.version}\n".light_yellow +
          "by James Lopez <http://jameslopez.net> <https://github.com/bluegod/lazybird>\n".blue +
          'Type: ' + "help \u{23ce}".bold + " for a list of commands.\n"
      end

      def help(params)
        begin
          "List of available commands: \n".yellow +
            "config ".bold + "consumer_key consumer_secret access_token access_token_secret".green + " \u{23ce} \n".white +
            "Configures twitter account (Should be the first step!)\n" +
            "tasks  \u{23ce} \n".bold +
            "Displays a list of available tasks \n" +
            "my_tasks".bold + "  \u{23ce} \n" +
            "Displays a list of your selected tasks \n" +
            "add ".bold + "task".green + " \u{23ce} \n".white +
            "Adds a task to be randomly tweeted\n" +
            "rem ".bold + "task".green + " \u{23ce} \n".white +
            "Removes a task from your list\n" +
            "run ".bold + "time".green + " \u{23ce} \n".white +
            "Sets how frequent we tweet (Ex: run 3h or run 1d or run 30m)\n" +
            "my_run ".bold + "  \u{23ce} \n" +
            "Displays the current frequency of tweets \n" +
            "setup  \u{23ce} \n".bold +
            "setups the app for the first time \n" +
            "exit  \u{23ce} \n".bold +
            "Exits the app \n"
        end.display
      end

      def tasks(params)
        @facade.tasks.each do |k, v|
          puts "#{k}:".bold + " #{v['desc']}".green
        end
      end

      def display_done
        'done!'.green.display
        newline
      end
    end
  end
end