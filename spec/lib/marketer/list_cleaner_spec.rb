require 'spec_helper'

describe Marketer::ListCleaner do
  subject { Marketer::ListCleaner.clean_list(original_list) }
  let(:original_list) { ["a@b.com", "b@c.com", "c@d.com"] }

  describe ".clean_list" do
    context 'when the list does not have duplicated elements' do
      it { should == original_list }
    end

    context 'when the list has duplicated elements' do
      let(:original_list) { ["a@b.com", "b@c.com", "c@d.com", "a@b.com"] }
      it { should_not == original_list }
      it { should == original_list.uniq }
    end
  end
end
