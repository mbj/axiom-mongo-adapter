require 'spec_helper'

describe Adapter::Mongo::Gateway, '#empty?' do
  let(:operation) { :empty? }

  it_should_behave_like 'a method forwarded to relation'
end
