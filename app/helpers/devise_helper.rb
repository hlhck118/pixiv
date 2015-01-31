module DeviseHelper
  # Override DeviseHelper to customize devise_error_messages!

  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    div = ""
    div << content_tag(:div, class: "alert alert-danger") do
      p = ""
      resource.errors.full_messages.each do |msg|
        p << content_tag(:p) do
          content_tag(:span, msg, class: "semibold")
        end

      end
      p.html_safe
    end

    div.html_safe
  end
end