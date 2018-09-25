require_relative './cs253Array.rb'
require_relative './triple.rb'
require 'pry'

RSpec.describe CS253Array do

  describe 'Triple' do
    describe '#each' do
      it 'iterates through elements' do
        triple = Triple.new(1,nil,3)
        output = []
        triple.each{ |item| output << item }
        expect(output).to eq([1,nil,3])
      end
    end
  end

  describe '#cs253all?' do
    let(:array) { described_class.new([1, 2, 3]) }

    it 'returns true when all elements evaluate to truethy' do
      expect(array.cs253all?{ |item| item < 4 }).to be true
    end

    it 'returns false when one element evaluates to falsy' do
      expect(array.cs253all?{ |item| item < 3 }).to be false
    end

    it 'returns true when empty' do
      array = described_class.new([])
      expect(array.cs253all?{ |item| item }).to be true
    end
  end

  describe '#cs253any?' do
    let(:array) { described_class.new([1, 2, 3]) }

    it 'returns true if any element evaluate to truethy' do
      expect(array.cs253any?{ |item| item < 2 }).to be true
    end

    it 'returns false when all element evaluates to falsy' do
      expect(array.cs253any?{ |item| item < 1 }).to be false
    end

    it 'returns false when empty' do
      array = described_class.new([])
      expect(array.cs253any?{ |item| item }).to be false
    end
  end

  describe '#cs253chunk' do
    it 'returns correct chunks' do
      # site: test array taken from https://ruby-doc.org/core-2.5.1/Enumerable.html#method-i-chunk
      array = described_class.new([3, 1, 4, 1, 5, 9])
      expect(array.cs253chunk{ |item| item.even? }.to_a).to eq([
        [false, [3, 1]],
        [true, [4]],
        [false, [1, 5, 9]]
      ])
    end

    it 'ignores elements that return nil' do
      array = described_class.new([3, 1, nil, 4, 1, nil, 5, 9])
      expect(array.cs253chunk{ |item| item&.even? }).to eq([
        [false, [3, 1]],
        [true, [4]],
        [false, [1, 5, 9]]
      ])
    end

    it 'returns empty array when input is empty' do
      array = described_class.new([])
      expect(array.cs253chunk{ |item| item.even? }).to eq([])
    end
  end

  # test array taken from https://ruby-doc.org/core-2.4.4/Enumerable.html#method-i-chunk_while
  describe '#cs253chunk_while' do
    it 'returns correct chunks' do
      array = described_class.new([0, 9, 2, 2, 3, 2, 7, 5, 9, 5])
      expect(array.cs253chunk_while{ |i, j| i <= j }).to eq [
        [0, 9], [2, 2, 3], [2, 7], [5, 9], [5]
      ]
    end

    it 'returns empty array when input is empty' do
      array = described_class.new([])
      expect(array.cs253chunk_while{ |i, j| i <= j }).to eq []
    end

    it 'handles nil properly' do
      array = described_class.new([3, 1, nil, 4, 1, nil, 5, 9])
      expect(array.cs253chunk_while{ |i, j| i&.even? }).to eq([
        [3], [1], [nil], [4, 1], [nil], [5], [9]
      ])
    end

    it 'handles additional example correctly' do
      array = described_class.new([1,2,4,9,10,11,12,15,16,19,20,21])
      expect(array.cs253chunk_while{ |i, j| i + 1 == j }).to eq([
        [1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]
      ])
    end
  end

  describe '#cs253collect' do
    it 'returns empty array when given empty array' do
      array = described_class.new([])
      expect(array.cs253collect{ |item| item + 1 }).to eq []
    end

    it 'returns incremented array of items' do
      array = described_class.new([1,2,3])
      expect(array.cs253collect{ |item| item + 1 }).to contain_exactly(2,3,4)
    end

    it 'returns incremented array of items - case 2' do
      array = described_class.new([1,2,3])
      expect(array.cs253collect{ |item| item + 2 }).to contain_exactly(3,4,5)
    end
  end

  describe '#cs253collect_concat' do
    it 'returns empty array when given empty array' do
      array = described_class.new([])
      expect(array.cs253collect_concat{ |item| item + 1 }).to eq []
    end

    it 'returns flattened and incremented elements' do
      array = described_class.new([[1, 2], [3], [4, 5]])
      expect(array.cs253collect_concat{ |item| item + [10] }).to eq([1,2,10,3,10,4,5,10])
    end

    it 'returns flattened and incremented elements - 2' do
      array = described_class.new([1, 2, 4, 5])
      expect(array.cs253collect_concat{ |item| item + 1 }).to eq([2,3,5,6])
    end
  end

  describe '#cs253count' do
    let(:array) { described_class.new([1,2,3]) }

    it 'returns size when neither item nor block is given' do
      expect(array.cs253count).to eq 3
    end

    it 'returns size of items that match given item' do
      expect(array.cs253count(2)).to eq 1
    end

    it 'returns size of items that returns true in given block' do
      expect(array.cs253count{ |i| i > 1}).to eq 2
    end
  end

  describe '#cs253cycle' do
    it 'iterates specified times' do
      output = []
      expect(described_class.new([1,2,3]).cs253cycle(3){ |i| output << i }).to be_nil
      expect(output).to eq([1,2,3,1,2,3,1,2,3])
    end

    it 'returns nil when array is empty' do
      array = described_class.new([])
      expect(array.cs253cycle{ |i| output << i }).to be_nil
    end
  end

  describe '#cs253detect' do
    let(:array) { described_class.new([1,2,3]) }

    it 'returns first member that returns truethy' do
      expect(array.cs253detect{ |item| item >= 2 }).to eq 2
    end

    it 'returns nil if no member returns truethy' do
      expect(array.cs253detect{ |item| item > 3 }).to be_nil
    end

    it 'returns nil when empty' do
      expect(described_class.new([]).cs253detect{ |item| item > 3 }).to be_nil
    end
  end

  describe '#cs253drop' do
    let(:array) { described_class.new([1,2,3]) }

    it 'returns remaining elements if exists' do
      expect(array.cs253drop(1)).to eq [2,3]
    end

    it 'returns empty collection when drop more than original size' do
      expect(array.cs253drop(4)).to eq []
    end

    it 'returns empty collection when input is empty' do
      expect(described_class.new([]).cs253drop(3)).to eq []
    end
  end

  describe '#cs253drop_while' do
    let(:array) { described_class.new([1, 2, 3, 4, 5, 0]) }

    it 'returns remaining elements if exists' do
      expect(array.cs253drop_while{ |i| i < 3 }).to eq [3,4,5,0]
    end

    it 'returns empty collection when every element returns truethy' do
      expect(array.cs253drop_while{ |i| i < 6 }).to eq []
    end

    it 'returns whole collection when first element returns falsy' do
      expect(array.cs253drop_while{ |i| i < 1 }).to eq [1, 2, 3, 4, 5, 0]
    end
  end

  describe '#cs253each_cons' do
    let(:array) { described_class.new([1, 2, 3, 4, 5, 0]) }

    it 'invokes block with correct sub array' do
      output = []
      array.cs253each_cons(3) do |arr|
        output << arr
      end
      expect(output).to eq([[1,2,3], [2,3,4], [3,4,5], [4,5,0]])
    end

    it 'does not invoke block when n is larger than size' do
      output = []
      array.cs253each_cons(10) do |arr|
        output << arr
      end
      expect(output).to eq([])
    end

    it 'returns nil' do
      _ = []
      output = array.cs253each_cons(3) do |arr|
        _ << arr
      end
      expect(output).to be_nil
    end
  end

  describe '#cs253each_entry' do
    let(:array) { described_class.new([1, 2, 3]) }

    it 'yields each item' do
      output = []
      array.cs253each_entry{ |i| output << i }
      expect(output).to eq [1,2,3]
    end

    it 'returns collection' do
      output = []
      expect(array.cs253each_entry{ |i| output << i }).to eq(array)
    end

    it 'works on empty collection' do
      array = described_class.new([])
      _ = []
      output = array.cs253each_entry{ |i| _ << i }
      expect(output).to eq(array)
    end
  end

  describe '#cs253each_slice' do
    let(:array) { described_class.new([1, 2, 3, 4, 5]) }

    it 'invokes block with correct sub array' do
      output = []
      array.cs253each_slice(2) do |arr|
        output << arr
      end
      expect(output).to eq([[1,2],[3,4], [5]])
    end

    it 'yields self if n is larger than size' do
      output = []
      array.cs253each_slice(10) do |arr|
        output << arr
      end
      expect(output).to eq([[1,2,3,4,5]])
    end

    it 'returns nil' do
      _ = []
      output = array.cs253each_slice(3) do |arr|
        _ << arr
      end
      expect(output).to be_nil
    end
  end

  describe '#cs253each_with_index' do
    let(:array) { described_class.new([1, 2, 3]) }

    it 'invokes block with correct sub array' do
      output = []
      array.cs253each_with_index do |item, index|
        output << [item, index]
      end
      expect(output).to eq([[1,0],[2,1], [3,2]])
    end

    it 'works with empty collection' do
      array = described_class.new([])
      output = []
      array.cs253each_with_index do |item, index|
        output << [item, index]
      end
      expect(output).to eq([])
    end

    it 'returns collection' do
      output = array.cs253each_with_index{ |item, index| item }
      expect(output).to eq(array)
    end
  end

  describe '#cs253each_with_object' do
    let(:array) { described_class.new([1, 2, 3, 4, 5]) }
    it 'yields object' do
      sum = array.cs253each_with_object({sum: 0}) do |i, o|
        o[:sum] += i
      end
      expect(sum[:sum]).to eq(15)
    end

    it 'yields object when collection is empty' do
      sum = described_class.new([]).cs253each_with_object({sum: 0}) do |i, o|
        o[:sum] += i
      end
      expect(sum[:sum]).to eq(0)
    end

    it 'returns object' do
      obj = :foo
      expect(described_class.new([]).cs253each_with_object(obj){ |i, o| }).to eq obj
    end
  end

  describe '#cs253entries' do
    specify { expect(described_class.new([1, 2, 3]).entries).to eq([1,2,3]) }
    specify { expect(described_class.new([1, 2]).entries).to eq([1,2]) }
    specify { expect(described_class.new([1]).entries).to eq([1]) }
  end

  describe '#cs253find' do
    let(:array) { described_class.new([1,2,3]) }

    it 'returns first member that returns truethy' do
      expect(array.cs253find{ |item| item >= 2 }).to eq 2
    end

    it 'returns nil if no member returns truethy' do
      expect(array.cs253find{ |item| item > 3 }).to be_nil
    end

    it 'returns nil when empty' do
      expect(described_class.new([]).cs253find{ |item| item > 3 }).to be_nil
    end
  end

  describe '#cs253find_all' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns empty array when given empty array' do
      expect(described_class.new([]).cs253find_all{ |item| item > 1 }).to eq []
    end

    it 'only returns items that are larger than 1' do
      expect(array.cs253find_all{ |item| item > 1 }).to contain_exactly(2,3)
    end

    it 'only returns items that are larger than 2' do
      expect(array.cs253find_all{ |item| item > 2 }).to eq [3]
    end
  end

  describe '#cs253find_index' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns item of the matched element in block' do
      expect(array.cs253find_index{ |i| i > 1 }).to eq 1
    end

    it 'returns item of the matched element in arg' do
      expect(array.cs253find_index(2)).to eq 1
    end

    it 'returns nil if not found' do
      expect(array.cs253find_index(4)).to be_nil
    end
  end

  describe '#cs253first' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns first element if no arg' do
      expect(array.first).to eq(1)
    end

    it 'returns first n elements when n is provided' do
      expect(array.first(2)).to eq [1,2]
    end

    it 'returns all elements when n > size' do
      expect(array.first(5)).to eq [1,2,3]
    end
  end

  describe '#cs253flat_map' do
    it 'returns empty array when given empty array' do
      array = described_class.new([])
      expect(array.cs253flat_map{ |item| item + 1 }).to eq []
    end

    it 'returns incremented array of items' do
      array = described_class.new([[1],[2,3]])
      expect(array.cs253flat_map{ |item| item }).to contain_exactly(1,2,3)
    end

    it 'returns incremented array of items - case 2' do
      array = described_class.new([[1,2,3], 1])
      expect(array.cs253flat_map{ |item| item }).to contain_exactly(1,2,3,1)
    end
  end

  describe '#cs253grep' do
    let(:array) { described_class.new(['boo','foo','woo']) }
    it 'returns empty array when given empty array' do
      expect(described_class.new([]).cs253grep(/oo/)).to eq []
    end

    it 'only returns items that match the pattern' do
      expect(array.cs253grep(/boo/)).to contain_exactly('boo')
    end

    it 'only returns items that match provided pattern' do
      expect(array.cs253grep(/oo/)).to eq ['boo','foo','woo']
    end
  end

  describe '#cs253grep_v' do
    let(:array) { described_class.new(['boo','foo','woo']) }
    it 'returns empty array when given empty array' do
      expect(described_class.new([]).cs253grep_v(/oo/)).to eq []
    end

    it 'only returns items that match the pattern' do
      expect(array.cs253grep_v(/boo/)).to contain_exactly('foo', 'woo')
    end

    it 'only returns items that match provided pattern' do
      expect(array.cs253grep_v(/oo/)).to eq []
    end
  end

  describe '#cs253group_by' do
    let(:array) { described_class.new(['bbo','fboo','wooo']) }
    it 'groups element by block return' do
      expect(array.group_by{ |item| item[1] }).to eq({
        'b' => ['bbo', 'fboo'],
        'o' => ['wooo']
      })
    end

    it 'groups elements' do
      expect(array.group_by{ |item| item[2] }).to eq({
        'o' => ['bbo', 'fboo', 'wooo']
      })
    end

    it 'returns hash when empty' do
      expect(described_class.new([]).group_by{ |item| item }).to eq({})
    end
  end

  describe '#cs253include?' do
    let(:array) { described_class.new(['boo','foo','woo']) }
    it { expect(array.cs253include?('foo')).to be true }
    it { expect(array.cs253include?('woo')).to be true }
    it { expect(array.cs253include?('wooo')).to be false }
  end

  describe '#cs253map' do
    it 'returns empty array when given empty array' do
      array = described_class.new([])
      expect(array.cs253map{ |item| item + 1 }).to eq []
    end

    it 'returns incremented array of items' do
      array = described_class.new([1,2,3])
      expect(array.cs253map{ |item| item + 1 }).to contain_exactly(2,3,4)
    end

    it 'returns incremented array of items - case 2' do
      array = described_class.new([1,2,3])
      expect(array.cs253map{ |item| item + 2 }).to contain_exactly(3,4,5)
    end
  end

  describe '#cs253max' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns nil when given empty array' do
      expect(described_class.new([]).cs253max).to be_nil
    end

    it 'returns max n number of elements' do
      expect(array.cs253max(2)).to eq [3,2]
    end

    it 'returns the max value when given non-empty array' do
      expect(array.cs253max).to eq 3
    end
  end

  describe '#cs253max_by' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns nil when given empty array' do
      expect(described_class.new([]).cs253max_by).to be_nil
    end

    it 'returns max n number of elements' do
      expect(array.cs253max_by(2){ |i| -1 * i }).to eq [1, 2]
    end

    it 'returns the max value when given non-empty array' do
      expect(array.cs253max_by{ |i| -1 * i}).to eq 1
    end
  end

  describe '#cs253member?' do
    let(:array) { described_class.new(['boo','foo','woo']) }
    it { expect(array.cs253member?('foo')).to be true }
    it { expect(array.cs253member?('woo')).to be true }
    it { expect(array.cs253member?('wooo')).to be false }
  end

  describe '#cs253min' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns nil when given empty array' do
      expect(described_class.new([]).cs253min).to be_nil
    end

    it 'returns min n number of elements' do
      expect(array.cs253min(2)).to eq [1,2]
    end

    it 'returns the min value when given non-empty array' do
      expect(array.cs253min).to eq 1
    end
  end

  describe '#cs253min_by' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns nil when given empty array' do
      expect(described_class.new([]).cs253min_by).to be_nil
    end

    it 'returns min n number of elements' do
      expect(array.cs253min_by(2){|i| -1 * i }).to eq [3, 2]
    end

    it 'returns the min value when given non-empty array' do
      expect(array.cs253min_by{|i| -1 * i }).to eq 3
    end
  end

  describe '#cs253minmax' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns nil when given empty array' do
      expect(described_class.new([]).cs253minmax).to eq [nil, nil]
    end

    it 'returns minmax of elements' do
      expect(array.cs253minmax).to eq [1,3]
    end

    it 'returns minmax based on block' do
      expect(described_class.new([1,-2,3]).cs253minmax{ |i| -1 * i }).to eq([3, -2])
    end
  end

  describe '#cs253minmax_by' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns nil when given empty array' do
      expect(described_class.new([]).cs253minmax_by).to eq [nil, nil]
    end

    it 'returns minmax of elements' do
      expect(array.cs253minmax_by{ |i| -1 * i }).to eq [3,1]
    end

    it 'returns minmax based on block' do
      expect(described_class.new([1,-2,3]).cs253minmax_by{ |i| -1 * i }).to eq([3, -2])
    end
  end

  describe '#cs253none?' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns true when nothing returns true' do
      expect(array.cs253none?{ |i| i> 3}).to eq true
    end

    it 'returns false when any element returns true' do
      expect(array.cs253none?{ |i| i> 2 }).to eq false
    end

    it 'returns true when empty' do
      expect(described_class.new([]).cs253none?).to eq true
    end
  end

  describe '#cs253one?' do
    let(:array) { described_class.new([1,2,3]) }
    it { expect(array.cs253one?{ |i| i == 2 }).to be true }
    it { expect(array.cs253one?{ |i| i == 4 }).to be false }
    it { expect(array.cs253one?{ |i| i > 1 }).to be false }
  end

  describe '#cs253partition' do
    let(:array) { described_class.new([1,2,3]) }
    it { expect(array.cs253partition{ |i| i > 2 }).to eq([[3], [1,2]]) }
    it { expect(array.cs253partition{ |i| i > 3 }).to eq([[], [1,2,3]]) }
    it { expect(array.cs253partition{ |i| i < 4 }).to eq([[1,2,3], []]) }
  end

  describe '#cs253reduce' do
    let(:array) { described_class.new([1,2,3]) }

    it 'returns empty nil when collection is empty' do
      array = described_class.new([])
      expect(array.cs253reduce{ |sum, item| sum + item }).to be_nil
    end

    it 'returns first item when only 1 item is present' do
      array = described_class.new([1])
      expect(array.cs253reduce{ |sum, item| sum + item }).to eq 1
    end

    it 'returns sum of all items when initial value is not provided' do
      output = array.cs253reduce do |sum, item|
        sum + item
      end
      expect(output).to eq 6
    end

    it 'returns sum of all items + initial value when initial value is provided' do
      output = array.cs253reduce(10) do |sum, item|
        sum + item
      end
      expect(output).to eq 16
    end
  end

  describe '#cs253inject' do
    let(:array) { described_class.new([1,2,3]) }

    it 'returns empty nil when collection is empty' do
      array = described_class.new([])
      expect(array.cs253inject{ |sum, item| sum + item }).to be_nil
    end

    it 'returns first item when only 1 item is present' do
      array = described_class.new([1])
      expect(array.cs253inject{ |sum, item| sum + item }).to eq 1
    end

    it 'returns sum of all items when initial value is not provided' do
      output = array.cs253inject do |sum, item|
        sum + item
      end
      expect(output).to eq 6
    end

    it 'returns sum of all items + initial value when initial value is provided' do
      output = array.cs253inject(10) do |sum, item|
        sum + item
      end
      expect(output).to eq 16
    end
  end

  describe '#cs253reverse_each' do
    let(:array) { described_class.new([1,2,3]) }
    it 'yields each element in reverse' do
      output = []
      array.cs253reverse_each{ |i| output << i}
      expect(output).to eq [3,2,1]
    end

    it 'yields each element in reverse - 2' do
      output = []
      described_class.new([1,2,3,4]).cs253reverse_each{ |i| output << i}
      expect(output).to eq [4,3,2,1]
    end

    it 'returns self' do
      output = []
      expect(array.cs253reverse_each{ |i| output << i }).to eq array
    end
  end

  describe '#cs253select' do
    let(:array) { described_class.new([1,2,3]) }
    it 'returns empty array when given empty array' do
      expect(described_class.new([]).cs253select{ |item| item > 1 }).to eq []
    end

    it 'only returns items that are larger than 1' do
      expect(array.cs253select{ |item| item > 1 }).to contain_exactly(2,3)
    end

    it 'only returns items that are larger than 2' do
      expect(array.cs253select{ |item| item > 2 }).to eq [3]
    end
  end

  describe '#cs253sum' do
    let(:array) { described_class.new([1,2,3]) }
    it { expect(array.cs253sum).to eq 6 }
    it { expect(array.cs253sum{ |i| i * 2 }).to eq 12 }
    it { expect(described_class.new([]).cs253sum).to eq 0 }
  end

  describe '#cs253take' do
    let(:array) { described_class.new([1,2,3]) }
    it { expect(array.cs253take(2)).to eq [1,2] }
    it { expect(array.cs253take(4)).to eq [1,2,3] }
    it { expect(array.cs253take(1)).to eq [1] }
  end

  describe '#cs253take_while' do
    let(:array) { described_class.new([1,2,3]) }
    it { expect(array.cs253take_while{ |i| i < 3 }).to eq [1,2] }
    it { expect(array.cs253take_while{ |i| i < 5 }).to eq [1,2,3] }
    it { expect(array.cs253take_while{ |i| i > 1 }).to eq [] }
  end

  describe '#cs253to_a' do
    it { expect(described_class.new([1,2,3]).cs253to_a).to eq [1,2,3] }
    it { expect(described_class.new([1]).cs253to_a).to eq [1] }
    it { expect(described_class.new([]).cs253to_a).to eq [] }
  end

  describe '#cs253to_h' do
    it { expect(described_class.new([[:foo,1], [:bar,2]]).cs253to_h).to eq({foo:1, bar:2}) }
    it { expect(described_class.new([['foo',1], ['bar',2]]).cs253to_h).to eq({'foo'=>1, 'bar'=>2}) }
    it { expect(described_class.new([]).cs253to_h).to eq({}) }
  end

  describe '#cs253uniq' do
    it { expect(described_class.new([1,2,3,2]).cs253uniq).to eq [1,2,3] }
    it { expect(described_class.new([1,2,3,-2]).cs253uniq{ |i| i.abs }).to eq [1,2,3] }
    it { expect(described_class.new([]).cs253uniq{ |i| i.abs }).to eq [] }
  end

  describe '#cs253zip' do
    it {
      expect(described_class.new([1,2,3,2]).cs253zip([11,22,33], [4,5,6,7])).to eq([
        [1,11,4], [2,22,5], [3,33,6], [2,nil,7]
      ])
    }

    it {
      expect(described_class.new([1,2]).cs253zip([11,22,33], [4,5,6,7])).to eq([[1,11,4], [2,22,5]])
    }

    it 'works with block' do
      output = []
      described_class.new([1,2]).cs253zip([11,22,33], [4,5,6,7]) do |a, b, c|
        output << (a+b+c)
      end
      expect(output).to eq([16, 29])
    end
  end

  describe '#cs253length' do
    it { expect(described_class.new([1,2,3]).cs253length).to eq 3 }
    it { expect(described_class.new([1,2,3,4]).cs253length).to eq 4 }
    it { expect(described_class.new([]).cs253length).to eq 0 }
  end

  describe '#cs253slice_after' do
    it {
      expect(described_class.new(['bbb', 'aaa', 'ccc']).cs253slice_after(/aaa/))
        .to eq([['bbb', 'aaa'], ['ccc']])
    }

    it {
      expect(described_class.new(['bbb', 'aaa', 'ccc']).cs253slice_after(/hello/))
        .to eq([['bbb', 'aaa', 'ccc']])
    }

    it {
      expect(
        described_class.new(['bbb', 'aaa', 'ccc']).cs253slice_after do |item|
          item == 'aaa'
        end
      ).to eq([['bbb', 'aaa'], ['ccc']])
    }
  end

  describe '#cs253slice_before' do
    it {
      expect(described_class.new(['bbb', 'aaa', 'ccc']).cs253slice_before(/aaa/))
        .to eq([['bbb'], ['aaa', 'ccc']])
    }

    it {
      expect(described_class.new(['bbb', 'aaa', 'ccc']).cs253slice_before(/hello/))
        .to eq([['bbb', 'aaa', 'ccc']])
    }

    it {
      expect(
        described_class.new(['bbb', 'aaa', 'ccc']).cs253slice_before do |item|
          item == 'aaa'
        end
      ).to eq([['bbb'], ['aaa', 'ccc']])
    }
  end

  describe '#cs253slice_when' do
    it {
      expect(
        described_class.new(['bbb', 'aaa', 'ccc']).cs253slice_when do |item|
          item == 'aaa'
        end
      ).to eq([['bbb', 'aaa'], ['ccc']])
    }

    it {
      expect(
        described_class.new([]).cs253slice_when do |item|
          item == 'aaa'
        end
      ).to eq([])
    }

    it {
      expect(
        described_class.new([1,2,4,9,10,11,12,15,16,19,20,21]).cs253slice_when do |a, b|
          a + 1 != b
        end
      ).to eq([[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]])
    }
  end

end
