require 'spec_helper'

describe Adapter::Mongo,'#database' do
  subject { object.database }

  let(:object) { described_class.new(database) }

  let(:database) { mock(Mongo::DB) }

  it_should_behave_like 'an idempotent method'

  it { should be(database) }
end
