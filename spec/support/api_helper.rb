# encoding: utf-8
require 'jsonpath'

module ApiHelper
  def first_json_at(path)
    JsonPath.on(response.body, path).first
  end
end

RSpec.configure do |c|
  c.include ApiHelper
end
