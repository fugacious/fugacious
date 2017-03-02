module MessagesHelper

  def error_messages_for(*objects)
    objects.extract_options!
    header_message = I18n.t(:"activerecord.errors.header", default: "Invalid Fields")
    message = I18n.t(:"activerecord.errors.message", default: "Correct the following errors and try again.")
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    unless messages.empty?
        content_tag(:div, class: "usa-alert usa-alert-error") do
          content_tag(:div, class: "usa-alert-body") do
          list_items = messages.map { |msg| content_tag(:li, msg) }
          content_tag(:h2, header_message, class: "usa-alert-heading") +
          content_tag(:p, message, class: "usa-alert-text") +
          content_tag(:ul, list_items.join.html_safe)
        end
      end
    end
  end

  def time_left_in_words
    distance_of_time_in_words_to_now(@message.created_at + @message.hours.hours, include_seconds: true)
  end

  module FormBuilderAdditions
    def error_messages(options = {})
      @template.error_messages_for(@object, options)
    end
  end
end

ActionView::Helpers::FormBuilder.send(:include, MessagesHelper::FormBuilderAdditions)
