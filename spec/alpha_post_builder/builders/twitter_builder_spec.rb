require 'spec_helper'

module AlphaPostBuilder
  describe TwitterBuilder do
    let(:data) { load_fixture_for('twitter')[:statuses].last }
    subject { described_class.new(data) }

    it_behaves_like "a builder", 'twitter'

    it { expect(subject.filter[:created_time]).to eq(1435711203) }
    it { expect(subject.filter[:text]).to eq("The Foolish Mortals #freebandnames") }
    it { expect(subject.filter[:post_id]).to eq("249279667666817024") }
    it { expect(subject.filter[:location]).to eq("Wisconsin, USA") }
  end
end
