require 'rufus-scheduler'

module Lazybird
  module Tasks
    module TaskScheduler
      extend self

      @job = nil
      @scheduler = Rufus::Scheduler.new

      def self.schedule(frequency: '1h', &block)
        @frequency = frequency
        restart_scheduler unless @job.nil?
        @job = job(&block)
      end

      def self.job_info
        @job ? "Runs every: #{@job.original} Ran: #{@job.count} times." : 'No run!'
      end

      private

      def job
        job_id = @scheduler.every "#{@frequency}" do
          # Process random task
          yield
        end
        @scheduler.job(job_id)
      end

      def restart_scheduler
        @job.unschedule
        @job.kill
        #@scheduler.shutdown(:kill)
      end
    end
  end
end
