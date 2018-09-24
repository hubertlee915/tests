require 'minitest/autorun'
require './cs253Array.rb'
require './triple.rb'


class CS253EnumTests < Minitest::Test
   def test_cs253all?
        # assert_equal CS253Array.new([1, 2, 3]).cs253all?{|i| i > 0}, true
        assert_equal false, CS253Array.new(["string", "anotherString", "lastString"]).cs253all?{|i| i.length > 8}
        assert_equal false, CS253Array.new([nil, true, 99]).cs253all?
        assert_equal true, CS253Array.new([]).cs253all?
    end

   def test_cs253any?
        # assert_equal CS253Array.new([1, 2, 3]).cs253any?{|i| i > 0}, true
        assert_equal true, CS253Array.new(["string", "anotherString", "lastString"]).cs253any?{|i| i.length > 8}
        assert_equal true, CS253Array.new([nil, true, 99]).cs253any?
        assert_equal false, CS253Array.new([]).cs253any?
    end

    def test_cs253chunk
        assert_equal [[false, [3, 1]],[true, [4]],[false, [1, 5, 9]],[true, [2, 6]],[false, [5, 3, 5]]], CS253Array.new([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]).cs253chunk{|n|n.even?}
        assert_equal [], CS253Array.new([]).cs253chunk{|n|n.even?}
        assert_equal [[false,[3]]], CS253Array.new([3]).cs253chunk{|n|n.even?}
    end

    def test_cs253chunk_while
        assert_equal [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]], CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21]).cs253chunk_while {|i, j| i+1 == j}
        assert_equal [], CS253Array.new([]).cs253chunk_while {|i, j| i+1 == j}
        assert_equal [[1]], CS253Array.new([1]).cs253chunk_while {|i, j| i+1 == j}
    end

    def test_cs253collect
        assert_equal [], CS253Array.new([]).cs253collect{|i| i.length}
        assert_equal ["1","2","3"], CS253Array.new([1, 2, 3]).cs253collect{|i| i.to_s}
        assert_equal [6,13,10], CS253Array.new(["string", "anotherString", "lastString"]).cs253collect{|i| i.length}
    end

    def test_cs253collect_concat
        assert_equal [], CS253Array.new([]).cs253collect_concat{|i| [i,2*i,i**i]}
        assert_equal [1,2,1,2,4,4,3,6,27], CS253Array.new([1, 2, 3]).cs253collect_concat{|i| [i,2*i,i**i]}
        assert_equal [6,13,10], CS253Array.new(["string", "anotherString", "lastString"]).cs253collect{|i| i.length}
    end

    def test_cs253count
        ary = CS253Array.new([1, 2, 4, 2])
        assert_equal 4, ary.cs253count
        assert_equal 2, ary.cs253count(2)
        assert_equal 3, ary.count{|x| x%2==0}
    end

    def test_cs253cycle
        ary = CS253Array.new([1, 2, 4, 2])
        res = CS253Array.new([])
        assert_nil ary.cs253cycle(2) {|x| res << x}
        assert_equal [1, 2, 4, 2, 1, 2, 4, 2], res
        ary = CS253Array.new([1,2,3])
        res = CS253Array.new([])
        ary.cs253cycle(1) {|x| res << x}
        assert_equal [1,2,3], res
    end

    def test_cs253detect
        assert_nil CS253Array.new([]).cs253detect { |i| i % 5 == 0 and i % 7 == 0 }
        assert_nil CS253Array.new((1..10).to_a).cs253detect { |i| i % 5 == 0 and i % 7 == 0 }
        assert_equal 35, CS253Array.new((1..100).to_a).cs253detect { |i| i % 5 == 0 and i % 7 == 0 }
    end

    def test_cs253drop
        assert_equal [], CS253Array.new([]).cs253drop(1)
        assert_equal [], CS253Array.new([]).cs253drop(4)
        assert_equal [6,7,8,9], CS253Array.new([4,6,7,8,9]).cs253drop(1)
    end

    def test_cs253drop_while
        assert_equal [3, 4, 5, 0], CS253Array.new([1, 2, 3, 4, 5, 0]).cs253drop_while {|i| i < 3}
        assert_equal [], CS253Array.new([]).cs253drop_while {|i| i < 3}
        assert_equal [4, 2, 3, 4, 5, 0], CS253Array.new([4, 2, 3, 4, 5, 0]).cs253drop_while {|i| i < 3}
    end

    def test_cs253each_cons
        res = []
        assert_nil CS253Array.new((1..5).to_a).cs253each_cons(3) {|a| res << a}
        assert_equal [[1,2,3],[2,3,4],[3,4,5]], res
        res = []
        CS253Array.new((1..2).to_a).cs253each_cons(3) {|a| res << a}
        assert_equal [], res
    end

    def test_cs253each_entry
        res = []
        assert_equal Array, Triple.new(1,2,3).cs253each_entry{|o| res << o}.class
        assert_equal [1, 2, 3], res
        res = []
        Triple.new(1,[2,2],3).cs253each_entry{|o| res << o}
        assert_equal [1, [2,2], 3], res
    end

    def test_cs253each_slice
        res = []
        assert_nil CS253Array.new((1..10).to_a).each_slice(3) { |a| res << a }
        assert_equal [[1,2,3],[4,5,6],[7,8,9],[10]], res
        res = []
        CS253Array.new((1..0).to_a).each_slice(3) { |a| res << a }
        assert_equal [], res
    end

    def test_cs253each_with_index
        res = []
        assert_equal Array, Triple.new("cat", "dog", "wombat").cs253each_with_index { |item, index| res << [item, index]}.class
        assert_equal [["cat",0], ["dog",1], ["wombat",2]], res
        res = []
        CS253Array.new([1,3,4]).cs253each_with_index { |item, index| res << [item, index]}
        assert_equal [[1,0],[3,1],[4,2]], res
    end

    def test_cs253each_with_object
        evens = CS253Array.new([1,2,3,4,5,6,7,8,9,10]).cs253each_with_object([]) { |i, a| a << i*2 }
        assert_equal [2, 4, 6, 8, 10, 12, 14, 16, 18, 20], evens
        res = Triple.new(1,[2,3],3).cs253each_with_object([]) { |i, a| a << i*2 }
        assert_equal [2,[2, 3, 2, 3],6], res 
        test_hash = CS253Array.new(['one', 'two', 'one', 'one']).each_with_object(Hash.new(0)) do |item, hash|
            hash[item] += 1
        end
        gt_hash = {"one" => 3, "two" => 1}
        assert_equal gt_hash, test_hash
    end

    def test_cs253entries
        assert_equal [1,2,3,4,5], CS253Array.new([1,2,3,4,5]).cs253entries 
        assert_equal [1,2,3],Triple.new(1,2,3).cs253entries
        assert_equal ['cat','dog',1], Triple.new('cat','dog',1).cs253entries 
    end

    def test_cs253find
        assert_nil CS253Array.new([]).cs253find { |i| i % 5 == 0 and i % 7 == 0 }
        assert_equal false, CS253Array.new((1..10).to_a).cs253find(lambda {return false}) { |i| i % 5 == 0 and i % 7 == 0 }
        assert_equal 35, CS253Array.new((1..100).to_a).cs253find { |i| i % 5 == 0 and i % 7 == 0 }
    end
    
    def test_cs253find_all
        assert_equal [], CS253Array.new([]).cs253find_all { |i| i % 5 == 0 and i % 7 == 0 }
        assert_equal [3,6,9], CS253Array.new((1..10).to_a).cs253find_all { |i| i % 3 == 0}
        assert_equal [2],Triple.new(1,2,3).cs253find_all { |num|  num.even?  } 
    end

    def test_cs253find_index
        assert_equal 2, CS253Array.new((1..10).to_a).cs253find_index { |i| i % 3 == 0}
        assert_equal 2, CS253Array.new((1..10).to_a).cs253find_index(3)
        assert_equal 1, Triple.new(1,2,3).cs253find_index { |num|  num.even?  }
    end

    def test_cs253first
        assert_nil CS253Array.new([]).cs253first
        assert_equal [], CS253Array.new([]).cs253first(10)
        assert_equal ["foo", "bar"], CS253Array.new(%w[foo bar baz]).cs253first(2)
    end
    
    def test_cs253flat_map
        assert_equal [1, -1, 2, -2, 3, -3, 4, -4], CS253Array.new([1, 2, 3, 4]).cs253flat_map { |e| [e, -e] }
        assert_equal [1, 2, 100, 3, 4, 100], CS253Array.new([[1, 2], [3, 4]]).cs253flat_map { |e| e + [100] }
        assert_equal [1,100,2,100,3,100], Triple.new(1,2,3).cs253flat_map {|e| [e]+[100]}
    end
    
    def test_cs253grep
        assert_equal [38, 39, 40, 41, 42, 43, 44], CS253Array.new((1..100).to_a).cs253grep(38..44)
        assert_equal [39, 40, 41, 42, 43, 44, 45], CS253Array.new((1..100).to_a).cs253grep(38..44){|e|e+1} 
        assert_equal [2,3], Triple.new(1,2,3).cs253grep(2..3)
    end
    
    def test_cs253grep_v
        assert_equal [1, 6, 7, 8, 9, 10], CS253Array.new((1..10).to_a).cs253grep_v(2..5)
        assert_equal [2, 12, 14, 16, 18, 20], CS253Array.new((1..10).to_a).cs253grep_v(2..5) { |v| v * 2 }
        assert_equal [1], Triple.new(1,2,3).cs253grep_v(2..3)
    end

    def test_cs253group_by
        assert_equal Hash[0=>[3, 6], 1=>[1, 4], 2=>[2, 5]], CS253Array.new((1..6).to_a).cs253group_by { |i| i%3 }
        assert_equal Hash[0=>[3], 1=>[1], 2=>[2]], Triple.new(1,2,3).cs253group_by { |i| i%3 }
        assert_equal Hash[], CS253Array.new([]).cs253group_by { |i| i%2 }
    end

    def test_cs253include?
        assert_equal false, CS253Array.new([]).cs253include?(3)
        assert_equal true, CS253Array.new([1,2,3]).cs253include?(3)
        assert_equal true, Triple.new(1,2,3).cs253include?(3)
    end

    def test_cs253inject
        assert_equal 45, CS253Array.new((5..10).to_a).cs253inject(:+)
        assert_equal 45, CS253Array.new((5..10).to_a).cs253inject{ |sum, n| sum + n }
        assert_equal 151200, CS253Array.new((5..10).to_a).cs253inject(1, :*)       
        assert_equal 49, CS253Array.new((5..10).to_a).cs253inject(4){ |sum, n| sum + n }
    end

    def test_cs253map
        assert_equal [], CS253Array.new([]).cs253map{|i| i.length}
        assert_equal ["1","2","3"], CS253Array.new([1, 2, 3]).cs253map{|i| i.to_s}
        assert_equal [6,13,10], CS253Array.new(["string", "anotherString", "lastString"]).cs253collect{|i| i.length}
    end

    def test_cs253max
        assert_equal 4, CS253Array.new([1,2,4,3]).cs253max {|a,b| a<=>b}
        assert_equal [4,3], CS253Array.new([1,2,4,3]).cs253max(2) {|a,b| a<=>b}
        assert_equal ["albatross","horse"], Triple.new("albatross", "dog", "horse").cs253max(2) {|a, b| a.length<=>b.length}       
    end

    def test_cs253max_by
        assert_equal 4, CS253Array.new([1,2,4,3]).cs253max_by {|a| a}
        assert_equal [4,3], CS253Array.new([1,2,4,3]).cs253max_by(2) {|a| a}
        assert_equal ["albatross","horse"], Triple.new("albatross", "dog", "horse").cs253max_by(2) {|a| a.length}       
    end

    def test_cs253member?
        assert_equal false, CS253Array.new([]).cs253member?(3)
        assert_equal true, CS253Array.new([1,2,3]).cs253member?(3)
        assert_equal true, Triple.new(1,2,3).cs253member?(3)        
    end

    def test_cs253min
        assert_equal 1, CS253Array.new([1,2,4,3]).cs253min {|a,b| a<=>b}
        assert_equal [1,2], CS253Array.new([1,2,4,3]).cs253min(2) {|a,b| a<=>b}
        assert_equal ["dog","horse"], Triple.new("albatross", "dog", "horse").cs253min(2) {|a, b| a.length<=>b.length}       
    end

    def test_cs253min_by
        assert_equal 1, CS253Array.new([1,2,4,3]).cs253min_by {|a| a}
        assert_equal [1,2], CS253Array.new([1,2,4,3]).cs253min_by(2) {|a| a}
        assert_equal ["dog","horse"], Triple.new("albatross", "dog", "horse").cs253min_by(2) {|a| a.length}       
    end

    def test_cs253minmax
        a = CS253Array.new(%w(albatross dog horse))
        assert_equal ["albatross", "horse"], a.cs253minmax
        assert_equal ["dog", "albatross"], a.cs253minmax { |a, b| a.length <=> b.length }
        assert_equal [3,1], Triple.new(1,2,3).cs253minmax { |a, b| b <=> a }
    end

    def test_cs253minmax_by
        a = CS253Array.new(%w(albatross dog horse))
        assert_equal ["albatross", "dog"], Triple.new("albatross", "dog", "horse").cs253minmax_by { |a| -a.length}
        assert_equal ["dog", "albatross"], a.cs253minmax_by { |a| a.length}
        assert_equal [10,5], CS253Array.new((5..10).to_a).cs253minmax_by { |a| -a }
    end

    def test_cs253none?
        assert_equal false, CS253Array.new(%w{ant bear cat}).cs253none? { |word| word.length >= 4 }
        assert_equal true, CS253Array.new(%w{ant bear cat}).cs253none? { |word| word.length >= 5 }
        assert_equal false, Triple.new(1,2,3).cs253none? { |i| i >=3 }
    end

    def test_cs253one?
        assert_equal true, CS253Array.new(%w{ant bear cat}).cs253one? { |word| word.length >= 4 }
        assert_equal false, CS253Array.new(%w{ant bear cat}).cs253one? { |word| word.length >= 5 }
        assert_equal true, Triple.new(1,2,3).cs253one? { |i| i >=3 }
    end

    def test_cs253partition
        assert_equal [[2, 4, 6], [1, 3, 5]], CS253Array.new([1,2,3,4,5,6]).cs253partition { |v| v.even? }
        assert_equal [[2],[1,3]], Triple.new(1,2,3).cs253partition { |v| v.even? }
        assert_equal [[],[]], CS253Array.new([]).cs253partition { |v| v.even? }
    end

    def test_cs253reduce
        assert_equal 45, CS253Array.new((5..10).to_a).cs253reduce(:+)
        assert_equal 45, CS253Array.new((5..10).to_a).cs253reduce{ |sum, n| sum + n }
        assert_equal 151200, CS253Array.new((5..10).to_a).cs253reduce(1, :*)       
        assert_equal 49, CS253Array.new((5..10).to_a).cs253reduce(4){ |sum, n| sum + n }
    end

    def test_cs253reject
        assert_equal [99,100], CS253Array.new((1..100).to_a).cs253reject {|a| a < 99}
        assert_equal [1,2,4,5], CS253Array.new((1..5).to_a).cs253reject {|e|e%3==0} 
        assert_equal [2,3], Triple.new(1,2,3).cs253reject {|i| i == 1}

    end

    def test_cs253reverse_each
        res = []
        assert_equal (1..10).to_a, CS253Array.new((1..10).to_a).cs253reverse_each {|obj| res << obj}
        assert_equal [10,9,8,7,6,5,4,3,2,1], res
        res = []
        Triple.new("rhea", "kea", "flea").cs253reverse_each {|obj| res << obj}
        assert_equal ["flea", "kea", "rhea"], res
    end

    def test_cs253select
        assert_equal [], CS253Array.new([]).cs253select { |i| i % 5 == 0 and i % 7 == 0 }
        assert_equal [3,6,9], CS253Array.new((1..10).to_a).cs253select { |i| i % 3 == 0}
        assert_equal [2],Triple.new(1,2,3).cs253select { |num|  num.even?  } 
    end

    def test_cs253slice_after
        assert_equal [], CS253Array.new([]).cs253slice_after(1..3)
        assert_equal [[1],[2],[3,4]], CS253Array.new([1,2,3,4]).cs253slice_after {|obj| obj < 3}
        assert_equal [[1],[2,3]], Triple.new(1,2,3).cs253slice_after {|obj| obj < 2}
    end

    def test_cs253slice_before
        assert_equal [], CS253Array.new([]).cs253slice_before(1..3)
        assert_equal [[1],[2,3,4]], CS253Array.new([1,2,3,4]).cs253slice_before {|obj| obj < 3}
        assert_equal [[1,3],[2]], Triple.new(1,3,2).cs253slice_before {|obj| obj < 3}
    end

    def test_cs253slice_when
        assert_equal [["foo\n", "bar\n", "\n"], ["baz\n", "qux\n"]], CS253Array.new(["foo\n", "bar\n", "\n", "baz\n", "qux\n"]).cs253slice_when {|l1, l2| /\A\s*\z/ =~ l1 && /\S/ =~ l2}
        assert_equal [[7, 5, 9], [2, 0], [7, 9], [4, 2, 0]], CS253Array.new([7, 5, 9, 2, 0, 7, 9, 4, 2, 0]).cs253slice_when {|i, j| i.even? != j.even? }
        assert_equal [[1,3],[2]], Triple.new(1,3,2).cs253slice_when {|i, j| i > j}        
    end

    def test_cs253sort
        assert_equal [10, 9, 8, 7, 6, 5, 4, 3, 2, 1], CS253Array.new((1..10).to_a).cs253sort { |a, b| b <=> a }
        assert_equal ["flea", "kea", "rhea"], CS253Array.new(%w(rhea kea flea)).cs253sort { |a, b| a <=> b }        
        assert_equal [10, 9, 8, 7, 6, 5, 4, 3, 2, 1], CS253Array.new([4,7,9,10,8,5,3,6,1,2]).cs253sort { |a, b| b <=> a }
        assert_equal [3,2,1], Triple.new(1,2,3).cs253sort { |a, b| b <=> a }
    end

    def test_cs253sort_by
        assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], CS253Array.new((1..10).to_a).cs253sort_by { |a| a }
        assert_equal ["kea", "flea", "rheka"], CS253Array.new(%w(rheka kea flea)).cs253sort_by { |a| a.length }        
        assert_equal [10, 9, 8, 7, 6, 5, 4, 3, 2, 1], CS253Array.new([4,7,9,10,8,5,3,6,1,2]).cs253sort_by { |a| -a }
    end

    def test_cs253sum
        assert_equal 110, CS253Array.new((1..10).to_a).cs253sum {|v| v * 2 }
        assert_equal 111, CS253Array.new((1..10).to_a).cs253sum(1) {|v| v * 2 }
        assert_equal 55, CS253Array.new((1..10).to_a).cs253sum
    end

    def test_cs253take
        a = CS253Array.new([1, 2, 3, 4, 5, 0])
        assert_equal [1, 2, 3], a.cs253take(3)
        assert_equal [1, 2, 3, 4, 5, 0], a.cs253take(30)
        assert_equal [1, 2, 3], Triple.new(1,2,3).cs253take(3)
    end

    def test_cs253take_while
        a = CS253Array.new([1, 2, 3, 4, 5, 0])
        assert_equal [1, 2], a.cs253take_while { |i| i < 3 }
        assert_equal [], a.cs253take_while { |i| i < 0 }
        assert_equal [1], Triple.new(1,2,3).cs253take_while { |i| i < 2 }
    end

    def test_cs253to_a
        assert_equal [1, 2, 3], Triple.new(1,2,3).cs253to_a
        assert_equal [3, 2, 3], Triple.new(3,2,3).cs253to_a
        assert_equal ["kea", "flea", "rheka"], Triple.new("kea", "flea", "rheka").cs253to_a
    end

    def test_cs253to_h
        assert_equal Hash["hello" => 0, "world" => 1], CS253Array.new([['hello',0],['world',1]]).cs253to_h
        assert_equal Hash["hello" => 0, "world" => 1, "!" => 2], Triple.new(['hello',0],['world',1],["!",2]).cs253to_h
        assert_equal Hash[], CS253Array.new([]).cs253to_h
    end

    def test_cs253uniq
        assert_equal [1,2,3], Triple.new(1,2,3).cs253uniq
        assert_equal [1], Triple.new(1,2,3).cs253uniq {|e| true} 
        assert_equal [1], CS253Array.new([1,2,3]).cs253uniq {|e| e*0}
    end

    def test_cs253zip
        a = CS253Array.new([ 4, 5, 6 ])
        b = CS253Array.new([ 7, 8, 9 ])
        assert_equal [[4, 7], [5, 8], [6, 9]], a.cs253zip(b)
        assert_equal [[1, 4, 7], [2, 5, 8], [3, 6, 9]], CS253Array.new([1, 2, 3]).cs253zip(a, b)
        c = []
        a.cs253zip(b) { |x, y| c << x + y }
        assert_equal [11, 13, 15], c
    end

    def test_cs253length
        assert_equal 3, Triple.new(1,2,3).cs253length
        assert_equal 5, CS253Array.new([4,5,6,7,8]).cs253length
        assert_equal 0, CS253Array.new([]).cs253length
    end


end



