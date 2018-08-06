# frozen_string_literal: true

module LucidIntercom
  RSpec.describe Convert do
    subject(:convert) { Convert.new }

    describe '#call' do
      subject do
        convert.(
          float: 1.0,
          integer: 1,
          string: 'example',
          symbol: :example,
          time: Time.at(0),
          unset: nil
        )
      end

      it { is_expected.to include(float: 1.0) }
      it { is_expected.to include(integer: 1) }
      it { is_expected.to include(string: 'example') }
      it { is_expected.to include(symbol: 'example') }
      it { is_expected.to include(time: 0) }
      it { is_expected.to include(unset: nil) }
    end
  end
end
