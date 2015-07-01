require 'spec_helper'

module AlphaPostBuilder
  describe FacebookBuilder do
    let(:data) { { actor: {} } }
    subject { described_class.new(data) }

    it_behaves_like "a builder", 'facebook'
  end
end
