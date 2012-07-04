require 'spec_helper'

describe Adapter::Mongo,'.new' do
  subject { object.new(*arguments) }

  let(:object) { described_class }

  context 'when passing a Mongo::Connection' do
    let(:connection) { mock(Mongo::Connection) }
    let(:arguments)  { [connection] }

    before do
      Mongo::Connection.stub(:=== => true)
    end

    its(:connection) { should be(connection) }

    it { should be_frozen }
  end

  context 'when passing a Mongo::ReplSetConnection' do
    let(:connection) { mock(Mongo::ReplSetConnection) }
    let(:arguments)  { [connection] }

    before do
      Mongo::ReplSetConnection.stub(:=== => true)
    end

    its(:connection) { should be(connection) }

    it { should be_frozen }
  end

  context 'when passing any single argument' do
    let(:arguments) { [:foo] }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,'Cannot construct connection from :foo')
    end
  end

  context 'when passing any arguments' do
    let(:connection) { mock(Mongo::Connection) }
    let(:arguments)  { [:foo,{:bar => :baz}]   }

    before do
      Mongo::Connection.stub(:new => connection)
    end

    its(:connection) { should be(connection) }

    it 'should forward arguments to Mongo::Connection.new' do
      Mongo::Connection.should_receive(:new).with(*arguments).and_return(connection)
      subject.connection.should == connection
    end

    it { should be_frozen }
  end
end
