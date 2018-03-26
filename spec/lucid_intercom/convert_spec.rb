# frozen_string_literal: true

require 'lucid_intercom/convert'

RSpec.describe LucidIntercom::Convert do
  subject(:convert) { LucidIntercom::Convert.new }

  it 'converts attributes to valid intercom types' do
    attributes = convert.(
      float: 1.0,
      integer: 1,
      string: 'example',
      symbol: :example,
      time: Time.at(0),
      unset: nil
    )

    expect(attributes).to eq(
      float: 1.0,
      integer: 1,
      string: 'example',
      symbol: 'example',
      time: 0,
      unset: nil
    )
  end
end
