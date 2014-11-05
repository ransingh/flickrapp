module ApplicationHelper
  include PhotoHelper

  def content_column(css_class)
    content_tag(:div, :class => "#{css_class}") do
      yield
    end
  end

  def content_row(style = '')
    content_tag(:div, :class => "row", :style => "#{style}") do
      yield
    end
  end

  def bootstrap_flash_message(flash)
    if flash[:error]
      content_tag(:div, flash[:error],:class => "alert alert-danger")
    elsif flash[:notice]
      content_tag(:div, flash[:notice],:class => "alert alert-info")
    end
  end
end
