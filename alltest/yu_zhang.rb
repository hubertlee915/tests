#!/usr/bin/ruby
#
require 'minitest/autorun'
require_relative 'cs253Array.rb'
require_relative  'triple.rb'

class CS253EnumTests < Minitest::Test
    def test_collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253collect{|i| i*2},[2,4,6]
        assert_equal int_triple.cs253collect{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.cs253collect{|i| i.length}.to_a,[6,13,10]
    end
    # more tests!
    def test_all?
        x1 = CS253Array.new([1, 1, nil])
        x2 = CS253Array.new([1, 1, 1])
        x3 = CS253Array.new(['ant', 'bear', 'cat'])

        assert_equal x1.cs253all?{|i| i}, [1, 1, nil].all?{|i| i}
        assert_equal x2.cs253all?{|i| i}, [1, 1, 1].all?{|i| i}
        assert_equal x3.cs253all?{ |word| word.length >= 4 }, ['ant', 'bear', 'cat'].all?{ |word| word.length >= 4 }
    end

    def test_any?
        x1 = CS253Array.new([1, nil, nil])
        x2 = CS253Array.new([1, 1, 1])
        x3 = CS253Array.new(['ant','bear', 'cat'])

        assert_equal x1.cs253any?{|i| i}, [1, nil, nil].any?{|i| i}
        assert_equal x2.cs253any?{|i| i}, [1, 1, 1].any?{|i| i}
        assert_equal x3.cs253any?{ |word| word.length >= 4 }, ['ant', 'bear', 'cat'].any?{ |word| word.length >= 4 }
    end

    def test_chunk
        x1 = CS253Array.new([3, 1, 5, 6])
        assert_equal x1.cs253chunk {|n| n > 2}, [[true, [3]], [false, [1]], [true, [5, 6]]]
        assert_equal x1.cs253chunk {|n| n % 2 == 0}, [[false, [3, 1, 5]], [true, [6]]]
        assert_equal x1.cs253chunk {|n| n.even?}, [[false, [3, 1, 5]], [true, [6]]]
    end

    def test_chunk_while
        a = CS253Array.new([1,2,4])
        assert_equal a.cs253chunk_while{|i, j|j == i+1}, [1,2,4].chunk_while{|i, j|j==i+1}.to_a#[[1,2], [4]]
        assert_equal a.cs253chunk_while{|i, j|j > i}, [[1,2,4]]
        assert_equal a.cs253chunk_while{|i, j| i*j <6}, [[1, 2], [4]]
    end

    def test_collect_concat
        a = CS253Array.new([[1,[2]],[3,4]])
        b = CS253Array.new([[1,2],[3,4]])
        assert_equal a.cs253collect_concat{|i| i}, [[1,[2]],[3,4]].collect_concat{|i| i}
        assert_equal b.cs253collect_concat{|i| i}, [[1,2],[3,4]].collect_concat{|i| i}
        assert_equal b.cs253collect_concat{|i| i+[10]}, [[1,2],[3,4]].collect_concat{|i| i+[10]}
    end

    def test_count
        a = CS253Array.new([1, 2, 3, 4])
        assert_equal a.cs253count{|i| i}, [1, 2, 3, 4].count{|i| i}
        assert_equal a.cs253count{|i| i%2 == 0}, [1, 2, 3, 4].count{|i| i%2 == 0}
        assert_equal a.cs253count{|i| i == 2}, [1, 2, 3, 4].count{|i| i == 2}
    end

    def test_cycle
        a = ["a", "b", "c"]
        b = CS253Array.new(a)
        assert_nil b.cs253cycle(2){|i| i}
        assert_nil b.cs253cycle(100){|i| i}
        assert_nil b.cs253cycle(2){|i| i + "2"}
    end

    def test_detect
        a = CS253Array.new([1, 2, 3, 4])
        assert_equal a.cs253detect{|i| i % 2 == 0}, [1, 2, 3, 4].detect{|i| i % 2 == 0}
        assert_nil a.cs253detect{|i| i == 0}
        assert_equal a.cs253detect{|i| i == 2}, [1, 2, 3, 4].detect{|i| i == 2}
    end

    def test_drop
        a = CS253Array.new([1, 2, 3, 4, 5, 0])
        assert_equal a.cs253drop(1), [1, 2, 3, 4, 5, 0].drop(1)
        assert_equal a.cs253drop(0), [1, 2, 3, 4, 5, 0].drop(0)
        assert_equal a.cs253drop(10), [1, 2, 3, 4, 5, 0].drop(10)
    end

    def test_drop_while
        a = CS253Array.new([1, 2, 3, 4, 5, 0])
        assert_equal a.cs253drop_while{|x| x>3 }, [1, 2, 3, 4, 5, 0].drop_while {|x| x>3 }
        assert_equal a.cs253drop_while{|x| x<3 }, [1, 2, 3, 4, 5, 0].drop_while {|x| x<3 }
        assert_equal a.cs253drop_while{|x| x<6 }, [1, 2, 3, 4, 5, 0].drop_while {|x| x<6 }
    end

    def test_each_cons
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_nil a1.cs253each_cons(3){|x| x}
        assert_nil a1.cs253each_cons(10){|x| x}
        # assert_nil a1.each_cons(4){|x| x + 2}
    end

    def test_each_entry
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253each_entry{|e| e}, a.each_entry{|e| e}.to_a
        assert_equal a1.cs253each_entry{|e| e+2}, a.each_entry{|e| e+2}.to_a
        assert_equal a1.cs253each_entry{|e| e*2}, a.each_entry{|e| e*2}.to_a
    end

    def test_each_slice
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_nil a1.cs253each_slice(4){|e| e}
        assert_nil a1.cs253each_slice(10){|x| x}
        # assert_nil a1.cs253each_slice(10){|x| x+10}
    end

    def test_each_with_index
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.each_with_index{|x, idx| x}, a.each_with_index{|x, idx| x}.to_a
        assert_equal a1.each_with_index{|x, idx| x + 1}, a.each_with_index{|x, idx| x + 1}.to_a
        assert_equal a1.each_with_index{|x, idx| x + idx}, a.each_with_index{|x, idx| x + idx}.to_a
    end

    def test_each_with_object
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253each_with_object({:sum => 0}) {|i,hsh| hsh[:sum] += i}, a.each_with_object({:sum => 0}) {|i,hsh| hsh[:sum] += i}
        assert_equal a1.cs253each_with_object(0) {|i,sum| sum += i}, a.each_with_object(0) {|i,sum| sum += i}
        assert_equal a1.cs253each_with_object(10) {|i,sum| sum += i}, a.each_with_object(10) {|i,sum| sum += i}
    end

    def test_entries
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      s = CS253Array.new(["a", "b"])
      t = CS253Array.new([1, "b"])
      assert_equal a1.cs253entries, a.entries
      assert_equal s.cs253entries, ["a", "b"].entries
      assert_equal t.cs253entries, [1, "b"].entries
    end

    def test_find
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      assert_equal a1.cs253find{ |i| i % 5 == 0 }, a.find{ |i| i % 5 == 0 }
      assert_equal a1.cs253find{ |i| i % 10 == 0 }, a.find{ |i| i % 10 == 0 }
      assert_equal a1.cs253find(2){ |i| i % 5 == 0 }, a.find(2){ |i| i % 5 == 0 }
    end

      def test_find_all
          a =[1, 2, 3, 4, 5, 0]
          a1 = CS253Array.new(a)
          assert_equal a1.cs253find_all{ |i| i % 2 == 0 }, a.find_all{ |i| i % 2 == 0 }
          assert_equal a1.cs253find_all{ |i| i >1 }, a.find_all{ |i| i > 1 }
          assert_equal a1.cs253find_all{ |i| i % 10 == 0 }, a.find_all{ |i| i % 10 == 0 }
      end

  def test_find_index
    a =[1, 2, 3, 4, 5, 0]
    a1 = CS253Array.new(a)
    assert_equal a1.cs253find_index{ |i| i % 2 == 0 }, a.find_index{ |i| i % 2 == 0 }
    assert_nil a1.cs253find_index{ |i| i >10 }
    assert_equal a1.cs253find_index(2), a.find_index(2)
  end

  def test_first
      a =[]
      a1 = CS253Array.new(a)
      assert_equal a1.cs253first(2), a.first(2)
      assert_nil a1.cs253first, a.first
      s =[1, 2, 3, 4, 5, 0]
      s1 = CS253Array.new(s)

      assert_equal s1.cs253first(10), s.first(10)

  end

 def test_flap_map
     a = [[1, 2], [3, 4]]
     a1 = CS253Array.new(a)
     s = [["1","2"],["3","4"]]
     s1 = CS253Array.new(s)
     assert_equal a1.cs253flat_map{ |e| e }, a.flat_map{ |e| e}
     assert_equal a1.cs253flat_map{ |e| e +[10]}, a.flat_map{ |e| e + [10]}
     assert_equal s1.flat_map {|i| i[0] }, s.flat_map {|i| i[0] }
 end

 def test_grep
     a = [1,10,100,1000]
     a1 = CS253Array.new(a)
     assert_equal a1.cs253grep(1..100), a.grep((1..100))
     assert_equal a1.cs253grep(1..100){|x|x*2}, a.grep((1..100)){|x|x*2}
     assert_equal a1.cs253grep(102){|x|x*2}, a.grep(102){|x|x*2}
 end

    def test_grep_v
        a = [1,10,100,1000]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253grep_v(1..100), a.grep_v((1..100))
        assert_equal a1.cs253grep_v(1..100){|x|x*2}, a.grep_v((1..100)){|x|x*2}
        assert_equal a1.cs253grep_v(102){|x|x*2}, a.grep_v(102){|x|x*2}
    end

    def test_group_by
        a =[1, 2, 3, 4, 5, 0]
        a1= CS253Array.new(a)
        assert_equal a1.cs253group_by{ |i| i%3 }, a.group_by{ |i| i%3 }
        assert_equal a1.cs253group_by{ |i| i>3 }, a.group_by{ |i| i>3 }
        assert_equal a1.cs253group_by{ |i| i==1 }, a.group_by{ |i| i==1 }
    end

    def test_include?
        a = [ "a", "b", "c" ]
        a1 = CS253Array.new(a)

        assert_equal a1.cs253include?("a"), a.include?("a")
        assert_equal a1.cs253include?("d"), a.include?("d")
        assert_equal a1.cs253include?("b"), a.include?("b")
    end

    def test_inject
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253inject{|sum, n| sum + n }, a.inject{ |sum, n| sum + n }
        assert_equal a1.cs253inject(0){|sum, n| sum + n }, a.inject(0){ |sum, n| sum + n }
        assert_equal a1.cs253inject(3){|sum, n| sum - n }, a.inject(3){ |sum, n| sum - n }
    end

    def test_map
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253map{|x| x+2}, a.map{|x| x + 2}
        assert_equal a1.cs253map{|x| x-2}, a.map{|x| x - 2}
        assert_equal a1.cs253map{|x| x*2}, a.map{|x| x * 2}
    end

    def test_member?
        a = [ "a", "b", "c" ]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253member?("a"), a.member?("a")
        assert_equal a1.cs253member?("d"), a.member?("d")
        assert_equal a1.member?("b"), a.member?("b")
    end

    def test_max
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      s = ["string", "anotherString", "lastString"]
      s1 = CS253Array.new(s)
      assert_equal a1.cs253max(6), a.max(6)
      assert_equal a1.cs253max(5){|a, b| a <=> b}, a.max(5){|a, b| a <=> b}
      assert_equal s1.cs253max(5){|a, b| a.length <=> b.length}, s.max(5){|a, b| a.length <=> b.length}
    end

    def test_max_by
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      s = ["string", "anotherString", "lastString"]
      s1 = CS253Array.new(s)
      assert_equal a1.cs253max_by{|a| a}, a.max_by{|a| a}
      assert_equal a1.cs253max_by(5){|a| a}, a.max_by(5){|a| a}
      assert_equal s1.cs253max_by(5){|a| a.length }, s.max_by(5){|a| a.length}
    end

    def test_min
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      s = ["string", "anotherString", "lastString"]
      s1 = CS253Array.new(s)
      assert_equal a1.cs253min(6), a.min(6)
      assert_equal a1.cs253min(5){|a, b| a <=> b}, a.min(5){|a, b| a <=> b}
      assert_equal s1.cs253min(5){|a, b| a.length <=> b.length}, s.min(5){|a, b| a.length <=> b.length}
    end

    def test_min_by
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      s = ["string", "anotherString", "lastString"]
      s1 = CS253Array.new(s)
      assert_equal a1.cs253min_by{|a| a}, a.min_by{|a| a}
      assert_equal a1.cs253min_by(5){|a| a}, a.min_by(5){|a| a}
      assert_equal s1.cs253min_by(5){|a| a.length }, s.min_by(5){|a| a.length}
    end

    def test_minmax
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        s = ["string", "anotherString", "lastString"]
        s1 = CS253Array.new(s)

        assert_equal a1.cs253minmax{|a, b| a <=> b}, a.minmax{|a, b| a <=> b}
        assert_equal s1.cs253minmax{|a, b| a <=> b}, s.minmax{|a, b| a <=> b}
        assert_equal s1.cs253minmax{|a, b| a.length <=> b.length}, s.minmax{|a, b| a.length <=> b.length}
    end

    def test_minmax_by
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        s = ["string", "anotherString", "lastString"]
        s1 = CS253Array.new(s)

        assert_equal a1.cs253minmax_by{|a| a}, a.minmax_by{|a| a}
        assert_equal s1.cs253minmax_by{|a| a}, s.minmax_by{|a| a}
        assert_equal s1.cs253minmax_by{|a| a.length}, s.minmax_by{|a| a.length}
    end



    def test_none?
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)

        assert_equal a1.cs253none?{|x| x > 1}, a.none?{|x| x>1}
        assert_equal a1.cs253none?{|x| x > 10}, a.none?{|x| x>10}
        assert_equal a1.cs253none?{|x| x == 1}, a.none?{|x| x==1}
    end

    def test_one?
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)

        assert_equal a1.cs253one?{|x| x > 1}, a.one?{|x| x>1}
        assert_equal a1.cs253one?{|x| x > 10}, a.one?{|x| x>10}
        assert_equal a1.cs253one?{|x| x == 1}, a.one?{|x| x==1}
    end

    def test_partition
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      assert_equal a1.cs253partition{|x| x > 1}, a.partition{|x| x>1}
      assert_equal a1.cs253partition{|x| x > 10}, a.partition{|x| x>10}
      assert_equal a1.cs253partition{|x| x <5}, a.partition{|x| x<5}
    end

    def test_reduce
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253reduce{|sum, n| sum + n }, a.reduce{ |sum, n| sum + n }
        assert_equal a1.cs253reduce(0){|sum, n| sum + n }, a.reduce(0){ |sum, n| sum + n }
        assert_equal a1.cs253reduce(3){|sum, n| sum - n }, a.reduce(3){ |sum, n| sum - n }
    end

    def test_reject
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253reject{|x| x > 0}, a.reject{|x| x > 0}
        assert_equal a1.cs253reject{|x| x == 0}, a.reject{|x| x == 0}
        assert_equal a1.cs253reject{|x| x < 5}, a.reject{|x| x < 5}
    end

    def test_reverse_each
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      assert_equal a1.cs253reverse_each{|x| x*2},a.reverse_each {|x| x*2}
      assert_equal a1.cs253reverse_each{|x| x},a.reverse_each {|x| x}
      assert_equal a1.cs253reverse_each{|x| x>0},a.reverse_each {|x| x>0}
    end

    def test_select
        s1 = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        s2 = CS253Array.new(["string", "anotherString", "lastString"])
        assert_equal s1.cs253select{|e| e  == 1}, [1,2,3,4,5,6,7,8,9,10].select{|e| e  == 1}
        assert_equal s1.cs253select{|e| e % 2 == 0}, [1,2,3,4,5,6,7,8,9,10].select{|e| e % 2 == 0}
        assert_equal s2.cs253select{|e| e.length >7}, ["string", "anotherString", "lastString"].select{|e| e.length > 7}
    end

    def test_slice_after
      s1 = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
      s2 = CS253Array.new(["string", "anotherString", "lastString"])
      assert_equal s1.cs253slice_after{|e| e  == 1}, [1,2,3,4,5,6,7,8,9,10].slice_after{|e| e  == 1}.to_a
      assert_equal s1.cs253slice_after{|e| e  == 5}, [1,2,3,4,5,6,7,8,9,10].slice_after{|e| e  == 5}.to_a
      assert_equal s1.cs253slice_after{|e| e  == 9}, [1,2,3,4,5,6,7,8,9,10].slice_after{|e| e  == 9}.to_a
    end

    def test_slice_before
      s1 = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
      s2 = CS253Array.new(["string", "anotherString", "lastString"])
      assert_equal s1.cs253slice_before{|e| e  == 2}, [1,2,3,4,5,6,7,8,9,10].slice_before{|e| e  == 2}.to_a
      assert_equal s1.cs253slice_before{|e| e  == 5}, [1,2,3,4,5,6,7,8,9,10].slice_before{|e| e  == 5}.to_a
      assert_equal s1.cs253slice_before{|e| e  == 9}, [1,2,3,4,5,6,7,8,9,10].slice_before{|e| e  == 9}.to_a
    end

    def test_slice_when
      s = [1,2,3,4,5,6,7,8,9,10]
      s1 = CS253Array.new(s)
      assert_equal s1.cs253slice_when{|i, j| i+1 != j }, s.slice_when{|i, j| i+1 != j }.to_a
      assert_equal s1.cs253slice_when{|i, j| i+1 > j }, s.slice_when{|i, j| i+1 > j }.to_a
      assert_equal s1.cs253slice_when{|i, j| i+1 <j }, s.slice_when{|i, j| i+1 < j }.to_a
    end

    def test_take
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253take(0), a.take(0)
        assert_equal a1.cs253take(3), a.take(3)
        assert_equal a1.cs253take(10), a.take(10)
    end

    def test_take_while
        a =[1, 2, 3, 4, 5, 0]
        a1 = CS253Array.new(a)
        assert_equal a1.cs253take_while{|x| x > 0}, a.take_while{|x| x>0}
        assert_equal a1.cs253take_while{|x| x < 0}, a.take_while{|x| x < 0}
        assert_equal a1.cs253take_while{|x| x > 3}, a.take_while{|x| x > 3}
    end

    def test_sort
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      s = ["string", "anotherString", "lastString"]
      s1 = CS253Array.new(s)
      assert_equal a1.cs253sort{ |a, b| b <=> a }, a.sort{ |a, b| b <=> a }
      assert_equal s1.cs253sort{ |a, b| b <=> a }, s.sort{ |a, b| b <=> a }
      assert_equal s1.cs253sort{ |a, b| b.length <=> a.length }, s.sort{ |a, b| b.length <=> a.length }
    end

    def test_sort_by
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      s = ["string", "anotherString", "lastString"]
      s1 = CS253Array.new(s)
      assert_equal a1.cs253sort_by{ |a| a}, a.sort_by{ |a| a}
      assert_equal s1.cs253sort_by{ |a| a}, s.sort_by{ |a| a}
      assert_equal s1.cs253sort_by{ |a| a.length}, s.sort_by{ |a| a.length}
    end

    def test_sum
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      assert_equal a1.cs253sum(0), a.sum(0)
      assert_equal a1.cs253sum(0){|x|x}, a.sum(0){|x|x}
      assert_equal a1.cs253sum(0){|x|x*2}, a.sum(0){|x|x*2}

    end

    def test_to_a
      a =[1, 2, 3, 4, 5, 0]
      a1 = CS253Array.new(a)
      assert_equal a1.cs253to_a, a.to_a
      assert_equal a1.cs253to_a, a.to_a
      assert_equal a1.cs253to_a, a.to_a
    end

    def test_to_h
      a = [1, 2, 3]
      a1 = CS253Array.new(a)
      s = ["string", "anotherString", "lastString"]
      s1 = CS253Array.new(s)
      x = [[1], [2], 3]
      x1 = CS253Array.new(x)

      assert_equal a1.cs253to_h, {0=>1, 1=>2, 2=>3}
      assert_equal s1.cs253to_h, {0=>"string", 1=>"anotherString", 2=>"lastString"}
      assert_equal x1.cs253to_h, {0=>[1], 1=>[2], 2=>3}
    end

    def test_uniq
      a = [1, 2, 3]
      a1 = CS253Array.new(a)
      s = [ "a", "a", "b", "b", "c" ]
      s1 = CS253Array.new(s)
      assert_equal a1.cs253uniq{|x|x}, a.uniq{|x|x}
      assert_equal s1.cs253uniq{|x|x}, s.uniq{|x|x}
      assert_equal s1.cs253uniq{|x|x.length}, s.uniq{|x|x.length}
    end

    def test_zip
      a = [ 4, 5, 6 ]
      b = [ 7, 8, 9 ]
      a1 = CS253Array.new(a)
      b1 = CS253Array.new(b)
      c = [2, 5]
      c1 = CS253Array.new(c)
      d = []
      d1 = CS253Array.new(d)
      e=[1]
      e1= CS253Array.new(e)
      assert_equal c1.cs253zip(a1, b1), c.zip(a,b)
      assert_equal d1.cs253zip(a1, b1), d.zip(a,b)
      assert_equal e1.cs253zip(a1, b1), e.zip(a,b)

    end

    def test_length
        s = ["string", "anotherString", "lastString"]
        s1 = CS253Array.new(s)
        a = [[1], 2, 3]
        a1 = CS253Array.new(a)
        b = [1, 2, 3]
        b1 = CS253Array.new(b)
        assert_equal s1.cs253length, s.length
        assert_equal a1.cs253length, a.length
        assert_equal b1.cs253length, b.length
    end
  

end



