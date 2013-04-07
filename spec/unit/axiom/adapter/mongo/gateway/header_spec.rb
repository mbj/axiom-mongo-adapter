require 'spec_helper'

describe Adapter::Mongo::Gateway, '#header' do
  let(:operation) { :header }

  it_should_behave_like 'a method forwarded to relation'
end
