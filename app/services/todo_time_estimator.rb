class TodoTimeEstimator
  def initialize
    @client = OpenAI::Client.new
  end

  def estimate_time(task_title, task_description)
    system_prompt = <<~PROMPT
      Given the following task title and description, estimate the time required to complete the task in minutes.

      Task title: #{task_title}
      Task description: #{task_description}

      Respond only with a single integer representing the number of minutes.
    PROMPT

    begin
      response = @client.chat(
        parameters: {
          messages: [ { role: "system", content: system_prompt } ],
          model: "gpt-3.5-turbo",
          temperature: 0.2
        }
      )

      raw_output = response.dig("choices", 0, "message", "content") || ""
      estimated_time = raw_output.to_i

      result = estimated_time > 0 ? estimated_time : nil
      Rails.logger.warn("Invalid estimation result, returning nil") if result.nil?

      result
    rescue => e
      Rails.logger.error("Failed to estimate time for task '#{task_title}': #{e.message}")
      nil
    end
  end
end
