require './minitest/autorun.rb'
require './cs253Array.rb'
require './triple.rb'

class CS253EnumTests < Minitest::Test

def test_all
    int_triple = CS253Array.new([1, 2, 3])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    str_pair = CS253Array.new(["string", nil])
    
    assert_equal int_triple.cs253all?() { |i| i > 4 }, false
    # undefined length for nil
    assert_equal str_triple.cs253all? { |i| i.length >= 6 }, true
    assert_equal str_pair.cs253all? { |i| i.length >= 6 }, false
  end
  
  def test_any
    int_triple = CS253Array.new([1, 2, 3])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    str_pair = CS253Array.new(["string", nil])
    
    assert_equal int_triple.cs253any? { |i| i > 2 }, true
    assert_equal str_triple.cs253any? { |i| i.length > 13 }, false
    assert_equal str_pair.cs253any?, true
  end
  
  def test_collect
    int_triple = CS253Array.new([1, 2, 3])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    str_pair = CS253Array.new(["string", nil])
        
    assert_equal int_triple.cs253collect { |i| i * 2 }, [2, 4, 6]
    assert_equal str_triple.cs253collect { |i| i.length }, [6, 13, 10]
    assert_equal str_triple.cs253collect { |i| i + "a" }, 
      ["stringa", "anotherStringa", "lastStringa"]
  end
  
  def test_count
    int_triple = CS253Array.new([1, 2, 3])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    a = CS253Array.new(["string", nil])
    
    assert_equal int_triple.cs253count { |i| i%2 == 0 }, 1
    assert_equal str_triple.cs253count { |i| i.length > 6 }, 2
    assert_equal a.cs253count(nil), 1
  end
  
  def test_detect
    int_triple = CS253Array.new([1, 2, 3])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_nil int_triple.cs253detect { |i| i%4 == 0 }
    assert_equal str_triple.cs253detect { |i| i.length > 6 }, "anotherString"
    assert_equal str_triple.cs253detect { |i| i == "string" }, "string"
  end
  
  def test_drop
    int_triple = CS253Array.new([1, 2, 3])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253drop(1), [2, 3]
    assert_equal int_triple.cs253drop(0), [1, 2, 3]
    assert_equal str_triple.cs253drop(2), ["lastString"]
  end
  
  def test_each_entry
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    a = []
    int_triple.cs253each_entry { |i| i < 3 && a << i }
    assert_equal a, [1, 2, 0]
    a = []
    int_triple.cs253each_entry { |i| i%2 == 0 && a << i }
    assert_equal a, [2, 4, 0]
    a = []
    str_triple.cs253each_entry { |i| i.length > 7 && a << i }
    assert_equal a, ["anotherString", "lastString"]
  end
  
  def test_drop_while
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253drop_while { |i| i < 3 }, [3, 4, 5, 0]
    assert_equal str_triple.cs253drop_while { |i| i.length < 7 }, 
      ["anotherString", "lastString"]
    assert_equal int_triple.cs253drop_while { |e| }, [1, 2, 3, 4, 5, 0]
  end
  
  def test_each_cons
    int_triple = CS253Array.new([1, 2, 3, 4])
    
    ary = []
    int_triple.cs253each_cons(3) { |i| ary << i }
    assert_equal ary, [[1, 2, 3],[2, 3, 4]]
    
    ary = []
    int_triple.cs253each_cons(0) { |i| ary << i }
    assert_equal ary, [[], [], [], []]
    
    #ary = []
    #int_triple.cs253each_cons(-1) { |i| ary << i }
    #assert_equal ary, []
  end
  
  def test_each_slice
    int_triple = CS253Array.new([1, 2, 3, 4])
    empty = CS253Array.new([])
    
    answer = []
    assert_nil empty.each_slice(10) {|e| answer << e}
    
    ary = []
    int_triple.cs253each_slice(2) { |i| ary << i  }
    assert_equal ary, [[1, 2],[3, 4]]
    
    ary = []
    int_triple.cs253each_slice(0) { |i| ary << i  }
    assert_equal ary, [[1, 2, 3, 4]]
      
    ary = []
    int_triple.cs253each_slice(-1) { |i| ary << i  }
    assert_equal ary, [[1, 2, 3, 4]]
  end
  
  def test_each_with_index
    int_triple = CS253Array.new([1, 2, 3])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    ary = []
    int_triple.cs253each_with_index { |i, indx| ary << i + indx }
    assert_equal ary, [1, 3, 5]
    
    ary = []
    int_string.cs253each_with_index { |i, indx| ary << i.concat(indx.to_s) }
    assert_equal ary, ["string0", "anotherString1", "lastString2"]
  end
  
  def test_each_with_object
    int_triple = CS253Array.new([1, 2, 3])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    a = int_triple.cs253each_with_object([]) { |i, a| a << i * 2 }
    assert_equal a, [2, 4, 6]
    
    a = int_string.cs253each_with_object([]) { |i, a| a << i.concat("\n") }
    assert_equal a, ["string\n", "anotherString\n", "lastString\n"]
  end
  
  def test_find
    int_triple = CS253Array.new([1, 2, 3])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253find{ |i| i == 3 }, 3
    assert_nil int_triple.cs253find{ |i| i == 4 }
    assert_equal int_string.cs253find{ |i| i == "string" }, "string"
  end
  
  def test_find_all
    int_triple = CS253Array.new([1, 2, 3])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253find_all{ |i| i%2 == 0 }, [2]
    assert_equal int_triple.cs253find_all{ |i| i%2 != 0 }, [1, 3]
    assert_equal int_string.cs253find_all{ |i| i.include?("string") }, 
      ["string"]
  end
  
  def test_first
    int_triple = CS253Array.new([1, 2, 3])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253first(3), [1, 2, 3]
    assert_equal int_triple.cs253first(0), []
    assert_equal int_string.cs253first, "string"
  end
  
  def test_find_index
    int_triple = CS253Array.new([1, 2, 3])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253find_index(3), 2
    assert_equal int_triple.cs253find_index{|i| i%2 == 0}, 1
    assert_equal int_string.cs253find_index{|i| i.include?("string")}, 0
  end
  
  def test_flat_map
    a = CS253Array.new([1, 2, 3, 4])
    b = CS253Array.new([[1, 2], [3, 4]])
    
    assert_equal a.cs253flat_map { |e| [e, -e] }, [1, -1, 2, -2, 3, -3, 4, -4]
    assert_equal b.cs253flat_map { |e| e + [100] }, [1, 2, 100, 3, 4, 100]
    assert_equal b.cs253flat_map { |e| [e] + [100] }, [[1, 2], 100, [3, 4], 100]
  end
  
  def test_grep
    c = CS253Array.new(IO.constants)
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
	# this turned out to be machine independent
    #assert_equal c.cs253grep(/SEEK/), [:SEEK_CUR, :SEEK_SET, :SEEK_END]
    assert_equal int_string.cs253grep(/string/), ["string"]
    assert_equal int_string.cs253grep(/\S+String\b/), 
      ["anotherString", "lastString"]
  end
  
  def test_grep_v
    c = CS253Array.new([1, 2, 3, 4, 5, 6])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal c.cs253grep_v(2..4), [1, 5, 6]
    assert_equal int_string.cs253grep(/\S+String\b/), 
      ["anotherString", "lastString"]
    assert_equal int_string.cs253grep(/string\b/), 
      ["string"]
  end
  
  def test_group_by
    c = CS253Array.new([1, 2, 3, 4, 5, 6])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    h = c.cs253group_by{ |i| i%3  }
    assert_equal h, {0=>[3, 6], 1=>[1, 4], 2=>[2, 5]}
    assert_equal c.cs253group_by{ |i| i%2  }, {1=>[1, 3, 5], 0=>[2, 4, 6]}
    assert_equal int_string.cs253group_by() { |s| /\S+String\b/ }, 
      {/\S+String\b/=>["string", "anotherString", "lastString"]}
  end
  
  def test_include
    c = CS253Array.new(IO.constants)
    a = CS253Array.new([1, 2, 3, 4, 5, 6])
    int_string = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal a.cs253include?(2), true
    assert_equal c.cs253include?(:SEEK_SET), true
    assert_equal int_string.cs253include?(/\S+String\b/), false
  end
  
  def test_map
    c = CS253Array.new([1, 2, 3, 4])
    
    assert_equal c.cs253map() { |i| i*i }, [1, 4, 9, 16]
    assert_equal c.cs253map() { |i| i + 1 }, [2, 3, 4, 5]
    assert_equal c.cs253map() { |i| -i }, [-1, -2, -3, -4]
  end
  
  def test_max
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253max, 5 
    assert_equal int_triple.cs253max(2), [5, 4]
    assert_equal str_triple.cs253max() {|a, b| a.length <=> b.length}, 
      'anotherString'
  end
  
  def test_max_by
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253max_by{|i| i}, 5 
    assert_equal int_triple.cs253max_by(2){|i| i}, [5, 4]
    assert_equal str_triple.cs253max_by() {|i| i.length}, 
      'anotherString'
  end
  
  def test_member
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal str_triple.cs253member?("string"), true
    assert_equal int_triple.cs253member?(1), true
    assert_equal int_triple.cs253member?(10), false
  end
  
  def test_min
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253min, 0 
    assert_equal int_triple.cs253min(2), [0, 1]
    assert_equal str_triple.cs253min() {|a, b| a.length <=> b.length}, 
      'string'
  end
  
  def test_min_by
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["string", "anotherString", "lastString"])
    
    assert_equal int_triple.cs253min_by{|i| i}, 0 
    assert_equal int_triple.cs253min_by(2){|i| i}, [0, 1]
    assert_equal str_triple.cs253min_by() {|i| i.length}, 
      'string'
  end
  
  def test_minmax
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal int_triple.cs253minmax, [0, 5]
    assert_equal str_triple.cs253minmax {|a, b| a.length <=> b.length}, 
      ["string", "anotherString"]
     assert_equal str_triple.cs253minmax, ["anotherString", "string"]
  end
  
  def test_minmax_by
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal int_triple.cs253minmax_by{|i| i}, [0, 5]
    assert_equal int_triple.cs253minmax_by{|i| i%2}, [2, 1]
    assert_equal str_triple.cs253minmax_by {|a| a.length}, 
      ["string", "anotherString"]
  end
  
  def test_none
    empty = CS253Array.new([])
    ary1 = CS253Array.new([nil, false])
    ary2 = CS253Array.new([nil, false, true])
    int_triple = CS253Array.new([1, 2, 3, 4, 5, 0])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal str_triple.cs253none? {|i| i.length == 2}, true
    assert_equal str_triple.cs253none? {|i| i.length == 6}, false
    assert_equal int_triple.cs253none? {|i| i >= 4}, false
    assert_equal empty.cs253none?, true
    assert_equal ary1.cs253none?, true
    assert_equal ary2.cs253none?, false
  end
  
  def test_one
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    ary1 = CS253Array.new([nil, true, false])
    
    assert_equal str_triple.cs253one?() { |i| i.length == 6 }, true
    assert_equal str_triple.cs253one?() { |i| i.length > 6 }, false
    assert_equal ary1.cs253one?(), true
  end
  
  def test_partition
    ary = CS253Array.new([1, 2, 3, 4, 5, 6, 7, 8])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal ary.cs253partition{|i| i%2 == 0}, [[2, 4, 6, 8],[1, 3, 5, 7]]
    assert_equal str_triple.cs253partition{|i| i.length > 6}, 
      [["lastString", "anotherString"],["string"]]
    assert_equal str_triple.cs253partition{|i| i === /\S+String\b/}, 
      [[], ["lastString", "anotherString", "string"]]
  end
  
  def test_reject
    ary = CS253Array.new([1, 2, 3, 4, 5, 6, 7, 8])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal ary.cs253reject{|i| i%2 == 0}, [1, 3, 5, 7]
    assert_equal str_triple.cs253reject{|i| i.length > 6}, ["string"]
    assert_equal str_triple.cs253reject{|i| i === /\S+String\b/}, 
      ["lastString", "anotherString", "string"]
  end
  
  def test_reverse_each
    ary = CS253Array.new([1, 2, 3, 4, 5, 6, 7, 8])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    newAry = []
    ary.cs253reverse_each() { |i| newAry << i }
    assert_equal newAry, [8, 7, 6, 5, 4, 3, 2, 1]
    
    newAry = []
    str_triple.cs253reverse_each() { |i| newAry << i }
    assert_equal newAry, ["string", "anotherString", "lastString"]
    
    newAry = []
    str_triple.cs253reverse_each() { |i| newAry << i.length }
    assert_equal newAry, [6, 13, 10]
  end
  
  def test_select
    ary = CS253Array.new([1, 2, 3, 4, 5, 6, 7, 8])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal ary.cs253select{|i| i%2 == 0}, [2, 4, 6, 8]
    assert_equal str_triple.cs253select{|i| i.length > 6}, 
      ["lastString", "anotherString"]
    assert_equal str_triple.cs253select{|i| i.include?("string")}, ["string"]
  end
  
  def test_sum
    ary = CS253Array.new([1, 2, 3, 4])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal ary.cs253sum(1) { |i| i*2 }, 21
    assert_equal ary.cs253sum(0) { |i| i }, 10
    assert_equal str_triple.cs253sum(0) { |i| i.length }, 29
  end
  
  def test_take
    ary = CS253Array.new([1, 2, 3, 4])
    
    assert_equal ary.cs253take(2), [1, 2]
    assert_equal ary.cs253take(5), [1, 2, 3, 4]
    assert_equal ary.cs253take(-1), []
  end
  
  def test_take_while
    ary = CS253Array.new([1, 2, 3, 4])
    
    assert_equal ary.cs253take_while {|i| i < 3}, [1, 2]
    assert_equal ary.cs253take_while {|i| i >= 3}, []
    assert_equal ary.cs253take_while {|i| i % 2 == 0}, []
  end
 
  def test_to_h
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    a = CS253Array.new([1, 2, 3, 4])
    
    ary = []
    str_triple.cs253each_with_index{|i, indx| ary[indx] = [i, indx]}
    assert_equal CS253Array.new(ary).cs253to_h, 
      {"lastString"=>0, "anotherString"=>1, "string"=>2}
    
    ary = []
    a.cs253each_with_index{|i, indx| ary[indx] = [i, i%2]}
    assert_equal CS253Array.new(ary).cs253to_h, {1=>1, 2=>0, 3=>1, 4=>0}
    
    ary = []
    a.cs253each_with_index{|i, indx| ary[indx] = [i, indx]}
    assert_equal CS253Array.new(ary).cs253to_h, {1=>0, 2=>1, 3=>2, 4=>3}
  end
  
  def test_cs253uniq
    ary = CS253Array.new([1, 2, 3, 4, 3, 3, 2, 1, 0])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal ary.cs253uniq, [1, 2, 3, 4, 0]
    assert_equal str_triple.cs253uniq, ["lastString", "anotherString", "string"]
    
    str_triple = CS253Array.new(["String", "anotherString", "string"])
    assert_equal str_triple.cs253uniq, ["String", "anotherString", "string"]
    
  end
  
  def test_zip
    a = CS253Array.new([4, 5, 6])
    b = CS253Array.new([7, 8, 9])
    c = []
    a.cs253zip(b) { |x, y| c << x + y }
    
    assert_equal a.cs253zip(b), [[4, 7], [5, 8], [6, 9]]
    assert_equal a.cs253zip([1, 2], [8]), [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
    assert_equal c, [11, 13, 15]
    
  end
  
  def test_length
    a = CS253Array.new([4, 5, 6])
    b = CS253Array.new([[4, 5, 6], [7, 8, 9]])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal a.cs253length, 3
    assert_equal b.cs253length, 2
    assert_equal str_triple.cs253length, 3
  end
  
  def test_sort
    a = CS253Array.new([5, 2, 1, 0, 4, 3])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal a.cs253sort, [0, 1, 2, 3, 4, 5]
    assert_equal str_triple.cs253sort { |a, b| b <=> a }, 
      ["string", "lastString", "anotherString"]
    assert_equal str_triple.cs253sort, 
      ["anotherString", "lastString", "string"]
  end
  
  def test_sort_by
    a = CS253Array.new([5, 2, 1, 0, 4, 3])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal a.cs253sort_by { |i| i * 2 }, [0, 1, 2, 3, 4, 5]
    assert_equal a.cs253sort_by { |i| i%2 }, [2, 0, 4, 5, 1, 3]
    assert_equal str_triple.cs253sort_by { |a| a.length }, 
      ["string", "lastString", "anotherString"]
  end
  
  
  def test_inject
    a = CS253Array.new([5, 6, 7, 8, 9, 10])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal a.cs253inject { |sum, n| sum + n }, 45
    assert_equal a.cs253inject(5) { |sum, n| sum + n }, 50
    assert_equal str_triple.cs253inject{|memo, word| 
      memo.length > word.length ? memo : word}, "anotherString"
  end
  
  def test_reduce
    a = CS253Array.new([5, 6, 7, 8, 9, 10])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal a.cs253reduce { |sum, n| sum + n }, 45
    assert_equal a.cs253reduce(5) { |sum, n| sum + n }, 50
    assert_equal str_triple.cs253reduce{|memo, word| 
      memo.length > word.length ? memo : word}, "anotherString"
  end
  
  def test_cycle
    a = CS253Array.new([1, 2, 3, 4])
    x = []
    
    a.cs253cycle(2) { |i| x << i }
    assert_equal x, [1, 2, 3, 4, 1, 2, 3, 4]
    assert_nil a.cs253cycle(2) {|i| i = i * 2}
    
    # infinite cycle case: disabled to not hold the execution
    # a.cs253cycle { |i| p i }
    # assert_equal x, [1, 2, 3, 4, 1, 2, 3, 4]
  end
  
  def test_chunk
    a = CS253Array.new([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    empty = CS253Array.new([])
        
    assert_equal empty.cs253chunk {|e| e.size}, []
    
    assert_equal a.cs253chunk() { |i| i % 2 == 0 }, 
      [[false, [3, 1]], [true, [4]], [false, [1, 5, 9]], [true, [2, 6]], [false, [5, 3, 5]]]
    assert_equal str_triple.cs253chunk() { |i| i.length }, 
      [[10, ["lastString"]], [13, ["anotherString"]], [6, ["string"]]]
    assert_equal str_triple.cs253chunk() { |i| i.length > 6 }, 
      [[true, ["lastString", "anotherString"]], [false, ["string"]]]
  end
  
  def test_slice_when
    a = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21])
    b = CS253Array.new([4,2,4,4,11,11,12,15,16,19,20,21])
    
    assert_equal a.cs253slice_when {|i, j| i+1 != j }, 
      [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]]
    assert_equal b.cs253slice_when {|i, j| j%i != 0 && i%j != 0}, 
      [[4, 2, 4, 4], [11, 11], [12], [15], [16], [19], [20], [21]]
    assert_equal b.cs253slice_when {|i, j| i > j }, 
      [[4], [2, 4, 4, 11, 11, 12, 15, 16, 19, 20, 21]]
  end
  
  def test_chunk_while
    a = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21])
    b = CS253Array.new([0, 9, 2, 2, 3, 2, 7, 5, 9, 5])
    c = CS253Array.new([9, 2, 2, 3, 2, 7, 5, 9, 5])
    
    assert_equal a.cs253chunk_while {|i, j| i+1 == j }, 
      [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]]
    assert_equal b.cs253chunk_while {|i, j| i <= j},
      [[0, 9], [2, 2, 3], [2, 7], [5, 9], [5]]
    assert_equal c.cs253chunk_while {|i, j| i%j == 0 && j%i == 0}, 
      [[9], [2, 2], [3], [2], [7], [5], [9], [5]]
  end
  
  def test_collect_concat
    a = CS253Array.new([1, 2, 3, 4])
    b = CS253Array.new([[1, 2], [3, 4]])
    str_triple = CS253Array.new(["lastString", "anotherString", "string"])
    
    assert_equal a.cs253collect_concat { |e| [e, -e] }, 
      [1, -1, 2, -2, 3, -3, 4, -4]
    assert_equal b.cs253collect_concat { |e| e + [100] }, 
      [1, 2, 100, 3, 4, 100]
    assert_equal str_triple.cs253collect_concat { |e| [e, e.upcase] }, 
      ["lastString", "LASTSTRING", "anotherString", "ANOTHERSTRING", "string", "STRING"]
  end
  
  def test_cs253slice_after
    a = CS253Array.new(["foo\n", "bar\\\n", "baz\n", "\n", "qux\n"])
    b = CS253Array.new(["a", "b", "c", "d", "a", "g"])
    
    assert_equal a.cs253slice_after(/(?<!\\)\n\z/), 
      [["foo\n"], ["bar\\\n", "baz\n"], ["\n"], ["qux\n"]]
    assert_equal a.cs253slice_after {|i| /(?<!\\)\n\z/ === i}, 
      [["foo\n"], ["bar\\\n", "baz\n"], ["\n"], ["qux\n"]]
    # [["a"], ["b", "c", "d", "a"], [g]]
    # this had an error which doesn't insert the last element if the
    #  n - 1 element is a slice point
    assert_equal b.cs253slice_after("a"), [["a"], ["b", "c", "d", "a"], ["g"]]
  end
  
  def test_cs253slice_before
    a = CS253Array.new(["a", "b", "c", "a", "b"])
    
    assert_equal a.cs253slice_before("a"), [["a", "b", "c"], ["a", "b"]]
    assert_equal a.cs253slice_before("b"), [["a"], ["b", "c", "a"], ["b"]]
    assert_equal a.cs253slice_before {|i| "c" === i},
      [["a", "b"], ["c", "a", "b"]]
  end

  
end


