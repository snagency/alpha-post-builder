RSpec.shared_examples "a builder" do |network|
  describe '#network' do
    it "returns network name" do
      expect(subject.network).to eq(network)
    end
  end

  describe '#filter' do
    context 'user' do
      let(:user) { subject.filter[:user] }

      it { expect(user).to include(:uid) }
      it { expect(user).to include(:name) }
      it { expect(user).to include(:screen_name) }
      it { expect(user).to include(:image) }
      it { expect(user).to include(:location) }
      it { expect(user).to include(:url) }
      it { expect(user).to include(:friends_count) }
      it { expect(user).to include(:followers_count) }
    end

    context 'post' do
      let(:post) { subject.filter }

      it { expect(post).to include(:created_time) }
      it { expect(post).to include(:title) }
      it { expect(post).to include(:text) }
      it { expect(post).to include(:post_id) }
      it { expect(post).to include(:location) }
      it { expect(post).to include(:url) }
      it { expect(post).to include(:media_type) }
      it { expect(post).to include(:image_url) }

      it { expect(post[:network]).to eq(network) }
    end
  end
end
