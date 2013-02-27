require_relative '../lib/vendor_machine'
describe VendorMachine do
  describe '投入できること' do
    context '100円入れた時' do
      before do
        subject.insert(100)
      end
      it '合計が100円になる' do
        subject.sum.should == 100
      end
      context 'さらに1,000円入れた時' do
        before do
          subject.insert(1000)
        end
        it '合計が1100円になる' do
          subject.sum.should == 1100
        end
      end
    end
  end
end
