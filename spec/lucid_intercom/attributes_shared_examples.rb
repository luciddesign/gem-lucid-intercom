# frozen_string_literal: true

module LucidIntercom
  RSpec.shared_examples 'attributes' do
    it 'has attributes' do
      expect(attributes.to_h).to be_a(Hash)
    end

    it 'performs a conversion on its attributes' do
      convert = instance_double('Convert')
      expect(convert).to receive(:call).with instance_of(Hash)

      attributes.to_h(convert: convert)
    end
  end
end
