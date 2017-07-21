require "tom_queue/persistence/model"

module TomQueue
  class Job < Persistence::Model
    # Public: Override Delayed::Job.enqueue
    # Allows us to skip DJ for enqueuing new work
    #
    # Returns a persisted model instance
    def self.enqueue(*args)
      work, options = TomQueue::Job::Preparer.new(*args).prepare
      # first return value from the stack is the persisted instance
      TomQueue.enqueue(work, options)
    end
  end
end