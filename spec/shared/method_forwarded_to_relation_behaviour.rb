shared_examples_for 'a method forwarded to relation' do
  subject { object.public_send(operation,*arguments,&block) }

  let(:object)   { described_class.new(adapter,relation) }
  let(:relation) { mock('Relation', operation => response) }
  let(:response) { mock('Response') }
  let(:adapter)  { mock('Adapter') }

  instance_methods = self.instance_methods.map(&:to_sym)

  unless instance_methods.include?(:block)
    let(:block) { nil }
  end

  unless instance_methods.include?(:argument)
    let(:arguments) { [] }
  end

  it 'should foward the message to wrapped relation' do
    relation.should_receive(operation).with(*arguments,&block).and_return(response)
    should be(response)
  end

  it 'forwards the block to relation' do
    if block
      relation.stub!(operation) { |proc| proc.should equal(block) }
    end
    subject
  end
end
