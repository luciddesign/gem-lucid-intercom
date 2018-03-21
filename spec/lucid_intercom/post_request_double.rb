# frozen_string_literal: true

require 'lucid_intercom/response'

class PostRequestDouble
  def call(_path, _data, status_code: 200)
    LucidIntercom::Response.new(status_code)
  end
end
