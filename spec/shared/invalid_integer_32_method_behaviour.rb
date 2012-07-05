shared_examples_for 'an invalid int32' do
  it 'should raise error' do
    expect { subject }.to raise_error(ArgumentError,"Not a valid int32: #{value.inspect}")
  end
end
