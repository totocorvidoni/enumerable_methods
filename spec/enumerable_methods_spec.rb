require 'enumerable_methods'

describe 'My Enumerable Methods' do
  let(:ary) { [1, 2, 3, 4, 5] }
  let(:ary_nil) { [1, 2, 3, 4, 5, nil] }
  let(:a_proc) { proc { |x| x + 1 } }

  describe '.my_select does the same as .select' do
    context 'when a block is given' do
      it 'returns a new array containing all elements of ary for which the given block returns a true value' do
        expect(ary.my_select(&:even?)).to eq([2, 4])
      end
    end

    context 'when no block is given' do
      it 'returns an Enumerator' do
        expect(ary.my_select).to be_kind_of(Enumerator)
      end
    end
  end

  describe '.my_all? does the same as .all?' do
    context 'when a block is given' do
      it 'returns true only if all elements of object match the block' do
        expect(ary.my_all? { |x| x < 10 }).to be(true)
      end

      it 'returns false when any elements of object do not match the block' do
        expect(ary.my_all? { |x| x > 3 }).to be(false)
      end

      context 'when an argument is given' do
        it 'returns true only if all elements of object match the class' do
          expect(ary.my_all?(Numeric)).to be(true)
        end
        it 'returns true only if all elements of object match the pattern' do
          expect(ary.my_all?(1..9)).to be(true)
          expect(ary.my_all?(3..9)).to be(false)
        end
      end

      context 'when no block or argument is given' do
        it 'returns true only if all elements of obeject are neither false or nil' do
          expect(ary.my_all?).to be(true)
          expect(ary_nil.my_all?).to be(false)
        end
      end
    end
  end

  describe '.my_any? does the same as .any?' do
    context 'when a block is given' do
      it 'returns true if any one member of object matches the block' do
        expect(ary_nil.my_any? { |x| x < 3 }).to be(true)
      end
      it 'returns false if no member of object matches the block' do
        expect(ary_nil.my_any? { |x| x.is_a? String }).to be(false)
      end
    end

    context 'when an argument is given' do
      it 'returns true if any one member of object matches the argument' do
        expect(ary_nil.my_any?(Numeric)).to be(true)
        expect(ary_nil.my_any?(String)).to be(false)
      end
    end

    context 'when no block or argument is given' do
      it 'returns true if at least one of elements of object is neither false or nil' do
        expect(ary_nil.my_any?).to be(true)
      end
    end
  end

  describe '.my_none does the same thing as .none' do
    context 'when a block is given' do
      it 'returns true only if all elements of object returns false' do
        expect(ary.my_none? { |x| x > 10 }).to be(true)
      end
      it 'returns false if any elements of object returns true' do
        expect(ary.my_none? { |x| x > 3 }).to be(false)
      end
    end

    context 'when an argument is given' do
      it 'returns true only if no element matches the pattern' do
        expect(ary.my_none?(10)).to be(true)
        expect(ary.my_none?(2)).to be(false)
      end
    end

    context 'when no block or argument is given' do
      it 'returns true only of none of the collection members are true' do
        expect(ary.my_none?).to be(false)
      end
    end
  end

  describe '.my_count does the same thing as .count' do
    context 'when a block is given' do
      it 'it returns the number of elements yielding a true value' do
        expect(ary.my_count { |x| x > 2}).to eql(3)
        expect(ary.my_count { |x| x.is_a?(Numeric) }).to eql(5)
      end
    end

    context 'when an argument is given' do
      it 'returns the number of elements that are equal the argument' do
        expect(ary_nil.my_count(Numeric)).to eql(5)
      end
    end

    context 'when no block or argument are given' do
      it 'returns the amount of elements in object' do
        expect(ary_nil.my_count).to eql(6)
      end
    end
  end

  describe '.my_map does the same thing as .map' do
    context 'when a block is given' do
      it 'returns an array with the results of running the block on every element' do
        expect(ary.my_map { |x| x * 2 }).to eq([2, 4, 6, 8, 10])
      end
    end

    context 'when a proc is given' do
      it 'returns an array with the results of running the proc on every element' do
        expect(ary.my_map(&a_proc)).to eq([2, 3, 4, 5, 6])
      end
    end

    # Can't test this example because ruby trows an exception when both block and proc are given
    # context 'when a proc and a block is given' do
    #   it ' only executes the proc' do
    #     expect(ary.my_map(&a_proc) { |x| x * 2 }).to eq([2, 3, 4, 5, 6])       
    #   end
    # end

    context 'when no block is given' do
      it 'returns an Enumerator' do
        expect(ary.my_map).to be_kind_of(Enumerator)
      end
    end
  end
end