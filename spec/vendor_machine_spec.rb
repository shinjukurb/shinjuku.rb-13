# -*- coding: utf-8 -*-
require_relative '../lib/vendor_machine'

describe VendorMachine do
  describe '#insert' do
    context '100円入れた時' do
      before do
        subject.insert(100)
      end

      it '合計が100円になる' do
        subject.total.should == 100
      end

      it '投入に成功するとnilが返る' do
        subject.insert(100).should == nil
      end

      context 'さらに1,000円入れた時' do
        before do
          subject.insert(1000)
        end

        it '合計が1100円になる' do
          subject.total.should == 1100
        end
      end
    end

    context '想定外のお金が投入された時' do
      context '1円玉が投入された時' do
        before do
          subject.insert(1)
        end

        it '投入したお金が返却されること' do
          subject.insert(1).should == 1
        end

        it '合計が0円になる' do
          subject.total.should == 0
        end
      end

      context '5円玉が投入された時' do
        before do
          subject.insert(5)
        end

        it '投入したお金が返却されること' do
          subject.insert(5).should == 5
        end

        it '合計が0円になる' do
          subject.total.should == 0
        end
      end

      context '2,000円札が投入された時' do
        before do
          subject.insert(2000)
        end

        it '投入したお金が返却されること' do
          subject.insert(2000).should == 2000
        end

        it '合計が0円になる' do
          subject.total.should == 0
        end
      end

      context '5,000円札が投入された時' do
        before do
          subject.insert(5000)
        end

        it '投入したお金が返却されること' do
          subject.insert(5000).should == 5000
        end

        it '合計が0円になる' do
          subject.total.should == 0
        end
      end

      context '10,000円札が投入された時' do
        before do
          subject.insert(10000)
        end

        it '投入したお金が返却されること' do
          subject.insert(10000).should == 10000
        end

        it '合計が0円になる' do
          subject.total.should == 0
        end
      end
    end
  end

  describe '合計値を取得できること' do
    before do
      subject.insert(100)
    end

    it '合計が100円になる' do
      subject.total.should == 100
    end
  end

  describe '払い戻しができること' do
    context "100円入っている時" do
      before do
        subject.insert(100)
      end

      it '100円払い戻されること' do
        subject.refund.should == 100
      end
    end

    context "1000円入っている時" do
      before do
        subject.insert(1000)
      end

      it '1000円払い戻されること' do
        subject.refund.should == 1000
      end
    end

    context '払い戻した後' do
      before do
        subject.insert(1000)
        subject.refund
      end

      it '合計金額が0円になる' do
        subject.total.should == 0
      end
    end
  end

  describe 'ジュースの情報（値段と名前と在庫）を取得できること' do
    it { subject.show_drinks.should == {name: 'コーラ', price: 120, stock: 5} }
  end
end
