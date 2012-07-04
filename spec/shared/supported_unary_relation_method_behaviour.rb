# encoding: utf-8

shared_examples_for 'a supported unary relation method' do

  let(:adapter)   { mock('Adapter')                         }
  let(:relation)  { mock('Relation', operation => response) }
  let(:header)    { Relation::Header.new([[:id,Integer]])   }
  let(:response)  { mock('New Relation',:kind_of? => true, :class => factory, :header => header, :directions => header) }
  let!(:object)   { described_class.new(adapter, relation)  }

  unless instance_methods.map(&:to_s).include?('block')
    let(:block) { nil }
  end

  context 'first call' do
    subject { object.public_send(operation,*arguments,&block) }

    before do
      described_class.stub!(:new).and_return(gateway)
    end

    let(:gateway) { mock('New Gateway') }

    it { should equal(gateway) }

    it 'forwards the arguemnts to relation' do
      relation.should_receive(operation).with(*arguments).and_return(response)
      subject
    end

    it 'forwards the block to relation' do
      if block
        relation.stub!(operation) { |proc| proc.should equal(block) }
      end
      subject
    end

    it 'initializes the new gateway with the adapter and response' do
      described_class.should_receive(:new).with(adapter, response, [factory].to_set)
      subject
    end
  end

  context 'second call' do
    let(:first) { object.public_send(operation,*arguments,&block) }

    subject { first.public_send(operation,*arguments,&block) } 

    it { should be_a(factory) }

    its(:operand) { should equal(first) }
  end
end
