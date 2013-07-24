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
    it { subject.show_drinks.should == "コーラ 120円 5個" }
  end

  describe 'コーラが購入できるかどうかを取得できること' do
    context '投入金額が不足している場合' do
      before do
        subject.insert(100)
      end

      it { should_not be_available('コーラ') }
    end

    context "投入金額が足りている場合" do
      before do
        subject.insert(100)
        subject.insert(10)
        subject.insert(10)
      end

      it { should be_available('コーラ')}
    end

    context '投入金額が過剰である場合' do
      before do
        subject.insert(100)
        subject.insert(100)
      end

      it { should be_available('コーラ') }
    end

    context '在庫が不足している場合' do
      before do
        subject.drinks.clear

        subject.insert(10)
        subject.insert(100)
        subject.insert(10)
      end

      it { should_not be_available('コーラ') }
    end
  end

  describe '#sell' do
    context '投入金額が十分にある時' do
      before do
        subject.insert(10)
        subject.insert(100)
        subject.insert(10)
      end
      it {
        expect{subject.sell('コーラ')}.to change{subject.stock_of('コーラ')}.by(-1)
      }
    end
  end

  describe '#stock_of' do
    it { subject.stock_of('コーラ').should == 5 }
  end

  describe "#sales" do
    context "何も売りあげていない状態で" do
      it { subject.sales.should == 0 }
    end

    context "コーラを売り上げた状態で" do
      before do
        subject.insert(500)
        subject.sell('コーラ')
      end

      it { subject.sales.should == 120 }

      describe "払い戻し操作" do
        it "釣り銭が出力されること" do
          subject.refund.should == 380
        end
      end
    end

  end

  describe '在庫を追加' do

    context 'レッドブル５本と、水５本を追加した時' do
      before do
        subject.stock Drink.new('レッドブル', 200)
        subject.stock Drink.new('レッドブル', 200)
        subject.stock Drink.new('レッドブル', 200)
        subject.stock Drink.new('レッドブル', 200)
        subject.stock Drink.new('レッドブル', 200)

        subject.stock Drink.new('水', 100)
        subject.stock Drink.new('水', 100)
        subject.stock Drink.new('水', 100)
        subject.stock Drink.new('水', 100)
        subject.stock Drink.new('水', 100)
      end
      it { subject.stock_of('レッドブル').should == 5 }
      it { subject.stock_of('水').should == 5 }
    end
  end

  describe "ドリンクリスト" do
    it "取得できる" do
      subject.list_drinks.sort.should == ["コーラ"].sort
    end
  end

  describe "購入可能なドリンクリスト" do
    context "初期状態かつお金を入れていないとき" do
      it { subject.available_drinks.should be_empty }
    end

    context "十分な量のお金を投入した時" do
      before do
        subject.insert(500)
      end
      it { subject.available_drinks.should == ["コーラ"]}
    end
  end
end
