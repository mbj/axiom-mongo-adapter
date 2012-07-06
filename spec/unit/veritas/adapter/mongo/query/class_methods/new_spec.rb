require 'spec_helper'

describe Adapter::Mongo::Query,'.new' do
  subject { object.new(database,relation) }

  let(:object)   { described_class                      }
  let(:database) { mock(Mongo::DB, :collection => mock) }
  let(:relation) { BASE_RELATION                        }

  it { should be_frozen }
end
