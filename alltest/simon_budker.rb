require 'minitest/autorun'
require_relative './cs253Array.rb'
require_relative './triple.rb'

class TestCS253Enumerable < Minitest::Test
    class CS253Range < Range
        include CS253Enumerable
    end

    def setup
        @int_arr = CS253Array.new([1, 2, 3, 4])
        @str_arr = CS253Array.new(["string", "anotherString", "oneMoreString", "lastString"])
        @empty_arr = CS253Array.new([])
        @nil_arr = CS253Array.new([nil, nil, nil])
        @nil_triple = Triple.new()
        @int_triple = Triple.new(2, 4, 6)
        @str_triple = Triple.new("first", "second", "third")
        @int_range = CS253Range.new(0, 3)
    end

    def test_all_non_empty_arr
        assert_equal true, @int_arr.cs253all? { |n| n > 0 }
        assert_equal false, @int_arr.cs253all? { |n| n < 2 }
        assert_equal true, @str_arr.cs253all? { |n| n.length > 3 }
        assert_equal false, @str_arr.cs253all? { |n| n.length < 7 }
    end

    def test_all_empty_arr
        assert_equal true, @empty_arr.cs253all? { |n| n }
        assert_equal true, @empty_arr.cs253all?
    end

    def test_all_nil
        assert_equal false, @nil_arr.cs253all? { |n| n }
        assert_equal true, @nil_arr.cs253all? { |n| n == nil }
        assert_equal false, @nil_triple.cs253all? { |n| n }
        assert_equal true, @nil_triple.cs253all? { |n| n == nil }
        assert_equal false, CS253Array.new([nil, true, 99]).cs253all?
    end

    def test_all_triple
        assert_equal true, @int_triple.cs253all? { |n| n > 0 }
        assert_equal false, @int_triple.cs253all? { |n| n < 2 }
        assert_equal true, @str_triple.cs253all? { |n| n.length > 3 }
        assert_equal false, @str_triple.cs253all? { |n| n.length < 5 }
    end

    def test_any_non_empty_arr
        assert_equal true, @int_arr.cs253any? { |n| n > 0 }
        assert_equal false, @int_arr.cs253any? { |n| n < 0 }
        assert_equal true, @str_arr.cs253any? { |n| n.length > 3 }
        assert_equal false, @str_arr.cs253any? { |n| n.length < 2 }
    end

    def test_any_empty_arr
        assert_equal false, @empty_arr.cs253any? { |n| n }
        assert_equal false, @empty_arr.cs253any?
    end

    def test_any_nil
        assert_equal false, @nil_arr.cs253any? { |n| n }
        assert_equal true, @nil_arr.cs253any? { |n| n == nil }
        assert_equal false, @nil_triple.cs253any? { |n| n }
        assert_equal true, @nil_triple.cs253any? { |n| n == nil }
        assert_equal true, CS253Array.new([nil, true, 99]).cs253any?
    end

    def test_any_triple
        assert_equal true, @int_triple.cs253any? { |n| n > 0 }
        assert_equal false, @int_triple.cs253any? { |n| n < 2 }
        assert_equal true, @str_triple.cs253any? { |n| n.length > 3 }
        assert_equal false, @str_triple.cs253any? { |n| n.length < 5 }
    end

    def test_chunk_arr
        assert_equal [[false, [1]], [true, [2]], [false, [3]], [true, [4]]], @int_arr.cs253chunk { |n| n.even? }
        a = [["string", ["string"]], ["anotherString", ["anotherString"]], ["oneMoreString", ["oneMoreString"]], ["lastString", ["lastString"]]]
        assert_equal a, @str_arr.cs253chunk { |n| n }
        assert_equal [[7, 5, 9], [2, 0], [7, 9], [4, 2, 0]], CS253Array.new([7, 5, 9, 2, 0, 7, 9, 4, 2, 0]).cs253chunk_while {|i, j| i.even? == j.even? }
    end

    def test_chunk_empty
        assert_equal [], @empty_arr.cs253chunk { |n| n }
        assert_equal [], @empty_arr.cs253chunk { |n| n.even? }
    end

    def test_chunk_nil
        assert_equal [[true, [nil, nil, nil]]], @nil_arr.cs253chunk { |e| e == nil }
        assert_equal [[nil, [nil, nil, nil]]], @nil_triple.cs253chunk { |e| e }
    end

    def test_chunk_triple
        assert_equal [[true, [2, 4, 6]]], @int_triple.cs253chunk { |n| n.even? }
        assert_equal [[5, ["first"]], [6, ["second"]], [5, ["third"]]], @str_triple.cs253chunk { |s| s.length }
    end

    def test_chunk_while_arr
        assert_equal [[1, 2], [3], [4]], @int_arr.cs253chunk_while { |bef, aft| bef == 1 }
        assert_equal [[1, 2, 3, 4]], @int_arr.cs253chunk_while { |bef, aft| aft - bef == 1 }
        assert_equal [[1, 2], [4], [9, 10, 11, 12]], CS253Array.new([1,2,4,9,10,11,12]).cs253chunk_while { |i, j| i+1 == j }

        assert_equal @str_arr.map { |e| [e] }, @str_arr.cs253chunk_while { |a, b| false }
        assert_equal [["string", "anotherString"], ["oneMoreString"], ["lastString"]], @str_arr.cs253chunk_while { |a, b| a.length + b.length <= 19 }
    end

    def test_chunk_while_empty
        assert_equal [],  @empty_arr.cs253chunk_while { |a, b| a == b }
        assert_equal [],  @empty_arr.cs253chunk_while { |a, b| a.even? && b.even? }
    end

    def test_chunk_while_nil
        assert_equal [[nil, nil, nil]], @nil_arr.cs253chunk_while { |a, b| a == b }
        assert_equal [[nil], [nil], [nil]], @nil_arr.cs253chunk_while { |a, b| a != b }
    end

    def test_chunk_while_triple
        assert_equal [[2, 4, 6]], @int_triple.cs253chunk_while { |a, b| a + 2 == b }
        assert_equal [[2, 4], [6]], @int_triple.cs253chunk_while { |a, b| a + b <= 6  }
        assert_equal [["first"], ["second"], ["third"]], @str_triple.cs253chunk_while { |a, b| a.length == b.length }
        assert_equal [["first", "second", "third"]], @str_triple.cs253chunk_while { |a, b| a.length != b.length }
    end

    def test_collect_and_map_arr
        assert_equal [2, 4, 6, 8], @int_arr.cs253collect { |i| i * 2}
        assert_equal ["1", "2", "3", "4"], @int_arr.cs253collect { |i| i.to_s }
        assert_equal ["s", "a", "o", "l"], @str_arr.cs253collect {|s| s[0]}
        assert_equal [6, 13, 13, 10], @str_arr.cs253collect {|s| s.length}
    end

    def test_collect_and_map_empty
        assert_equal [], @empty_arr.cs253collect { |e| e }
    end

    def test_collect_and_map_nil
        mixed_arr = CS253Array.new([nil, "str", "str"])
        assert_equal [nil, nil, nil], @nil_arr.cs253collect { |e| }
        assert_equal [nil, "nil", "nil"], mixed_arr.cs253collect { |e| e.nil? ? nil : "nil" }
    end

    def test_collect_and_map_triple
        assert_equal ["dog", "dog", "dog"], @int_triple.cs253collect { "dog" }
        assert_equal [5, 6, 5], @str_triple.cs253collect { |c| c.length }
    end

    def test_collect_concat_and_flat_map_arr
        assert_equal [2, 4, 6, 8], @int_arr.cs253flat_map { |e| e * 2 }
        simple_arr = CS253Array.new([[3], [6], [9], [12]])
        assert_equal @int_arr, simple_arr.cs253collect_concat { |e| e[0] /= 3 }
        complex_arr = CS253Array.new([1, [2], [3, [4]]])
        assert_equal [1, 2, 5, 3, [4], 5], complex_arr.cs253collect_concat { |e| e.class.name == "Array" ? e + [5] : e }
        assert_equal [1, 2, 100, 3, 4, 100], CS253Array.new([[1, 2], [3, 4]]).cs253collect_concat { |e| e + [100] }
        assert_equal [1, [1..5], 0, 3, 0], CS253Array.new([[1, [1..5]], [3]]).cs253flat_map { |e| e + [0] }
        assert_equal ["strin", "g", "strin", ["string"], "g"], CS253Array.new([["strin"], ["strin", ["string"]]]).cs253collect_concat { |e| e + ["g"]  }
    end

    def test_collect_concat_and_flat_map_empty
        assert_equal [], @empty_arr.cs253collect_concat { |e| e }
    end

    def test_collect_concat_and_flat_map_nil
        assert_equal [nil, nil, nil], @nil_arr.cs253collect_concat { |e| e }
        assert_equal [nil, nil, nil], @nil_arr.cs253collect_concat { |e| [e] }
        assert_equal [[nil], [nil], [nil]], @nil_triple.cs253collect_concat { |e| [[e]] }
    end

    def test_collect_concat_and_flat_map_triple
        assert_equal [1, [2], [[3]]], Triple.new([1], [[2]], [[[3]]]).cs253collect_concat { |e| e }
        assert_equal [2, 4, 6], @int_triple.cs253flat_map { |e| [e] }
        assert_equal ["first", ["second"], "third"], @str_triple.cs253flat_map { |s| s.length.even? ? [[s]] : [s] }
    end

    def test_count_arr
        assert_equal 4, @int_arr.cs253count
        assert_equal 1, @int_arr.cs253count(2)
        assert_equal 2, @int_arr.cs253count { |i| i.even? }
        assert_equal 4, @str_arr.cs253count
        assert_equal 1, @str_arr.cs253count("string")
        assert_equal 2, @str_arr.cs253count { |s| s.length.even? }
    end

    def test_count_nil
        assert_equal 3, @nil_arr.cs253count
        assert_equal 3, @nil_arr.cs253count(nil)
        assert_equal 3, @nil_arr.cs253count { |n| n.nil? }
    end

    def test_count_empty
        assert_equal 0, @empty_arr.cs253count
        assert_equal 0, @empty_arr.cs253count(2)
        assert_equal 0, @empty_arr.cs253count { |i| i.even? }
    end

    def test_count_triple
        assert_equal 3, @int_triple.cs253count
        assert_equal 1, @int_triple.cs253count(4)
        assert_equal 3, @int_triple.cs253count { |e| e.even? }
        assert_equal 3, @str_triple.cs253count
        assert_equal 1, @str_triple.cs253count("third")
        assert_equal 2, @str_triple.cs253count { |e| e.length == 5 }
    end

    # not testing infinite case since we did not need to do this
    # TODO: ensure after first iter internal arr is cached
    def test_cycle_arr
        sum = 0
        @int_arr.cs253cycle(3) { |i| sum += i }
        assert_equal 30, sum
        a = []
        @str_arr.cs253cycle(2) { |s| a << s }
        assert_equal @str_arr + @str_arr, a
    end

    def test_cycle_empty
        out = []
        @empty_arr.cs253cycle(4) { |e| out << e }
        assert_equal @empty_arr, out
    end

    def test_cycle_nil
        double = []
        @nil_arr.cs253cycle(2) { |e| double << e }
        assert_equal @nil_arr + @nil_arr, double
    end

    def test_cycle_triple
        sum = 0
        @int_triple.cs253cycle(3) { |i| sum += i }
        assert_equal 36, sum
        a = []
        @str_triple.cs253cycle(2) { |s| a << s }
        assert_equal ["first", "second", "third", "first", "second", "third"], a
    end

    def test_detect_and_find_arr
        assert_equal 2, @int_arr.cs253detect { |e| e == 2 }
        assert_nil @int_arr.cs253detect { |e| e == 100 }
        # testing ifnone is called
        assert_equal true, @int_arr.cs253detect(lambda { true }) { |e| e == 1000 }
        # ensure first match is returned
        assert_equal "anotherString", @str_arr.cs253detect { |e| e.length == 13 }
    end

    def test_detect_and_find_empty
        assert_nil @empty_arr.cs253detect { |e| }
        assert_equal true, @empty_arr.cs253detect(lambda { true }) { |e| }
    end

    def test_detect_and_find_nil
        assert_equal false, @nil_arr.cs253find(lambda { false }) { |e| !e.nil? }
        assert_nil @nil_arr.cs253find(lambda { false }) { |e| e.nil? }
        assert_equal false, @nil_triple.cs253find(lambda { false }) { |e| !e.nil? }
        assert_nil @nil_triple.cs253find(lambda { false }) { |e| e.nil? }
    end

    def test_detect_and_find_triple
        assert_equal 4, @int_triple.cs253detect { |e| e == 4 }
        assert_nil @int_triple.cs253detect { |e| e == 100 }
        assert_equal true, @int_triple.cs253detect(lambda { true }) { |e| e == 1000 }
        assert_equal "second", @str_triple.cs253detect { |e| e.length == 6 }
    end

    def test_drop_arr
        assert_equal [3, 4], @int_arr.cs253drop(2)
        assert_raises(ArgumentError) { @int_arr.cs253drop(-2) }
        assert_equal @int_arr, @int_arr.cs253drop(0)
        assert_equal @empty_arr, @str_arr.cs253drop(4)
        assert_equal @empty_arr, @str_arr.cs253drop(5)
    end

    def test_drop_empty
        assert_raises(ArgumentError) { @empty_arr.cs253drop(-2) }
        assert_equal [], @empty_arr.cs253drop(4)
    end

    def test_drop_nil
        assert_equal [nil, nil], @nil_triple.cs253drop(1)
        assert_equal [nil, nil], @nil_arr.cs253drop(1)
    end

    def test_drop_triple
        assert_equal [6], @int_triple.cs253drop(2)
        assert_raises(ArgumentError) { @int_triple.cs253drop(-2) }
        assert_equal [2, 4, 6], @int_triple.cs253drop(0)
        assert_equal ["third"], @str_triple.cs253drop(2)
        assert_equal @empty_arr, @str_triple.cs253drop(3)
        assert_equal @empty_arr, @str_triple.cs253drop(5)
    end

    def test_drop_while_arr
        assert_equal [3, 2, 4, 0], CS253Array.new([1, 2, 3, 2, 4, 0]).cs253drop_while { |i| i < 3 }
        assert_equal [3, 4], @int_arr.cs253drop_while { |i| i < 3 }
        assert_equal @int_arr, @int_arr.cs253drop_while { |i| i > 100 }
        assert_equal ["anotherString", "oneMoreString", "lastString"], @str_arr.cs253drop_while { |s| s.length <= 6 }
    end

    def test_drop_while_empty
        assert_equal @empty_arr, @empty_arr.cs253drop_while { |i| i > 2 }
    end

    def test_drop_while_nil
        assert_equal [nil, nil, nil], @nil_triple.cs253drop_while { |n| !n.nil? }
        assert_equal [nil, nil, nil], @nil_arr.cs253drop_while { |n| !n.nil? }
        assert_equal @empty_arr, @nil_triple.cs253drop_while { |n| n.nil? }
        assert_equal @empty_arr, @nil_arr.cs253drop_while { |n| n.nil? }
    end

    def test_drop_while_triple
        assert_equal [6], @int_triple.cs253drop_while { |i| i < 5  }
        assert_equal @empty_arr, @int_triple.cs253drop_while { |i| i > -100 }
        assert_equal ["first", "second", "third"], @str_triple.cs253drop_while { |s| s.length < 0 }
    end

    def test_each_cons_arr
        out = []
        assert_nil @int_arr.cs253each_cons(2) { |e| out << e }
        assert_equal [[1, 2], [2, 3], [3, 4]], out
        out = []
        @int_arr.cs253each_cons(1) { |e| out << e }
        assert_equal [[1], [2], [3], [4]], out
        out = []
        @str_arr.cs253each_cons(5) { |e| out << e }
        assert_equal [], out
    end

    def test_each_cons_empty
        assert_nil @empty_arr.cs253each_cons(2) { |e| }
        out = []
        @empty_arr.cs253each_cons(2) { |e| out << e }
        assert_equal [], out
    end

    def test_each_cons_nil
        out = []
        @nil_arr.cs253each_cons(3) { |e| out << e }
        assert_equal [[nil, nil, nil]], out
        out = []
        @nil_triple.cs253each_cons(2) { |e| out << e }
        assert_equal [[nil, nil], [nil, nil]], out
    end

    def test_each_cons_triple
        out = []
        @str_triple.cs253each_cons(3) { |e| out << e }
        assert_equal [["first", "second", "third"]], out
        out = []
        assert_raises(ArgumentError) { @str_triple.cs253each_cons(-1) { |e| out << e } }
        assert_equal @empty_arr, out
        out = []
        assert_raises(ArgumentError) { @str_triple.cs253each_cons(0) { |e| out << e } }
        assert_equal @empty_arr, out
    end

    # helper class for testing each_entry
    class EachEntryTester
        include CS253Enumerable
        def each
            yield 1
            yield 1, 2
            yield
        end
    end

    def test_each_entry_arr
        in_tester = EachEntryTester.new()
        out_arr = []
        in_tester.cs253each_entry { |e| out_arr << e }
        assert_equal [1, [1, 2], nil], out_arr
        # showing diff between each & each_entry
        out_arr = []
        in_tester.each { |e| out_arr << e }
        assert_equal [1, 1, nil], out_arr
        out_arr = []
        @int_arr.cs253each_entry { |e| out_arr << e * 2 }
        assert_equal [2, 4, 6, 8], out_arr
    end

    def test_each_entry_empty
        out = []
        @empty_arr.cs253each_entry { |e| out_arr << e }
        assert_equal [], out
    end

    def test_each_entry_nil
        out = []
        @nil_triple.cs253each_entry { |e| out << 0 if e.nil? }
        assert_equal [0, 0, 0], out
    end

    def test_each_entry_triple
        out = []
        @str_triple.cs253each_entry { |s| out << s[0] }
        assert_equal ["f", "s", "t"], out
    end

    def test_each_slice_arr
        a = []
        @int_arr.cs253each_slice(2) { |x| a << x }
        assert_equal [[1, 2], [3, 4]], a
        s_out = []
        @str_arr.cs253each_slice(4) { |s| s_out << s }
        assert_equal [@str_arr], s_out
        s_out = []
        @str_arr.cs253each_slice(5) { |s| s_out << s }
        assert_equal [@str_arr], s_out
    end

    def test_each_slice_errors
        assert_raises(ArgumentError) {  @str_arr.cs253each_slice(0) { |s| s_out << s } }
        assert_raises(ArgumentError) {  @str_arr.cs253each_slice(-5) { |s| s_out << s } }
    end

    def test_each_slice_empty
        assert_nil @empty_arr.cs253each_slice(2) { |e| e }
    end

    def test_each_slice_nil
        out = []
        @nil_triple.cs253each_slice(1) { |e| out << e }
        assert_equal [[nil], [nil], [nil]], out
    end

    def test_each_slice_triple
        out = []
        @str_triple.cs253each_slice(3) { |e| out << e }
        assert_equal [["first", "second", "third"]], out
    end

    def test_each_slice_range
        out = []
        @int_range.each_slice(3) { |a| out << a }
        assert_equal [[0, 1, 2], [3]], out
    end

    def test_each_with_index_arr
        a = []
        assert_equal @int_arr, @int_arr.cs253each_with_index { | e, i | a << [e, i] }
        assert_equal [[1, 0], [2, 1], [3, 2], [4, 3]], a
    end


    def test_each_with_index_empty
        out = []
        @empty_arr.cs253each_with_index { |e, i| out << [e, i] }
        assert_equal [], out
    end

    def test_each_with_index_nil
        out = []
        @nil_triple.cs253each_with_index { |e, i| out << [e, i] }
        assert_equal [[nil, 0], [nil, 1], [nil, 2]], out
    end

    def test_each_with_index_triple
        out = []
        @str_triple.cs253each_with_index { |s, i| out << s.length + i }
        assert_equal [5, 7, 7], out
    end

    def test_each_with_object_arr
        assert_equal [2, 4, 6, 8], @int_arr.cs253each_with_object([]) { | i, a | a << (i * 2) }
        assert_equal [1, 2, 3, 4], CS253Array.new([[1, 2], [3, 4]]).cs253each_with_object([]) { |e, obj | obj << e[0] << e[1] }
    end

    def test_each_with_object_error
        assert_raises(ArgumentError) { @empty_arr.cs253each_with_object() { |e, obj| obj << e } }
        assert_equal [], @empty_arr.cs253each_with_object([]) { |e| obj << e }
    end

    def test_each_with_object_empty
        assert_equal [], @empty_arr.cs253each_with_object([]) { |e, obj| obj << e }
    end

    def test_each_with_object_nil
        assert_nil @str_arr.cs253each_with_object(nil) { |e, obj| }
        assert_equal [nil, nil, nil], @nil_triple.cs253each_with_object([]) { |e, obj| obj << e }
    end

    def test_each_with_object_triple
        assert_equal [4, 8, 12], @int_triple.cs253each_with_object([]) { | i, a | a << (i * 2) }
    end

    def test_entries_and_to_a_arr
        assert_equal @int_arr, @int_arr.cs253entries
        assert_equal @str_arr, @str_arr.cs253entries
    end

    def test_entries_and_to_a_empty
        assert_equal [], @empty_arr.cs253entries
    end

    def test_entries_and_to_a_nil
        assert_equal [nil, nil, nil], @nil_triple.cs253entries
    end

    def test_entries_and_to_a_triple
        assert_equal [2, 4, 6], @int_triple.cs253to_a
        assert_equal ["first", "second", "third"], @str_triple.cs253to_a
    end

    def test_entries_and_to_a_range
        assert_equal [0, 1, 2, 3], @int_range.cs253to_a
    end

    def test_find_all_and_select_arr
        assert_equal [2, 4], @int_arr.cs253find_all { |num|  num.even?  }
    end

    def test_find_all_and_select_empty
        assert_equal [], @empty_arr.cs253find_all { |num|  num.even?  }
    end

    def test_find_all_and_select_nil
        assert_equal [nil, nil, nil], @nil_arr.cs253find_all { |e| e.nil? }
        mixed_arr = CS253Array.new([0, nil, 2])
        assert_equal [0, 2], mixed_arr.cs253select { |e| e unless e.nil? }
    end

    def test_find_all_and_select_triple
        assert_equal [], @int_triple.cs253find_all { |e|  e < 2  }
        assert_equal [2], @int_triple.cs253find_all { |e|  e <= 2  }
    end

    def test_find_all_and_select_range
        assert_equal [1, 3], @int_range.cs253find_all { |num|  num.odd?  }
    end

    def test_find_index_arr
        assert_equal 2, @int_arr.cs253find_index { |i| i == 3 }
        assert_nil @int_arr.cs253find_index { |i| i % 5 == 0 and i % 7 == 0 }
    end

    def test_find_index_empty
        assert_nil @empty_arr.cs253find_index { |i| i == 3 }
    end

    def test_find_index_nil
        assert_equal 0, @nil_triple.cs253find_index { |e| e.nil? }
        assert_equal 0, @nil_triple.cs253find_index(nil)
        assert_equal 2, @str_triple.cs253find_index("third") { |e| e }
    end

    def test_find_index_triple
        assert_equal 2, @str_triple.cs253find_index("third")
    end

    def test_find_index_range
        assert_nil @int_range.cs253find_index(8)
    end

    def test_first_arr
        assert_equal 1, @int_arr.cs253first
        assert_equal [], @int_arr.cs253first(0)
        assert_equal [1, 2], @int_arr.cs253first(2)
    end

    def test_first_empty
        assert_nil @empty_arr.cs253first
        assert_equal [], @empty_arr.cs253first(0)
        assert_equal [], @empty_arr.cs253first(1)
    end

    def test_first_nil
        assert_nil @nil_triple.cs253first
        assert_equal [nil, nil, nil], @nil_triple.cs253first(4)
    end

    def test_first_error
        assert_raises(ArgumentError) { @nil_triple.cs253first(-4) }
    end

    def test_first_triple
        assert_equal "first", @str_triple.cs253first
        assert_equal ["first"], @str_triple.cs253first(1)
        assert_equal [], @str_triple.cs253first(0)
    end

    def test_grep_arr
        assert_equal [1, 2], @int_arr.cs253grep(1..2)
        assert_equal ["str"], @str_arr.cs253grep(/string/) { |e| e[0, 3] }
        c = CS253Array.new(IO.constants)
        assert_equal [:SEEK_SET, :SEEK_CUR, :SEEK_END, :SEEK_DATA, :SEEK_HOLE], c.cs253grep(/SEEK/)
        assert_equal [0, 1, 2, 4, 3], c.grep(/SEEK/) { |v| IO.const_get(v) }
    end

    def test_grep_empty
        assert_equal [], @empty_arr.cs253grep(//)
    end

    def test_grep_nil
        assert_equal [0, 0, 0], @nil_triple.cs253grep(nil) { |e| 0 }
    end

    def test_grep_triple
        assert_equal ["f", "s", "t"], @str_triple.cs253grep(/.*/) { |s| s[0] }
    end

    def test_grep_range
        assert_equal [2, 4], @int_range.cs253grep(1..2) { |i| i * 2 }
    end

    def test_grep_v_arr
        assert_equal [3, 4], @int_arr.cs253grep_v(1..2)
        assert_equal ["ano", "one", "las"], @str_arr.cs253grep_v(/string/) { |e| e[0, 3] }
    end

    def test_grep_v_empty
        assert_equal [], @empty_arr.cs253grep_v(//)
    end

    def test_grep_v_nil
        assert_equal [], @nil_triple.cs253grep_v(nil) { |e| 0 }
        mixed_arr = CS253Array.new([0, nil, "str"])
        assert_equal [0, "str"], mixed_arr.cs253grep_v(nil)
    end

    def test_grep_v_triple
        assert_equal ["f", "s"], @str_triple.cs253grep_v(/third/) { |s| s[0] }
    end

    def test_grep_v_range
        assert_equal [0, 6], @int_range.cs253grep_v(1..2) { |i| i * 2 }
    end

    def test_group_by_arr
        h = { 0 => [3], 1 => [1, 4], 2 => [2] }
        assert_equal h, @int_arr.cs253group_by { |i| i % 3 }
    end

    def test_group_by_empty
        h = {}
        assert_equal h, @empty_arr.cs253group_by { |e| e }
    end

    def test_group_by_nil
        h = { 0 => [nil, nil, nil] }
        assert_equal h, @nil_triple.cs253group_by { |e| 0 }
        h = { nil => [nil, nil, nil] }
        assert_equal h, @nil_triple.cs253group_by { |e| e }
    end

    def test_group_by_triple
        h = { "f" => ["first"], "s" => ["second"], "t" => ["third"] }
        assert_equal h, @str_triple.cs253group_by { |s| s[0] }
    end

    def test_include_and_member_arr
        assert_equal true, @int_arr.cs253include?(1)
        assert_equal false, @int_arr.cs253include?("")
        assert_equal true, @str_arr.cs253include?("string")
        assert_equal false, @str_arr.cs253include?("strings")
        consts = CS253Array.new(IO.constants)
        assert_equal true, consts.cs253include?(:SEEK_SET)
        assert_equal false, consts.cs253include?(:SEEK_NO_FURTHER)
        assert_equal true, consts.cs253include?(:SEEK_SET)
        assert_equal false, consts.cs253include?(:SEEK_NO_FURTHER)
    end

    def test_include_and_member_empty
        assert_equal false, @empty_arr.cs253include?(0)
    end

    def test_include_and_member_nil
        assert_equal true, @nil_triple.cs253member?(nil)
        assert_equal false, @nil_triple.cs253member?(0)
    end

    def test_include_and_member_triple
        assert_equal true, @str_triple.cs253member?("third")
    end

    def test_inject_and_reduce_arr
        assert_equal 10, @int_arr.cs253reduce(:+)
        assert_equal 10, @int_arr.cs253inject { |sum, n| sum + n }
        assert_equal 24, @int_arr.cs253reduce(1, :*)
        assert_equal 24, @int_arr.cs253reduce { |prod, n| prod * n }
        assert_equal "string", @str_arr.cs253inject { |mem, s|  mem.length < s.length ? mem : s }
    end

    def test_inject_and_reduce_empty
        assert_equal 5, @empty_arr.cs253reduce(5) { |m, i| m + i }
        assert_nil @empty_arr.cs253reduce { |m, i| m + i }
    end

    def test_inject_and_reduce_nil
        assert_equal 3, @nil_triple.cs253reduce(0) { |m, e| e.nil? ? m + 1 : m }
    end

    def test_inject_and_reduce_triple
        assert_equal "firstsecondthird", @str_triple.cs253reduce(:+)
    end

    def test_max_arr
        assert_equal 4, @int_arr.cs253max
        assert_equal "string", @str_arr.cs253max
        # According to doc: "The result is not guaranteed to be stable.
        # When the comparison of two elements returns 0, the order of the elements is unpredictable."
        # look at sort in documentation
        assert_equal "oneMoreString", @str_arr.cs253max { |a, b| a.length <=> b.length }
        a = CS253Array.new(%w(elephant dog mouse))
        assert_equal "mouse", a.cs253max
        assert_equal ["elephant", "mouse"], a.max(2) { |a, b| a.length <=> b.length }
    end

    def test_max_empty
        assert_nil @empty_arr.cs253max
        assert_equal [], @empty_arr.cs253max(5)
    end

    def test_max_nil
        assert_nil @nil_triple.cs253max
        assert_equal [nil, nil, nil], @nil_triple.cs253max(5)
    end

    def test_max_triple
        assert_equal 6, @int_triple.cs253max
    end

    def test_max_by_arr
        assert_equal 4, @int_arr.cs253max_by { |i| i }
        assert_equal "string", @str_arr.cs253max_by { |s| s }
        a = CS253Array.new(%w(elephant dog mouse))
        assert_equal "mouse", a.cs253max_by { |s| s }
        assert_equal ["elephant", "mouse"], a.max(2) { |s| s.length }
    end

    def test_max_by_empty
        assert_nil @empty_arr.cs253max_by { |e| e }
        assert_equal [], @empty_arr.cs253max_by(5) { |e| e }
    end

    def test_max_by_nil
        assert_nil @nil_triple.cs253max_by { |e| e }
        assert_equal [nil, nil, nil], @nil_triple.cs253max_by(5) { |e| e }
    end

    def test_max_by_triple
        assert_equal 6, @int_triple.cs253max_by { |i| i }
    end

    def test_min_arr
        assert_equal 1, @int_arr.cs253min
        assert_equal "anotherString", @str_arr.cs253min
        assert_equal "string", @str_arr.cs253min { |a, b| a.length <=> b.length }
        a = CS253Array.new(%w(elephant dog mouse))
        assert_equal "dog", a.cs253min
        assert_equal ["dog", "mouse"], a.min(2) { |a, b| a.length <=> b.length }
    end

    def test_min_empty
        assert_nil @empty_arr.cs253min
        assert_equal [], @empty_arr.cs253min(5)
    end

    def test_min_nil
        assert_nil @nil_triple.cs253min
        assert_equal [nil, nil, nil], @nil_triple.cs253min(5)
    end

    def test_min_triple
        assert_equal 2, @int_triple.cs253min
    end

    def test_min_by_arr
        assert_equal 1, @int_arr.cs253min_by { |i| i }
        assert_equal "anotherString", @str_arr.cs253min_by { |s| s }
        a = CS253Array.new(%w(elephant dog mouse))
        assert_equal "dog", a.cs253min_by { |s| s }
        assert_equal ["dog", "mouse"], a.cs253min_by(2) { |s| s.length }
    end

    def test_min_by_empty
        assert_nil @empty_arr.cs253min_by { |e| e }
        assert_equal [], @empty_arr.cs253min_by(5) { |e| e }
    end

    def test_min_by_nil
        assert_nil @nil_triple.cs253min_by { |e| e }
        assert_equal [nil, nil, nil], @nil_triple.cs253min_by(5) { |e| e }
    end

    def test_min_by_triple
        assert_equal 2, @int_triple.cs253min_by { |i| i }
    end

    def test_minmax_arr
        assert_equal [1, 4], @int_arr.cs253minmax
        assert_equal ["string", "oneMoreString"], @str_arr.cs253minmax { |a, b| a.length <=> b.length }
    end

    def test_minmax_empty
        assert_equal [nil, nil], @empty_arr.cs253minmax
    end

    def test_minmax_nil
        assert_equal [nil, nil], @nil_triple.cs253minmax
    end

    def test_minmax_triple
        assert_equal [2, 6], @int_triple.cs253minmax { |a, b| a <=> b }
    end

    def test_minmax_by_arr
        assert_equal [1, 4], @int_arr.cs253minmax_by { |i| i }
        assert_equal ["string", "anotherString"], @str_arr.cs253minmax_by { |a| a.length }
    end

    def test_minmax_by_empty
        assert_equal [nil, nil], @empty_arr.cs253minmax_by { |a| a*2 }
    end

    def test_minmax_by_nil
        assert_equal [nil, nil], @nil_triple.cs253minmax_by { |a| 0 }
    end

    def test_minmax_by_triple
        assert_equal [2, 6], @int_triple.cs253minmax_by { |a| a }
    end

    def test_none_arr
        assert_equal true, @int_arr.cs253none? { |i| i > 10 }
        assert_equal false, @int_arr.cs253none? { |i| i < 10 }
        assert_equal false, @int_arr.cs253none?
        s = CS253Array.new(%w{car chat sat})
        assert_equal true, s.cs253none? { |word| word.length == 5 }
        assert_equal false, s.cs253none? { |word| word.length >= 4 }
    end

    def test_none_empty
        assert_equal true, @empty_arr.cs253none?
        assert_equal true, @empty_arr.cs253none? { |e| e }
    end

    def test_none_nil
        assert_equal true, @nil_triple.cs253none?
        a = @nil_arr << true
        assert_equal false, a.cs253none?
    end

    def test_none_triple
        assert_equal true, @int_triple.cs253none? { |e| e > 8 }
        assert_equal false, @int_triple.cs253none? { |e| e < 8 }
    end

    def test_one_arr
        assert_equal false, @int_arr.cs253one? { |i| i > 10 }
        assert_equal false, @int_arr.cs253one? { |i| i < 10 }
        assert_equal false, @int_arr.cs253one?
        s = CS253Array.new(%w{car chat sat})
        assert_equal false, s.cs253one? { |word| word.length == 5 }
        assert_equal true, s.cs253one? { |word| word.length >= 4 }
        assert_equal true, s.cs253one? { |word| word.length == 4 }
        assert_equal false, s.cs253one? { |word| word.length < 4 }
        assert_equal false, s.cs253one? { |word| word.length > 4 }
    end

    def test_one_empty
        assert_equal false, @empty_arr.cs253one?
        assert_equal false, @empty_arr.cs253one? { |e| e }
    end

    def test_one_nil
        assert_equal false, @nil_triple.cs253one?
        a = @nil_arr << true
        assert_equal true, a.cs253one?
        assert_equal false, CS253Array.new([ nil, true, 99 ]).cs253one?
    end

    def test_one_triple
        assert_equal false, @int_triple.cs253one? { |e| e > 8 }
        assert_equal false, @int_triple.cs253one? { |e| e < 8 }
        assert_equal true, @int_triple.cs253one? { |e| e < 3 }
    end

    def test_partition_arr
        assert_equal [[1, 3], [2, 4]], @int_arr.cs253partition { |e| e.odd? }
        assert_equal [[2, 4], [1, 3]], @int_arr.cs253partition { |e| e.even? }
    end

    def test_partition_empty
        assert_equal [[], []], @empty_arr.cs253partition { |e| e }
    end

    def test_partion_nil
        assert_equal [[], [nil, nil, nil]], @nil_triple.cs253partition { |e| e }
    end

    def test_partition_triple
        assert_equal [[2], [4, 6]], @int_triple.cs253partition { |i| i < 3 }
    end

    def test_reject_arr
        assert_equal [1, 3], @int_arr.cs253reject { |n| n.even? }
        assert_equal ["string"], @str_arr.cs253reject { |s| s.length > 6 }
    end

    def test_reject_empty
        assert_equal [], @empty_arr.cs253reject { |e| !e }
    end

    def test_reject_nil
        assert_equal [nil, nil, nil], @nil_triple.cs253reject { |e| e }
    end

    def test_reject_triple
        assert_equal [4, 6], @int_triple.cs253reject { |i| i < 3 }




    end

    def test_reverse_each_arr
        out = []
        @int_arr.cs253reverse_each { |e| out << e }
        assert_equal [4, 3, 2, 1], out
    end

    def test_reverse_each_empty
        out = []
        @empty_arr.cs253reverse_each { |e| out << e }
        assert_equal [], out
    end

    def test_reverse_each_nil
        out = []
        @nil_arr.cs253reverse_each { |e| out << e }
        assert_equal [nil, nil, nil], out
    end

    def test_reverse_each_triple
        out = []
        @str_triple.cs253reverse_each { |e| out << e }
        assert_equal ["third", "second", "first"], out
    end

    def test_sort_arr
        assert_equal [4, 3, 2, 1], @int_arr.cs253sort { |a, b| b <=> a }
        assert_equal [1, 2, 3, 4], @int_arr.cs253sort
        assert_equal ["string", "lastString", "anotherString", "oneMoreString"], @str_arr.cs253sort { |a, b| a.length <=> b.length }
        assert_equal ["anotherString", "oneMoreString", "lastString", "string"], @str_arr.cs253sort { |a, b| b.length <=> a.length }
    end

    def test_sort_empty
        assert_equal [], @empty_arr.cs253sort
        assert_equal [], @empty_arr.cs253sort { |a, b| b <=> a }
    end

    def test_slice_after_arr
        assert_equal [[1, 2], [3, 4]], @int_arr.cs253slice_after { |i| i == 2 }
        assert_equal [[1], [2, 3, 4]], @int_arr.cs253slice_after { |i| i == 1 }
        assert_equal [[1], [2, 3, 4]], @int_arr.cs253slice_after(1)
    end

    def test_slice_after_empty
        assert_equal [], @empty_arr.cs253slice_after { |e| e }
    end

    def test_slice_after_nil
        assert_equal [[nil], [nil], [nil]], @nil_triple.cs253slice_after { |e| e.nil? }
    end

    def test_slice_after_triple
        assert_equal [["first", "second", "third"]], @str_triple.cs253slice_after { |s| s.length > 20 }
        assert_equal [["first", "second"], ["third"]], @str_triple.cs253slice_after("second")
    end

    def test_slice_before_arr
        assert_equal [[1], [2, 3, 4]], @int_arr.cs253slice_before { |i| i == 2 }
        assert_equal [[1, 2, 3, 4]], @int_arr.cs253slice_before { |i| i == 1 }
        assert_equal [[1, 2], [3, 4]], @int_arr.cs253slice_before(3)
        assert_equal [[1, 2, 3, 4]], @int_arr.cs253slice_before(1)
    end

    def test_slice_before_empty
        assert_equal [], @empty_arr.cs253slice_before { |e| e }
    end

    def test_slice_before_nil
        assert_equal [[nil], [nil], [nil]], @nil_triple.cs253slice_before { |e| e.nil? }
    end

    def test_slice_before_triple
        assert_equal [["first", "second", "third"]], @str_triple.cs253slice_before { |s| s.length > 20 }
        assert_equal [["first"], ["second", "third"]], @str_triple.cs253slice_before("second")
    end

    def test_slice_when_arr
        a = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21])
        b = a.cs253slice_when {|i, j| i+1 != j }
        assert_equal [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]], b
        c = CS253Array.new([3, 11, 14, 25, 28, 29, 29, 41, 55, 57])
        d = c.cs253slice_when {|i, j| 6 < j - i }
        assert_equal [[3], [11, 14], [25, 28, 29, 29], [41], [55, 57]], d
        e = CS253Array.new([7, 5, 9, 2, 0, 7, 9, 4, 2, 0])
        f = e.cs253slice_when {|i, j| i.even? != j.even? }
        assert_equal [[7, 5, 9], [2, 0], [7, 9], [4, 2, 0]], f
    end

    def test_slice_when_empty
        assert_equal [], @empty_arr.cs253slice_when {|i, j| i+1 != j }
    end

    def test_slice_when_triple
        assert_equal [[2], [4, 6]], @int_triple.cs253slice_when {|i, j| i+j == 6 }
    end

    def test_sort_nil
        assert_equal [nil, nil, nil], @nil_triple.cs253sort
    end

    def test_sort_triple
        assert_equal [6, 4, 2], @int_triple.cs253sort { |a, b| b <=> a }
    end

    def test_sort_by_arr
        assert_equal [1, 2, 3, 4], @int_arr.cs253sort_by { |i| i * 2 }
        assert_equal [4, 3, 2, 1], @int_arr.cs253sort_by { |i| 1 - i }
        assert_equal ["string", "lastString", "anotherString", "oneMoreString"], @str_arr.cs253sort_by { |s| s.length }
    end

    def test_sort_by_empty
        assert_equal [], @empty_arr.cs253sort_by { |e| e }
    end

    def test_sort_by_nil
        assert_equal [nil, nil, nil], @nil_triple.cs253sort_by { |e| e }
    end

    def test_sort_by_triple
        assert_equal ["first", "second", "third"], @str_triple.cs253sort_by { |s| s[0] }
        assert_equal ["second", "third", "first"], @str_triple.cs253sort_by { |s| s[-1] }
    end

    def test_sum_arr
        assert_equal 10, @int_arr.cs253sum
        assert_equal 14, @int_arr.cs253sum { |i| i + 1 }
        assert_equal 10, @int_arr.cs253sum(-4) { |i| i + 1 }
    end

    def test_sum_empty
        assert_equal 0, @empty_arr.cs253sum
        assert_equal -4, @empty_arr.cs253sum(-4) { |i| i + 1 }
    end

    def test_sum_triple
        assert_equal 12, @int_triple.cs253sum


    end

    def test_take_arr
        assert_equal [], @int_arr.cs253take(0)
        assert_equal [1], @int_arr.cs253take(1)
        assert_equal [1, 2], @int_arr.cs253take(2)
        assert_equal [1, 2, 3, 4], @int_arr.cs253take(10)
    end

    def test_take_empty
        assert_equal [], @empty_arr.take(0)
        assert_equal [], @empty_arr.take(2)
    end

    def test_take_error
        assert_raises(ArgumentError) { @int_arr.cs253take(-10) }
    end

    def test_take_triple
        assert_equal [], @int_triple.cs253take(0)
        assert_equal [2], @int_triple.cs253take(1)
        assert_equal [2, 4], @int_triple.cs253take(2)
        assert_equal [2, 4, 6], @int_triple.cs253take(10)
    end

    def test_take_while_arr
        assert_equal [1, 2, 3], @int_arr.cs253take_while { |i| i < 4 }
    end

    def test_take_while_empty
        assert_equal [], @empty_arr.cs253take_while { |i| i < 4 }
    end

    def test_take_while_triple
        assert_equal [nil, nil, nil], @nil_triple.cs253take_while { |e| e.nil? }
    end

    def test_to_h_arr
        h = { "hello" => "world" }
        assert_equal h, CS253Array.new([["hello", "world"]]).cs253to_h
        h = { "hello" => "foo" }
        assert_equal h, CS253Array.new([["hello", "world"], ["hello", "foo"]]).cs253to_h
    end

    def test_to_h_error
        assert_raises(TypeError) { @nil_triple.cs253to_h }
    end

    def test_to_h_triple
        t = Triple.new([1, "one"], [2, "two"], [3, "three"])
        h = { 1 => "one", 2 => "two", 3 => "three" }
        assert_equal h, t.cs253to_h
    end

    def test_uniq_arr
        a = CS253Array.new([1, 2, 3, 1, 2, 5])
        assert_equal [1, 2, 3, 5], a.cs253uniq
        b = CS253Array.new([2, 2, 2, 2, 2])
        assert_equal [2], b.cs253uniq
        c = CS253Array.new([2, 2, 2, 2, 2])
        assert_equal [2], b.cs253uniq { |i| i + 2 }
        assert_equal [["dog"]], CS253Array.new([["dog"], ["dog"]]).cs253uniq
    end

    def test_uniq_empty
        assert_equal [], @empty_arr.cs253uniq
        assert_equal [], @empty_arr.cs253uniq { |i| i + 2 }
    end

    def test_uniq_nil
        assert_equal [nil], @nil_arr.cs253uniq
        assert_equal [nil], @nil_triple.cs253uniq { |e| e }
    end

    def test_uniq_triple
        assert_equal ["first", "second", "third"], @str_triple.cs253uniq
        assert_equal ["first", "second"], @str_triple.cs253uniq { |s| s[-1] }
    end

    def test_zip_arr
        # TODO: error case where block takes more args than ziped objs

        a = CS253Array.new([ 4, 5, 6 ])
        b = CS253Array.new([ 7, 8, 9 ])
        assert_equal [[4, 7], [5, 8], [6, 9]], a.cs253zip(b)
        assert_equal [[1, 4, 7], [2, 5, 8], [3, 6, 9], [4, nil, nil]], @int_arr.cs253zip(a, b)
        assert_equal [[4, 1, 8], [5, 2, nil], [6, nil, nil]], a.cs253zip([1, 2], [8])
        out = []
        assert_nil a.cs253zip(b) { |a, b| out << a + b }
        assert_equal [11, 13, 15], out
        x = CS253Array.new([1, 2])
        y = CS253Array.new([3, 4])
        out = []
        assert_nil x.zip(y, x) { |a, b, c| out << a + b + c }
        assert_equal [5, 8], out
    end

    def test_zip_empty
        assert_equal [], @empty_arr.cs253zip(@int_arr)
    end

    def test_zip_nil
        assert_equal [[1, nil], [2,nil], [3, nil], [4, nil]], @int_arr.cs253zip([])
        assert_equal [[nil, nil], [nil, nil], [nil, nil]], @nil_triple.cs253zip(@nil_arr)
    end

    def test_zip_triple
        assert_equal [[2, "first"], [4, "second"], [6, "third"]], @int_triple.cs253zip(@str_triple)
        assert_equal [["first", 2], ["second", 4], ["third", 6]], @str_triple.cs253zip(@int_triple)
        out = []
        assert_nil @int_triple.cs253zip(@int_range, @int_triple) { |a, b, c| out << a + b }
        assert_equal [2, 5, 8], out
    end

    def test_length_arr
        assert_equal 4, @int_arr.cs253length
    end

    def test_length_empty
        assert_equal 0, @empty_arr.cs253length
    end

    def test_length_triple
        assert_equal 3, @nil_triple.cs253length
    end

end
