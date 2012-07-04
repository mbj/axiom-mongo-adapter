# encoding: utf-8

shared_examples_for 'an #each method' do
  it_should_behave_like 'a command method'

  context 'with no block' do
    subject { object.each }

    it 'returns instance of Enumerator' do
      should be_instance_of(to_enum.class)
    end

    it 'yields the expected values' do
      subject.to_a.should eql(object.to_a)
    end
  end
end
