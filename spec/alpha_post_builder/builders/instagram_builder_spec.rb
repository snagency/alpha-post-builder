require 'spec_helper'

module AlphaPostBuilder
  describe InstagramBuilder do
    let(:data) { load_fixture_for('instagram')[:data].first }
    subject { described_class.new(data) }

    it_behaves_like "a builder", 'instagram'
  end
end
