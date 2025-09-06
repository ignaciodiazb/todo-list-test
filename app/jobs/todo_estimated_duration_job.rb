class TodoEstimatedDurationJob < ApplicationJob
  queue_as :default

  def perform(todo_id)
    todo = Todo.find(todo_id)

    estimator = TodoTimeEstimator.new
    estimated_time = estimator.estimate_time(todo.title, todo.description)

    if estimated_time
      todo.update(estimated_time: estimated_time)
      Rails.logger.info("Estimated time set to #{estimated_time} minute(s) for todo: #{todo.title}")
    end
  end
end
