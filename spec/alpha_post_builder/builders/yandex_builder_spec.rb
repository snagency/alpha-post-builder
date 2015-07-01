require 'spec_helper'

module AlphaPostBuilder
  describe YandexBuilder do
    let(:data) { {} }
    subject { described_class.new(data) }

    it_behaves_like "a builder", 'yandex'
  end
end
