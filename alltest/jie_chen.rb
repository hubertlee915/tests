require 'minitest/autorun'
require './cs253Array.rb'

class CS253EnumTests < Minitest::Test

    def test_cs253collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253collect{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.cs253collect{|i| i.length}.to_a,[6,13,10]
    end

    def test_cs253collect_concat
        assert_equal CS253Array.new([[1, 2], [3, 4]]).cs253collect_concat { |e| e + [100] }.to_a, [1,2,100,3,4,100]
        assert_equal CS253Array.new((1..4).to_a).cs253collect_concat { |e| [e, -e] }.to_a, [1, -1, 2, -2, 3, -3, 4, -4]
    end

    def test_cs253all?
        assert_equal CS253Array.new(["ant", "bear", "cat"]).cs253all? {|word| word.length >= 3}, true
        assert_equal CS253Array.new(["ant", "bear", "cat"]).cs253all? {|word| word.length >= 4}, false
        assert_equal CS253Array.new().cs253all?, true
    end

    def test_cs253any?
        assert_equal CS253Array.new(["ant", "bear", "cat"]).cs253any? {|word| word.length >= 3}, true
        assert_equal CS253Array.new(["ant", "bear", "cat"]).cs253any? {|word| word.length >= 4}, true
        assert_equal CS253Array.new().cs253any?, false
    end

    def test_cs253chunk
        assert_equal CS253Array.new([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]).chunk {|n| n.even?}.to_a, \
        [[false, [3, 1]], [true, [4]], [false, [1, 5, 9]], [true, [2, 6]], [false, [5, 3, 5]]]
    end

    def test_cs253chunk_while
        assert_equal CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21]).chunk_while {|i, j| i+1 == j }.to_a, \
        [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]]
    end
    def test_cs253inject
        int_array_add = CS253Array.new(6) {|e| e+5}
        int_array_mul = CS253Array.new([5,6,7,8,9,10])
        str_array = CS253Array.new(["Have", "a", "wonderful", "day", "!"])

        assert_equal int_array_add.cs253inject{|sum, n| sum+n}, 45
        assert_equal int_array_mul.cs253inject(1){|product, n| product*n}, 151200
        assert_equal str_array.cs253inject{|s, w| s+' '+w}, "Have a wonderful day !"
    end

    def test_cs253count
        assert_equal CS253Array.new([1, 2, 4, 2]).cs253count(2), 2
        assert_equal CS253Array.new([1, 2, 4, 2]).cs253count() {|x| x%2==0}, 3
    end

    # [unfinished] cannot infinite loop
    def test_cs253cycle
        #assert_equal CS253Array.new(["a", "b", "c"]).cs253cycle(2) { |x| x }.to_a, ["a", "b", "c", "a", "b", "c"]
        #assert_equal CS253Array.new(["a", "b", "c"]).cs253cycle(0) { |x| puts x }.to_a, []
        #assert_equal CS253Array.new().cs253cycle(3) { |x| puts x }.to_a, []
        assert_equal CS253Array.new(["a", "b", "c"]).cs253cycle(2) { |x| x }, nil
        assert_equal CS253Array.new(["a", "b", "c"]).cs253cycle(0) { |x| puts x }, nil
        assert_equal CS253Array.new().cs253cycle(3) { |x| puts x }, nil
    end

    def test_cs253detect
        assert_equal CS253Array.new((1..100).to_a).cs253detect() { |i| i % 5 == 0 and i % 7 == 0}, 35
        #assert_equal CS253Array.new((1..10).to_a).cs253detect(4) {|i| i % 5 == 0 and i % 7 == 0}, 4
        assert_equal CS253Array.new((1..10).to_a).cs253detect() {|i| i % 5 == 0 and i % 7 == 0}, nil
    end

    def test_cs253drop
        assert_equal CS253Array.new([1, 2, 3, 4, 5, 0]).cs253drop(3).to_a, [4,5,0]
        assert_equal CS253Array.new([7,8,9,10]).cs253drop(3).to_a, [10]
    end

    def test_cs253drop_while
        assert_equal CS253Array.new([1, 2, 3, 4, 5, 0]).cs253drop_while {|i| i < 3}.to_a, [3,4,5,0]
    end

    def test_cs253each_cons
        #assert_equal CS253Array.new((1..10).to_a).cs253each_cons(3) { |a| a }, [[1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6], \
        #[5, 6, 7], [6, 7, 8], [7, 8, 9], [8, 9, 10]]
        assert_equal CS253Array.new((1..10).to_a).cs253each_cons(3) { |a| a }, nil
    end

    def test_cs253each_slice
        #assert_equal CS253Array.new((1..10).to_a).cs253each_slice(3) { |a| a }, [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]
        assert_equal CS253Array.new((1..10).to_a).cs253each_slice(3) { |a| a }, nil
        assert_equal CS253Array.new((1..10).to_a).cs253each_slice(0) { |a| a }, nil
    end

    def test_cs253each_with_index
        ret_item = []
        ret_idx = []
        CS253Array.new((1..5).to_a).cs253each_with_index() do |item, idx|
            ret_item << item
            ret_idx << idx
        end
        assert_equal ret_item, [1,2,3,4,5]
        assert_equal ret_idx, [0,1,2,3,4]
    end

    def test_cs253each_with_object
        assert_equal CS253Array.new((1..10).to_a).cs253each_with_object([]) {|i, a| a << i*2}, [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
    end

    def test_cs253entries
        assert_equal CS253Array.new([1,2,3,4]).cs253entries, [1, 2, 3, 4]
        assert_equal CS253Array.new(%w[a b c d]).cs253entries, ["a","b","c","d"]
    end

    def test_cs253find
        assert_equal CS253Array.new((1..100).to_a).cs253find() { |i| i % 5 == 0 and i % 7 == 0}, 35
        #assert_equal CS253Array.new((1..10).to_a).cs253find(4) {|i| i % 5 == 0 and i % 7 == 0}, 4
        assert_equal CS253Array.new((1..10).to_a).cs253find() {|i| i % 5 == 0 and i % 7 == 0}, nil
    end

    def test_cs253find_all
        assert_equal CS253Array.new((1..10).to_a).cs253find_all {|i|  i % 3 == 0}, [3, 6, 9]
        assert_equal CS253Array.new([1,2,3,4,5]).cs253find_all {|num|  num.even?}, [2, 4]
    end

    def test_cs253find_index
        assert_equal CS253Array.new((1..10).to_a).cs253find_index  { |i| i % 5 == 0 and i % 7 == 0 }, nil
        assert_equal CS253Array.new((1..100).to_a).cs253find_index { |i| i % 5 == 0 and i % 7 == 0 }, 34
        assert_equal CS253Array.new((1..100).to_a).cs253find_index(50), 49
    end

    def test_cs253first
        assert_equal CS253Array.new(%w[foo bar baz]).cs253first, "foo"
        assert_equal CS253Array.new(%w[foo bar baz]).cs253first(2), ["foo", "bar"]
        assert_equal CS253Array.new(%w[foo bar baz]).cs253first(100), ["foo", "bar", "baz"]
        assert_equal CS253Array.new().cs253first, nil
        assert_equal CS253Array.new().cs253first(3), []
    end

    def test_cs253flat_map
        assert_equal CS253Array.new([1, 2, 3, 4]).cs253flat_map {|e| [e, -e]}, [1, -1, 2, -2, 3, -3, 4, -4]
        assert_equal CS253Array.new([[1, 2], [3, 4]]).cs253flat_map {|e| e + [100]}, [1, 2, 100, 3, 4, 100]
    end

    def test_cs253grep
        assert_equal CS253Array.new([1, 2, 3, 4]).cs253grep(2..4) {|e| e}, [2,3,4]
    end

    def test_cs253grep_v
        assert_equal CS253Array.new([1, 2, 3, 4]).cs253grep_v(2..4) {|e| e}, [1]
        assert_equal CS253Array.new((1..10).to_a).cs253grep_v(2..5) {|v| v * 2}, [2, 12, 14, 16, 18, 20]
    end

    def test_cs253group_by
        assert_equal CS253Array.new((1..6).to_a).cs253group_by {|i| i%3}, {1=>[1, 4], 2=>[2, 5], 0=>[3, 6]}
    end

    def test_cs253include?
        assert_equal CS253Array.new((1..6).to_a).cs253include?(0), false
        assert_equal CS253Array.new((1..6).to_a).cs253include?(1), true
    end

    def test_cs253map
        assert_equal CS253Array.new((1..4).to_a).cs253map {|i| i*i}, [1, 4, 9, 16]
        assert_equal CS253Array.new((1..4).to_a).cs253map {"a"}, ["a","a","a","a"]
    end

    def test_cs253max
        assert_equal CS253Array.new((1..6).to_a).cs253max(2) {|a, b| a<=>b}, [6,5]
        assert_equal CS253Array.new(%w[albatross dog horse]).cs253max(2) {|a, b| a.length <=> b.length}, ["albatross", "horse"]
        assert_equal CS253Array.new([3,3,3,3]).cs253max(3) {|a, b| a<=>b}, [3,3,3]
    end

    def test_cs253max_by
        assert_equal CS253Array.new((1..6).to_a).cs253max_by(2) {|a| a}, [6,5]
        assert_equal CS253Array.new(%w[albatross dog horse]).cs253max_by(2) {|a| a.length}, ["albatross", "horse"]
        assert_equal CS253Array.new([3,3,3,3]).cs253max_by(3) {|a| a}, [3,3,3]
    end

    def test_cs253member?
        assert_equal CS253Array.new((1..6).to_a).cs253member?(0), false
        assert_equal CS253Array.new((1..6).to_a).cs253member?(1), true
    end

    def test_cs253min
        assert_equal CS253Array.new((1..6).to_a).cs253min(2) {|a, b| a<=>b}, [1,2]
        assert_equal CS253Array.new().cs253min(2) {|a, b| a<=>b}, nil
        assert_equal CS253Array.new((1..6).to_a).cs253min() {|a, b| a<=>b}, 1
        assert_equal CS253Array.new(%w[albatross dog horse]).cs253min(2) {|a, b| a.length <=> b.length}, ["dog", "horse"]
        assert_equal CS253Array.new([3,3,3,3]).cs253min(3) {|a, b| a<=>b}, [3,3,3]
    end

    def test_cs253min_by
        assert_equal CS253Array.new((1..6).to_a).cs253min_by(2) {|a| a}, [1,2]
        assert_equal CS253Array.new(%w[albatross dog horse]).cs253min_by(2) {|a| a.length}, ["dog", "horse"]
        assert_equal CS253Array.new([3,3,3,3]).cs253min_by(3) {|a| a}, [3,3,3]
    end

    def test_cs253minmax
        assert_equal CS253Array.new((1..6).to_a).cs253minmax {|a, b| a<=>b}, [1,6]
        assert_equal CS253Array.new(%w[albatross dog horse]).cs253minmax {|a, b| a.length <=> b.length}, ["dog", "albatross"]
        assert_equal CS253Array.new([3,3,3,3]).cs253minmax {|a, b| a<=>b}, [3,3]
    end

    def test_cs253minmax_by
        assert_equal CS253Array.new((1..6).to_a).cs253minmax_by {|a| a}, [1,6]
        assert_equal CS253Array.new(%w[albatross dog horse]).cs253minmax_by {|a| a.length}, ["dog", "albatross"]
        assert_equal CS253Array.new([3,3,3,3]).cs253minmax_by {|a| a}, [3,3]
    end

    def test_cs253none?
        assert_equal CS253Array.new(%w{ant bear cat}).cs253none? {|word| word.length == 5}, true
        assert_equal CS253Array.new(%w{ant bear cat}).cs253none? {|word| word.length > 3}, false
    end

    def test_cs253one?
        assert_equal CS253Array.new(%w{ant bear cat}).cs253one? {|word| word.length == 5}, false
        assert_equal CS253Array.new(%w{ant bear cat}).cs253one? {|word| word.length <4}, false
        assert_equal CS253Array.new(%w{ant bear cat}).cs253one? {|word| word.length > 3}, true
    end

    def test_cs253partition
        assert_equal CS253Array.new((1..6).to_a).cs253partition { |v| v.even? }, [[2, 4, 6], [1, 3, 5]]
    end

    def test_cs253reduce
        assert_equal CS253Array.new((5..10).to_a).cs253reduce(:+), 45
        #assert_equal CS253Array.new((5..10).to_a).cs253reduce(1, :*), 151200
    end

    def test_cs253reject
        assert_equal CS253Array.new((5..10).to_a).cs253reject {|i|  i % 3 == 0}, [5, 7, 8, 10]
        assert_equal CS253Array.new([1, 2, 3, 4, 5]).cs253reject { |num| num.even? }, [1, 3, 5]
    end

    def test_cs253reverse_each
        assert_equal CS253Array.new((1..3).to_a).cs253reverse_each {|v| p v}, [3,2,1]
    end

    def test_cs253select
        assert_equal CS253Array.new((1..10).to_a).cs253select {|i|  i % 3 == 0}, [3, 6, 9]
        assert_equal CS253Array.new([1,2,3,4,5]).cs253select {|num|  num.even?}, [2, 4]
    end

    def test_cs253sum
        assert_equal CS253Array.new((1..10).to_a).cs253sum {|v| v * 2 }, 110
    end

    def test_cs253take
        assert_equal CS253Array.new([1, 2, 3, 4, 5, 0]).cs253take(3), [1, 2, 3]
        assert_equal CS253Array.new([1, 2, 3, 4, 5, 0]).cs253take(30), [1, 2, 3, 4, 5, 0]
    end

    def test_cs253take_while
        assert_equal CS253Array.new([1, 2, 3, 4, 5, 0]).cs253take_while() {|i| i < 3}, [1, 2]
    end

    def test_cs253to_a
        assert_equal CS253Array.new((1..3).to_a).cs253to_a, [1,2,3]
    end

    def test_cs253uniq
        assert_equal CS253Array.new([2,2,2,3]).cs253uniq {|e| e}, [2,3]
    end

    def test_cs253length
        assert_equal CS253Array.new([2,2,2,3]).cs253length, 4
        assert_equal CS253Array.new().cs253length, 0
    end
end


