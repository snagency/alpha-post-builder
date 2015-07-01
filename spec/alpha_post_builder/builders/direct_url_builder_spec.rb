require 'spec_helper'

module AlphaPostBuilder
  describe DirectUrlBuilder do
    let(:data) { {} }
    subject { described_class.new(data) }

    it_behaves_like "a builder", 'direct_url'
  end
end
