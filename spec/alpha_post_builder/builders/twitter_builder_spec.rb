require 'spec_helper'

module AlphaPostBuilder
  describe TwitterBuilder do
    let(:data) { load_fixture_for('twitter')[:statuses].last }
    subject { described_class.new(data) }

    it_behaves_like "a builder", 'twitter'
  end
end
