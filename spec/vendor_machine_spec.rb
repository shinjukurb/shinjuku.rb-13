require_relative '../lib/vendor_machine'
describe VendorMachine do
  describe '#insert' do
    it 'succeeds' do
      expect { subject.insert(100) }.not_to raise_error
    end
  end
end
