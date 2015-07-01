require 'spec_helper'

module AlphaPostBuilder
  describe VkontakteBuilder do
    let(:data) { { author: {} } }
    subject { described_class.new(data) }

    it_behaves_like "a builder", 'vkontakte'
  end
end
