RSpec.shared_examples "a valid factory" do
  context 'FactoryBot testing' do
    it 'has a valid factory' do
      factory_name = described_class.model_name.param_key.to_sym
      factory = FactoryBot.build(factory_name)
      expect(factory).to be_valid
    end
  end
end