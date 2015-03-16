module ApplicationHelper
  def flash_html
    return "" if flash.empty?
    div = ""
    div << content_tag(:div, class: "alert") do
      p = ""
      flash.each do |type, msg|
        p << content_tag(:p) do
          content_tag(:strong, msg, class: flash_type_to_css_class(type))
        end
      end
      p.html_safe
    end
    div.html_safe
  end

  def flash_type_to_css_class(type)
    css_class = ""
    if type == "success" || type == "notice"
      css_class = "green"
    elsif type == "info"
      css_class = "blue"
    elsif type == "danger" || type == "alert"
      css_class = "red"
    elsif type == "warning"
      css_class = "orange"
    end
    css_class += "-text"
  end
end
