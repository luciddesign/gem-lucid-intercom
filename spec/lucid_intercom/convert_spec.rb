# frozen_string_literal: true

require 'lucid_intercom/convert'

RSpec.describe LucidIntercom::Convert do
  let(:convert) { LucidIntercom::Convert.new }

  it 'converts attributes to valid intercom types' do
    attributes = convert.(
      float: 1.0,
      integer: 1,
      string: 'example',
      symbol: :example,
      time: Time.at(0),
      unset: nil
    )

    expect(attributes[:float]).to be(1.0)
    expect(attributes[:integer]).to be(1)
    expect(attributes[:string]).to eq('example')
    expect(attributes[:symbol]).to eq('example')
    expect(attributes[:time]).to be(0)
    expect(attributes[:unset]).to be_nil
  end
end
