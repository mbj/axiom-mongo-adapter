shared_examples_for 'a method visiting an unsupported component more than once' do
  it 'should raise error' do
    expect { subject }.to(
      raise_error(Adapter::Mongo::UnsupportedAlgebraError,"No support for visiting #{factory} more than once")
    )
  end
end

