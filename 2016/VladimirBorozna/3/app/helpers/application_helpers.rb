require "json"

module ControllersHelpers # :nodoc:
  def redirect_through_js(path)
    status  200
    headers "Content-Type" => "application/javascript"
    body    "window.location.href = '#{path}'"
  end

  def response_json(status, data)
    status  status
    headers "Content-Type" => "application/json"
    body    JSON.generate(data)
  end

  def error_messages(model_instance)
    errors = model_instance.errors
    model_class = model_instance.class
    errors.keys.inject([]) do |messages, attr|
      attribute = model_class.human_attribute_name(attr)
      messages << "#{attribute} #{errors[attr].first}"
    end
  end
end
