require 'spec_helper'

describe Adapter::Mongo::Literal, '#sort' do
  subject { object.sort(directions) }

  let(:object)    { Adapter::Mongo::Literal     }
  let(:attribute) { Attribute::Integer.new(:id) }

  let(:directions) do
    [
      Relation::Operation::Order::Ascending.new(attribute),
      Relation::Operation::Order::Descending.new(attribute)
    ]
  end

  it { should == [[:id, Mongo::ASCENDING],[:id,Mongo::DESCENDING]] }
end
