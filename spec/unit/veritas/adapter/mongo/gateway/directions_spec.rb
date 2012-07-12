require 'spec_helper'

describe Adapter::Mongo::Gateway, '#directions' do
  subject { object.directions }

  let(:operation) { :directions }

  it_should_behave_like 'a method forwarded to relation'
end
