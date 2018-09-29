require 'minitest/autorun'
require_relative './cs253Array.rb'
require_relative 'triple'

class CS253EnumTests < Minitest::Test
  def test_all?
    int_triple = Triple.new(2 ,4 ,6)
    str_triple = Triple.new("aa", "a", "aaaaaa")
    nil_triple = Triple.new(nil, nil, 1 )

    assert_equal true, int_triple.cs253all? {|x| x.even?}
    assert_equal false, int_triple.cs253all? {|x| x == 2}
    # assert_equal true, str_triple.cs253all?(/a*/)
    assert_equal false , nil_triple.cs253all? {|x| x.nil?}
  end

  def test_chunk
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("aaa", "bbb", "c")
    nil_triple = Triple.new(nil, nil, 1)


    assert_equal [[false, [1]], [true, [2]], [false, [3]]], int_triple.cs253chunk { |x| x.even? }
    assert_equal [[true, ["aaa", "bbb"]], [false, ["c"]]], str_triple.cs253chunk { |x| x.length == 3 }
    assert_equal [[true, [nil, nil]], [false, [1]]], nil_triple.cs253chunk { |x| x.nil? }
  end

  def test_chunk_while
    int_triple = Triple.new(1, 2, 4)
    str_triple = Triple.new("aaa", "bbb", "c")
    pos_neg_triple = Triple.new(2, -2, 2)

    assert_equal [[1, 2], [4]], int_triple.cs253chunk_while { |before, after| after == before + 1 }
    assert_equal [["aaa", "bbb"], ["c"]], str_triple.cs253chunk_while { |before, after| before.length == after.length}
    assert_equal [[2, -2, 2]], pos_neg_triple.cs253chunk_while { |before, after| before + after == 0}
  end

  def test_collect
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("string", "anotherString", "lastString")
    zero_triple = Triple.new(0, 0, 0 )

    assert_equal [6,13,10], str_triple.cs253collect{|i| i.length}
    assert_equal ["1", "2", "3"], int_triple.cs253collect{|i| i.to_s}
    assert_equal [1, 1, 1], zero_triple.cs253collect {|x| x + 1}
  end

  def test_collect_concat
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("abc", "def", "ghi")
    another_int_triple = Triple.new(0, 1, 2 )

    assert_equal [1, -1, 2, -2, 3, -3], int_triple.cs253collect_concat { |e| [e, -e] }
    assert_equal ["abc", "cba", "def", "fed", "ghi", "ihg"], str_triple.cs253collect_concat { |e| [e, e.reverse] }
    assert_equal [0, 1, 1, 2, 2, 3], another_int_triple.cs253collect_concat {|e| [e, e+1]}
  end

  def test_count
    int_triple = Triple.new(2,4, 5)

    assert_equal 2, int_triple.cs253count { |element| element.even? }
    assert_equal 1, int_triple.cs253count(2)
    assert_equal 3, int_triple.cs253count
  end

  def test_cycle
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "b", "c")
    float_triple = Triple.new(0.1, 0.2, 0.3)

    assert_nil int_triple.cs253cycle(2) { |e| p e}
    assert_nil str_triple.cs253cycle(2) { |e| p e}
    assert_nil float_triple.cs253cycle(3) { |e| p e}
  end

  def test_detect
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "bb", "cc")

    assert_equal 2, int_triple.cs253detect { |e| e.even? }
    # BAD_TEST:
    # assert_equal 10, int_triple.cs253detect(10) { |e| e == 4 }
    # Should be:
    assert_equal 10, int_triple.cs253detect(lambda {10}) { |e| e == 4 }
    assert_equal "bb", str_triple.cs253detect { |e| e.length == 2 }
  end

  def test_drop
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "b", "c")

    assert_equal [3], int_triple.cs253drop(2)
    assert_equal [2, 3], int_triple.cs253drop(1)
    assert_equal [], str_triple.cs253drop(3)
  end

  def test_drop_while
    int_triple = Triple.new(1, 2, 3)

    assert_equal [2, 3], int_triple.cs253drop_while { |x| x < 2 }
    assert_equal [1, 2, 3], int_triple.cs253drop_while { |x| x < 0}
    assert_equal [], int_triple.cs253drop_while { |x| x < 4}
  end

  def test_each_cons
    int_triple = Triple.new(1, 2, 3)

    assert_nil int_triple.cs253each_cons(2) {|e| p e}
    assert_nil int_triple.cs253each_cons(3) {|e| p e}
    assert_nil int_triple.cs253each_cons(4) {|e| p e}
  end

  def test_each_entry
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "b", "c")
    float_triple = Triple.new(0.1, 0.2, 0.3)

    assert_equal int_triple, int_triple.cs253each_entry {|e| p e}
    assert_equal str_triple, str_triple.cs253each_entry {|e| p e + e}
    assert_equal float_triple, float_triple.cs253each_entry {|e| p 2 * e}
  end

  def test_each_slice
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "c", "b")

    assert_nil int_triple.cs253each_slice(2) {|e| p e}
    assert_nil str_triple.cs253each_slice(3) {|e| p e}
    assert_nil str_triple.cs253each_slice(2) {|e| p e}
  end

  def test_each_with_index
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "c", "b")

    assert_equal int_triple, int_triple.cs253each_with_index {|e, idx| p e, idx}
    assert_equal str_triple, str_triple.cs253each_with_index {|e, idx| p e, idx}
    # assert_equal [[1, 0], [2, 1], [3, 2]], int_triple.cs253each_with_index
  end

  def test_each_with_object
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "c", "b")

    assert_equal [1, 2, 3], int_triple.cs253each_with_object([]) { |element, memo| memo << element}
    # BAD_TEST: should expect 0
    assert_equal 0, int_triple.cs253each_with_object(0) { |element, memo| memo += element }
    assert_equal "", str_triple.cs253each_with_object("") { |element, memo| memo += element}
  end

  def test_entries
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "c", "b")
    nil_triple = Triple.new(nil, nil, nil)

    assert_equal [1, 2, 3], int_triple.cs253entries
    assert_equal ["a", "c", "b"], str_triple.cs253entries
    assert_equal [nil, nil, nil], nil_triple.cs253entries
  end

  def test_find
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("a", "bb", "cc")

    assert_equal 2, int_triple.cs253find { |e| e.even? }
    # BAD_TEST
    # assert_equal 10, int_triple.cs253find(10) { |e| e == 4 }
    # Should be:
    assert_equal 10, int_triple.cs253find(lambda {10}) { |e| e == 4 }
    assert_equal "bb", str_triple.cs253find { |e| e.length == 2 }
    assert_nil str_triple.cs253find {|e| e == "al;sdkfjaodfj"}
  end

  def test_find_all
    int_triple = Triple.new(1, 2, 4)
    str_triple = Triple.new("a", "bb", "cc")

    assert_equal [2, 4], int_triple.cs253find_all {|e| e.even?}
    assert_equal [], int_triple.cs253find_all { |e| e < 0}
    assert_equal ["bb", "cc"], str_triple.cs253find_all { |e| e.length > 1 }
  end

  def test_find_index
    int_triple = Triple.new(1, 2, 4)
    str_triple = Triple.new("a", "bb", "cc")

    assert_equal 1, int_triple.cs253find_index {|e| e.even?}
    assert_nil int_triple.cs253find_index { |e| e < 0}
    assert_equal 1, str_triple.cs253find_index { |e| e.length > 1 }
    assert_equal 1, int_triple.cs253find_index(2)
  end

  def test_first
    empty_arr = CS253Array.new([])
    int_triple = Triple.new(1, 2, 4)

    # BAD_TEST: should expect []
    # assert_nil empty_arr.cs253first
    # assert_nil empty_arr.cs253first(10)
    assert_equal [1, 2, 4], int_triple.cs253first(10)
  end

  def test_flat_map
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("abc", "def", "ghi")
    another_int_triple = Triple.new(0, 1, 2 )

    assert_equal [1, -1, 2, -2, 3, -3], int_triple.cs253flat_map { |e| [e, -e] }
    assert_equal ["abc", "cba", "def", "fed", "ghi", "ihg"], str_triple.cs253flat_map { |e| [e, e.reverse] }
    assert_equal [0, 1, 1, 2, 2, 3], another_int_triple.cs253flat_map {|e| [e, e+1]}
  end

  def test_grep
    str_triple = Triple.new("aab", "a2018b", "baa")

    assert_equal ["aabaab"], str_triple.cs253grep(/^a*b$/) {|e| e + e}
    assert_equal ["a2018b"], str_triple.cs253grep(/^a[0-9]+b$/)
    assert_equal [], str_triple.cs253grep(/^[0-9]$/)
  end

  def test_grep_v
    str_triple = Triple.new("aab", "a2018b", "baa")

    assert_equal ["a2018ba2018b", "baabaa"], str_triple.cs253grep_v(/^a*b$/) {|e| e + e}
    assert_equal ["aab", "baa"], str_triple.cs253grep_v(/^a[0-9]+b$/)
    assert_equal ["aab", "a2018b", "baa"], str_triple.cs253grep_v(/^[0-9]$/)
  end

  def test_group_by
    int_triple = Triple.new(6, 9, 1)
    str_triple = Triple.new("a", "bb", "c")

    assert_equal [6, 9, 1].group_by { |e| e % 3 == 0 }, int_triple.cs253group_by { |e| e % 3 == 0 }
    assert_equal [6, 9, 1].group_by { |e| e % 2 == 0}, int_triple.cs253group_by { |e| e % 2 == 0 }
    assert_equal ["a", "bb", "c"].group_by { |e| e.length }, str_triple.cs253group_by { |e| e.length}
  end

  def test_include
    int_triple = Triple.new(6, 9, 1)
    str_triple = Triple.new("a", "bb", "c")

    assert_equal true, int_triple.cs253include?(9)
    assert_equal false, int_triple.cs253include?(10)
    assert_equal true, str_triple.cs253include?("bb")
  end

  def test_inject
    single_item_lst = Triple.new(12, 0, 0)
    assert_equal 12, single_item_lst.cs253inject{|acc, element| acc += element}

    string_lst = Triple.new("i", "love", "cs")
    assert_equal "i love cs", string_lst.cs253inject{|acc, new_str| acc += ' ' + new_str}

    int_lst = Triple.new(1, 2, 3)
    assert_equal 16, int_lst.cs253inject(10, :+)
  end

  def test_map
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("string", "anotherString", "lastString")
    zero_triple = Triple.new(0, 0, 0 )

    assert_equal [6,13,10], str_triple.cs253map{|i| i.length}
    assert_equal ["1", "2", "3"], int_triple.cs253map{|i| i.to_s}
    assert_equal [1, 1, 1], zero_triple.cs253map {|x| x + 1}
  end

  def test_max
    int_triple = Triple.new(1, 2, 3)
    long_int_arr = CS253Array.new([9, 367, 28, 29, 40])
    str_triple = Triple.new("aa", "bbbb", "ccc")

    assert_equal 3, int_triple.cs253max
    assert_equal "bbbb", str_triple.cs253max {|x1, x2| x1.length <=> x2.length}
    assert_equal [3, 2], int_triple.cs253max(2)
    assert_equal [367, 40, 29], long_int_arr.cs253max(3)
    assert_equal ["bbbb", "ccc"], str_triple.cs253max(2) {|x1, x2| x1.length <=> x2.length}
  end

  def test_max_by
    int_triple = Triple.new(-1, -2, -3)
    str_triple = Triple.new("aa", "bbbb", "ccc")

    assert_equal "bbbb", str_triple.cs253max_by { |x| x.length }
    assert_equal ["bbbb", "ccc"], str_triple.cs253max_by(2) { |x| x.length }
    assert_equal [-3, -2], int_triple.cs253max_by(2) {|x| x.abs}
  end

  def test_member
    int_triple = Triple.new(6, 9, 1)
    str_triple = Triple.new("a", "bb", "c")

    assert_equal true, int_triple.cs253member?(9)
    assert_equal false, int_triple.cs253member?(10)
    assert_equal true, str_triple.cs253member?("bb")
  end

  def test_min
    int_triple = Triple.new(1, 2, 3)
    long_int_arr = CS253Array.new([9, 367, 28, 29, 40])
    str_triple = Triple.new("aa", "bbbb", "ccc")

    assert_equal 1, int_triple.cs253min
    assert_equal "aa", str_triple.cs253min {|x1, x2| x1.length <=> x2.length}
    assert_equal [1, 2], int_triple.cs253min(2)
    assert_equal [9, 28, 29], long_int_arr.cs253min(3)
    assert_equal ["aa", "ccc"], str_triple.cs253min(2) {|x1, x2| x1.length <=> x2.length}
  end

  def test_min_by
    int_triple = Triple.new(-1, -2, -3)
    str_triple = Triple.new("aa", "bbbb", "ccc")

    assert_equal "aa", str_triple.cs253min_by { |x| x.length }
    assert_equal ["aa", "ccc"], str_triple.cs253min_by(2) { |x| x.length }
    assert_equal [-1, -2], int_triple.cs253min_by(2) {|x| x.abs}
  end

  def test_minmax
    str_triple = Triple.new("aa", "bbbb", "ccc")
    int_triple = Triple.new(-1, -2, -3)

    assert_equal ["aa", "ccc"], str_triple.cs253minmax
    assert_equal ["aa", "bbbb"], str_triple.cs253minmax { |x1, x2| x1.length <=> x2.length}
    assert_equal [-1, -3], int_triple.cs253minmax {|x1, x2| x1.abs <=> x2.abs}
  end

  def test_minmax_by
    str_triple = Triple.new("aa", "bbbb", "ccc")
    int_triple = Triple.new(-1, -2, -3)

    assert_equal ["aa", "bbbb"], str_triple.cs253minmax_by {|x| x.length}
    assert_equal [-1, -3], int_triple.cs253minmax_by {|x| x.abs}
    assert_equal ["aa", "ccc"], str_triple.cs253minmax_by {|x| x[0]}
  end

  def test_none
    str_triple = Triple.new("aa", "babb", "ccc")
    int_triple = Triple.new(-1, -2, -3)

    assert_equal false, str_triple.cs253none? { |x| x.length == 4}
    assert_equal true, str_triple.cs253none? { |x| x.length == 10}
    assert_equal true, int_triple.cs253none? { |x| x > 0}
  end

  def test_one
    str_triple = Triple.new("aaa", "babb", "ccc")
    int_triple = Triple.new(-1, -2, -3)

    assert_equal true, int_triple.cs253one? {|x| x == -2}
    assert_equal false, str_triple.cs253one? {|x| x.length == 3}
    assert_equal false, int_triple.cs253one? {|x| x > 0}
  end

  def test_partition
    str_triple = Triple.new("aaa", "babb", "ccc")
    int_triple = Triple.new(-1, 2, -3)

    assert_equal [[-1, -3], [2]], int_triple.cs253partition { |x| x < 0}
    assert_equal [["babb"], ["aaa", "ccc"]], str_triple.cs253partition { |x| x.length > 3}
    assert_equal [[], [-1, 2, -3]], int_triple.cs253partition { |x| x > 4 }
  end

  def test_reduce
    single_item_lst = Triple.new(12, 0, 0)
    assert_equal 12, single_item_lst.cs253reduce{|acc, element| acc += element}

    string_lst = Triple.new("i", "love", "cs")
    assert_equal "i love cs", string_lst.cs253reduce{|acc, new_str| acc += ' ' + new_str}

    int_lst = Triple.new(1, 2, 3)
    assert_equal 16, int_lst.cs253reduce(10, :+)
  end

  def test_reject
    str_triple = Triple.new("aaa", "babb", "ccc")
    int_triple = Triple.new(-1, 2, -3)

    assert_equal ["aaa", "ccc"], str_triple.cs253reject { |x| x.length > 3}
    assert_equal [-1, -3], int_triple.cs253reject { |x| x > 0 }
    assert_equal [], int_triple.cs253reject { |x| x < 4 }
  end

  def test_reverse_each
    str_triple = Triple.new("aaa", "babb", "ccc")
    int_triple = Triple.new(-1, 2, -3)
    long_int_arr = CS253Array.new([9, 367, 28, 29, 40])

    assert_equal int_triple, int_triple.cs253reverse_each {|x| p x}
    assert_equal str_triple, str_triple.cs253reverse_each {|x| p x}
    assert_equal long_int_arr, long_int_arr.cs253reverse_each {|x| p x}
  end

  def test_select
    int_triple = Triple.new(1, 2, 4)
    str_triple = Triple.new("a", "bb", "cc")

    assert_equal [2, 4], int_triple.cs253select {|e| e.even?}
    assert_equal [], int_triple.cs253select { |e| e < 0}
    assert_equal ["bb", "cc"], str_triple.cs253select { |e| e.length > 1 }
  end

  def test_slice_after
    str_triple = Triple.new("a", "bb", "cc")
    another_str_triple = Triple.new("aab", "a2018b", "baa")

    assert_equal [["a", "bb"], ["cc"]], str_triple.cs253slice_after(/^b*$/)
    assert_equal [["aab", "a2018b"], ["baa"]], another_str_triple.cs253slice_after(/^a[0-9]+b$/)
    assert_equal [["aab", "a2018b"], ["baa"]], another_str_triple.cs253slice_after { |e| e.length == 6}
  end

  def test_slice_before
    str_triple = Triple.new("a", "bb", "cc")
    another_str_triple = Triple.new("aab", "a2018b", "baa")

    assert_equal [["a"], ["bb", "cc"]], str_triple.cs253slice_before(/^b*$/)
    assert_equal [["aab"], ["a2018b", "baa"]], another_str_triple.cs253slice_before(/^a[0-9]+b$/)
    assert_equal [["aab"], ["a2018b", "baa"]], another_str_triple.cs253slice_before { |e| e.length == 6}
  end

  def test_slice_when
    int_triple = Triple.new(1, 2, 4)
    str_triple = Triple.new("a", "bb", "cc")

    assert_equal [[1, 2], [4]], int_triple.cs253slice_when {|i, j| i+1 != j }
    assert_equal [["a"], ["bb", "cc"]], str_triple.cs253slice_when { |x1, x2| x1.length != x2.length }
    assert_equal [[1, 2, 4]], int_triple.cs253slice_when { |i, j| i * 2 != j}
  end

  def test_sort
    int_arr = CS253Array.new([3,8,3,7,2,7,9,5])
    int_triple = Triple.new(1, 4, 2)

    assert_equal [1, 2, 4], int_triple.cs253sort
    assert_equal [2, 3, 3, 5, 7, 7, 8, 9], int_arr.cs253sort
    assert_equal [9, 8, 7, 7, 5, 3, 3, 2], int_arr.cs253sort {|x1, x2| -x1 <=> -x2}
    assert_equal [9, 8, 7, 7, 5, 3, 3, 2], int_arr.cs253sort {|x1, x2| x2 <=> x1}
  end

  def test_sort_by
    int_arr = CS253Array.new([3,8,3,7,2,7,9,5])
    int_triple = Triple.new(1, 4, 2)

    assert_equal [2, 3, 3, 5, 7, 7, 8, 9], int_arr.cs253sort_by { |x| x ** 2}
    assert_equal [9, 8, 7, 7, 5, 3, 3, 2], int_arr.cs253sort_by {|x| -x}
    assert_equal [2, 3, 3, 5, 7, 7, 8, 9], int_arr.cs253sort_by { |x| x*x}
  end

  def test_sum
    int_triple = Triple.new(1, 2, 4)

    assert_equal 7, int_triple.cs253sum
    assert_equal 17, int_triple.cs253sum(10)
    assert_equal 10, int_triple.cs253sum {|x| x + 1}
  end

  def test_take
    int_triple = Triple.new(1, 2, 4)

    assert_equal [1], int_triple.cs253take(1)
    assert_equal [1, 2], int_triple.cs253take(2)
    assert_equal [], int_triple.cs253take(0)
  end

  def test_take_while
    int_triple = Triple.new(1, 2, 4)

    assert_equal [1], int_triple.cs253take_while {|x| x < 2}
    assert_equal [1, 2], int_triple.cs253take_while {|x| x<4}
    assert_equal [], int_triple.cs253take_while {|x| x < 0}
  end

  def test_to_a
    int_triple = Triple.new(1, 2, 4)
    int_arr = CS253Array.new([3,8,3,7,2,7,9,5])
    another_str_triple = Triple.new("aab", "a2018b", "baa")

    assert_equal [1, 2, 4], int_triple.cs253to_a
    assert_equal [3,8,3,7,2,7,9,5], int_arr.cs253to_a
    assert_equal ["aab", "a2018b", "baa"], another_str_triple.cs253to_a
  end

  def test_to_h
    int_triple = Triple.new([1, 0], [2, 1], [4, 2])
    int_arr = CS253Array.new([[2, 3], [3, 4]])
    another_str_triple = Triple.new(["aab", "bba"], ["a2018b", "b2018a"], ["bba", "aab"])

    h_int_triple = { 1 => 0, 2 => 1, 4 => 2 }
    h_int_arr = { 2 => 3, 3 => 4}
    h_str_triple = {"aab" => "bba", "a2018b" => "b2018a", "bba" => "aab"}
    assert_equal h_int_triple, int_triple.cs253to_h
    assert_equal h_int_arr, int_arr.cs253to_h
    assert_equal h_str_triple, another_str_triple.cs253to_h
  end

  def test_uniq
    int_arr = CS253Array.new([3,8,3,7,2,7,9,5])
    int_triple = Triple.new(2, 2, 4)
    another_str_triple = Triple.new("aab", "aab", "baa")


    assert_equal [3, 8, 7, 2, 9, 5], int_arr.cs253uniq
    assert_equal [2], int_triple.cs253uniq {|x| x.even?}
    assert_equal ["aab", "baa"], another_str_triple.cs253uniq
  end

  def test_zip
    b = Triple.new(7, 8, 9)
    a = Triple.new(4, 5, 6)
    c = Triple.new(1, 2, 3)

    assert_equal [[1, 4, 7], [2, 5, 8], [3, 6, 9]], c.cs253zip(a, b)
    assert_equal [[4, 1, 8], [5, 2, nil], [6, nil, nil]], a.cs253zip([1, 2], [8])
    assert_nil c.cs253zip(a, b) {|x, y| p x*y}
  end
end
