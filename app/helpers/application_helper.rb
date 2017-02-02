module ApplicationHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, content_tag(:div, :class=>"usa-alert-body" ), :class =>"usa-alert usa-alert-error")  do
          concat message
      end)
    end
    nil
  end

end
