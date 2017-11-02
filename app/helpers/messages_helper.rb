module MessagesHelper
  def time_left_in_words
    distance_of_time_in_words_to_now(@message.created_at + @message.hours.hours, include_seconds: true)
  end
end
