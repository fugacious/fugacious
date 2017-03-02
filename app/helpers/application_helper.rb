module ApplicationHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def uswds_class_for (flash_type)
    { success: "success", error: "danger", alert: "warning", notice: "info" }[flash_type] || flash_type.to_s
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, class: "usa-alert usa-alert-#{uswds_class_for(msg_type)}") do
          content_tag(:div, class: 'usa-alert-body') do
            content_tag(:h3, class: 'usa-alert-heading') do
              concat message
            end
          end
        end
      )
    end
    nil
  end
end
