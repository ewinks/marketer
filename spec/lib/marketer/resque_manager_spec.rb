require 'spec_helper'

describe Marketer::ResqueManager do
  describe ".enqueue" do
    pending
  end

  describe ".resque" do
    subject { Marketer::ResqueManager.resque(options) }
    let(:options) { {} }

    before(:each) do
      Marketer::ResqueManager.reset!
    end

    context 'when resque has been configured' do
      before do
        Marketer::ResqueManager.configure_with_parameters(host: 'resque-host')
        Marketer::ResqueManager.should_not_receive(:configure_with_parameters)
      end

      its(:class) { should == Resque.class }
      it 'should receive Resque with the proper configuration' do
        subject.redis_id.should == 'redis://resque-host:6379/0'
      end
    end

    context 'when Resque has not been configured' do

      context 'when a host is provided' do
        let(:options) { { host: 'resque-host' } }

        before do
          Marketer::ResqueManager.should_receive(:configure_with_parameters).with({ host: 'resque-host' })
        end

        its(:class) { should == Resque.class }
      end

      context 'when no host is provided' do
        before do
          Marketer::ResqueManager.should_receive(:configure_with_parameters)
        end

        its(:class) { should == Resque.class }
      end
    end
  end

  describe '.configure_with_parameters' do
    subject { Marketer::ResqueManager.configure_with_parameters(params) }
    let(:host) { '127.0.0.1' }

    let(:params) { { host: host } }

    it 'should configure Resque' do
      subject
      Resque.redis_id.should == "redis://#{host}:6379/0"
    end
  end
end
