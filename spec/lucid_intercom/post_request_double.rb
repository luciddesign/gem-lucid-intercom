# frozen_string_literal: true

require 'lucid_intercom/response'

class PostRequestDouble
  def call(path, data, status_code: 200)
    Response.new(status_code)
  end
end
