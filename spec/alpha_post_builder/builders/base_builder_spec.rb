require 'spec_helper'

module AlphaPostBuilder
  describe BaseBuilder do
    context 'class' do
      subject { described_class }

      it 'should respond to #filter' do
        expect(subject).to respond_to(:filter)
      end
    end

    context 'instance' do
      subject { described_class.new('foo') }

      %w[filter network user_attributes post_attributes].each do |_method|
        it "should respond to ##{_method}" do
          expect(subject).to respond_to(_method.to_sym)
        end
      end
    end
  end
end
