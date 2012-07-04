require 'spec_helper'

describe Adapter::Mongo,'#connection' do
  subject { object.connection }

  let(:object) { described_class.new(connection) }

  let(:connection) { mock(Mongo::Connection) }

  before do
    Mongo::Connection.stub(:=== => true)
  end

  it_should_behave_like 'an idempotent method'

  it { should be(connection) }
end
