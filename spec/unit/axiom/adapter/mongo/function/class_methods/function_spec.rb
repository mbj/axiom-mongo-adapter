require 'spec_helper'

describe Adapter::Mongo::Function, '.function' do
  subject { object.function(function) }

  let(:object) { Adapter::Mongo::Function }

  let(:attribute) { Attribute::Integer.new(:id)       }

  context 'with equality function' do
    let(:function) { Function::Predicate::Equality.new(attribute, 1) }

    it 'should return equality literal' do
      should == { :id => 1 }
    end
  end

  context 'with inequality function' do
    let(:function) { Function::Predicate::Inequality.new(attribute, 1) }

    it 'should return inequality literal' do
      should == { :id => { :$ne => 1 } }
    end
  end

  context 'with disjunction' do
    let(:left)     { Function::Predicate::Equality.new(attribute, 1) }
    let(:right)    { Function::Predicate::Equality.new(attribute, 2) }
    let(:function) { Function::Connective::Disjunction.new(left, right) }

    it 'should return disjunction literal' do
      should == { :$or => [{ :id => 1 }, { :id => 2} ] }
    end
  end

  context 'with conjunction' do
    let(:left)     { Function::Predicate::Equality.new(attribute, 1) }
    let(:right)    { Function::Predicate::Equality.new(attribute, 2) }
    let(:function) { Function::Connective::Conjunction.new(left, right) }

    it 'should return conjunction literal' do
      should == { :$and => [ { :id => 1 } , { :id => 2} ] }
    end
  end

  context 'with negation' do
    let(:inner_function) { Function::Predicate::Equality.new(attribute, 1) }
    let(:function)       { Function::Connective::Negation.new(inner_function) }

    it 'should return filter literal' do
      should == { :$not => { :id => 1 } }
    end
  end

  context 'with inclusion function' do
    let(:function) { Function::Predicate::Inclusion.new(attribute, [1,2,3]) }

    it 'should return filter literal' do
      should == { :id => { :$in => [1, 2,3] } }
    end
  end

  context 'with exclusion function' do
    let(:function) { Function::Predicate::Exclusion.new(attribute, [1,2,3]) }

    it 'should return filter literal' do
      should == { :id => { :$nin => [1, 2,3] } }
    end
  end

  context 'with greater than function' do
    let(:function) { Function::Predicate::GreaterThan.new(attribute, 1) }

    it 'should return filter literal' do
      should == { :id => { :$gt => 1 } }
    end
  end

  context 'with greater than or equal to function' do
    let(:function) { Function::Predicate::GreaterThanOrEqualTo.new(attribute, 1) }

    it 'should return filter literal' do
      should == { :id => { :$gte => 1 } }
    end
  end

  context 'with less than function' do
    let(:function) { Function::Predicate::LessThan.new(attribute, 1) }

    it 'should return filter literal' do
      should == { :id => { :$lt => 1 } }
    end
  end

  context 'with less than or equal to function' do
    let(:function) { Function::Predicate::LessThanOrEqualTo.new(attribute, 1) }

    it 'should return filter literal' do
      should == { :id => { :$lte => 1 } }
    end
  end
end
