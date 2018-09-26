require 'minitest/autorun'
require './cs253Array.rb'
require './triple.rb'

class CS253EnumTests < Minitest::Test
    def test_all?
        arr = [1, 3, 5, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253all? {|e| e>5}, arr.all? {|e| e>5}
        arr = [1, 3, 5, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253all? {|e| e>0}, arr.all? {|e| e>0}
        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253all? {|e| e.length <= 6}, arr.all? {|e| e.length <= 6}
    end

    def test_any?
        arr = [1, 3, 5, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253any? {|e| e>5},true
        arr = [1, 3, 5, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253any? {|e| e>8}, false
        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253any? {|e| e.length <= 3}, true
    end

    def test_chunk
        arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253chunk {|n| n.even?}, arr.chunk{|n| n.even?}.to_a

        arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253chunk {|n| n.odd?}, arr.chunk{|n| n.odd?}.to_a

        arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253chunk {|n| n > 5}, arr.chunk{|n| n > 5}.to_a

    end

    def test_chunk_while
        arr = [1,2,4,9,10,11,12,15,16,19,20,21]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253chunk_while {|i, j| i+1 == j}, arr.chunk_while {|i, j| i+1 == j}.to_a

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253chunk_while {|i, j| i.length+1 == j.length}, arr.chunk_while {|i, j| i.length+1 == j.length}.to_a

        arr = ["Oh"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253chunk_while {|i, j| i.length+1 == j.length}, arr.chunk_while {|i, j| i.length+1 == j.length}.to_a
    end

    def test_collect
        arr = CS253Array.new([1, 3, 5, 7])
        assert_equal arr.cs253collect {|e| 2*e}.to_a, [2, 6, 10, 14]

        arr = CS253Array.new(["Oh", "you", "really", "dance"])
        assert_equal arr.cs253collect {|e| e.length}.to_a, [2, 3, 6, 5]

        arr = CS253Array.new([[1, 3], [2, 4]])
        assert_equal arr.cs253collect {|e| e.max}.to_a, [3, 4]
    end

    def test_collect_concat
        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253collect_concat {|e| [e, -e]}, arr.collect_concat {|e| [e, -e]}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253collect_concat {|e| [e.length]}.to_a, arr.collect_concat {|e| [e.length]}.to_a

        arr = [[1, 3], [2, 4]]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253collect_concat {|e| e + [100]}, arr.collect_concat {|e| e + [100]}
    end

    def test_count
        arr = [nil, nil, 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253count(nil), arr.count(nil)

        arr = [nil, nil, 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253count {|e| e == nil}, arr.count {|e| e == nil}

        arr = [1, 2, 4, 2]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253count {|e| e%2 == 0}, arr.count {|e| e%2 == 0}
    end

    def test_cycle
        int_triple = CS253Array.new([1, 3, 5, 3])
        str_triple = CS253Array.new(['a', 'b', 'c'])
        float_triple = CS253Array.new([1.2, 1.3, 2.3])
        nil_triple = CS253Array.new([])

        cs_res, res = [], []; int_triple.cs253cycle(3){|i| cs_res << i}; int_triple.cycle(3){|i| res << i}; assert_equal cs_res, res
        cs_res, res = [], []; str_triple.cs253cycle(2){|i| cs_res << i.length}; str_triple.cycle(2){|i| res << i.length}; assert_equal cs_res, res
        cs_res, res = [], []; float_triple.cs253cycle(4){|i| cs_res << i.round}; float_triple.cycle(4){|i| res << i.round}; assert_equal cs_res, res
        cs_res, res = [], []; nil_triple.cs253cycle(2){|i| cs_res << i}; nil_triple.cycle(2){res << i}; assert_equal cs_res, res
    end

    def test_detect
        arr = [nil, nil, 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253detect {|e| e==2}, arr.detect(){|e| e==2}

        arr = [1, 2, 1, 4]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253detect {|e| e%2 == 0}, arr.detect {|e| e%2 == 0}

        arr = [1, 2, 1, 4]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253detect {|e| e%3 == 0}, arr.detect {|e| e%3 == 0}
    end

    def test_drop
        arr = [nil, nil, 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253drop(3), arr.drop(3)

        arr = [1, 2, 1, 4]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253drop(3), arr.drop(3)

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253drop(3), arr.drop(3)
    end

    def test_drop_while
        arr = [nil, nil, 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253drop_while{|e| e}, arr.drop_while{|e| e}

        arr = [1, 2, 1, 4]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253drop_while{|i| i < 3}, arr.drop_while{|i| i < 3}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253drop_while{|i| i.length < 1}, arr.drop_while{|i| i.length < 1}
    end

    def test_each_cons
        arr = [1, 2, 1, 4]
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_cons(2){|i| testarr << i}
        arr.each_cons(2){|i| actarr << i}
        assert_equal testarr, actarr


        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_cons(2){|i| testarr << i}
        arr.each_cons(2){|i| actarr << i}
        assert_equal testarr, actarr


        arr = []
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_cons(2){|i| testarr << i}
        arr.each_cons(2){|i| actarr << i}
        assert_equal testarr, actarr
    end

    def test_each_entry
        cscarr = Triple.new(1, 2, 3)
        testarr = []
        actarr = []
        cscarr.cs253each_entry{|e| testarr << e}
        cscarr.each_entry{|e| actarr << e}

        assert_equal testarr, actarr

        cscarr = Triple.new("go", nil, 3)
        testarr = []
        actarr = []
        cscarr.cs253each_entry{|e| testarr << e}
        cscarr.cs253each_entry{|e| actarr << e}
        assert_equal testarr, actarr

        cscarr = Triple.new
        testarr = []
        actarr = []
        cscarr.cs253each_entry{|e| testarr << e}
        cscarr.cs253each_entry{|e| actarr << e}
        assert_equal testarr, actarr
    end

    def test_each_slice
        arr = [1, 2, 1, 4]
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_slice(2){|i| testarr << i}
        arr.each_slice(2){|i| actarr << i}
        assert_equal testarr, actarr


        arr = [nil, 2, true, "really", "dance"]
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_slice(2){|i| testarr << i}
        arr.each_slice(2){|i| actarr << i}
        assert_equal testarr, actarr


        arr = []
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_slice(2){|i| testarr << i}
        arr.each_slice(2){|i| actarr << i}
        assert_equal testarr, actarr
    end

    def test_each_with_index
        # it return an enum, so we return a array with the same return?
        arr = [nil, true, "hello", 1]
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_with_index{|e, i| testarr << [e, i]}
        arr.each_with_index{|e, i| actarr << [e, i]}
        assert_equal  testarr, actarr

        arr = [3, 4, 2, 1]
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_with_index{|e, i| testarr << e*i}
        arr.each_with_index{|e, i| actarr << e*i}
        assert_equal  testarr, actarr

        arr = []
        cscarr = CS253Array.new(arr)
        testarr = []
        actarr = []
        cscarr.cs253each_with_index{|e, i| testarr << e*i}
        arr.each_with_index{|e, i| actarr << e*i}
        assert_equal  testarr, actarr
    end

    def test_each_with_object
        arr = [nil, true, "hello", 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253each_with_object([]){|e, memo| memo << e}, arr.each_with_object([]){|e, memo| memo << e}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253each_with_object([]){|e, memo| memo << e}, arr.each_with_object([]){|e, memo| memo << e}

        arr = [1, 3, 6, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253each_with_object([]){|e, memo| memo << e}, arr.each_with_object([]){|e, memo| memo << e}

        assert_equal cscarr.cs253each_with_object({:sum => 0}) {|i, hsh| hsh[:sum] += i}, arr.each_with_object({:sum => 0}) {|i, hsh| hsh[:sum] += i}
    end

    def test_entries
        arr = [nil, true, "hello", 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253entries, arr.entries

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253entries, arr.entries

        arr = (1..5).to_a
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253entries, arr.entries
    end

    def test_find
        arr = [nil, nil, 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find {|e| e==2}, arr.find {|e| e==2}

        arr = [1, 2, 1, 4]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find {|e| e%2 == 0}, arr.find {|e| e%2 == 0}

        arr = [1, 2, 1, 4]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find {|e| e%3 == 0}, arr.find {|e| e%3 == 0}
    end

    def test_find_all
        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find_all{|e| e==2}, arr.find_all{|e| e==2}

        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find_all {|e| e != nil}, arr.find_all {|e| e != nil}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find_all {|e| e%3 == 0}, arr.find_all {|e| e%3 == 0}
    end


    def test_find_index
        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find_index{|e| e==2}, arr.find_index{|e| e==2}

        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find_index{|e| e==true}, arr.find_index{|e| e==true}

        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253find_index(nil), arr.find_index(nil)
    end

    def test_first
        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253first(5), arr.first(5)

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253first(3), arr.first(3)

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253first, arr.first
    end

    def test_flat_map
        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253flat_map {|e| [e, -e]}, arr.flat_map {|e| [e, -e]}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253flat_map {|e| [e.length]}.to_a, arr.flat_map {|e| [e.length]}.to_a

        arr = [[1, 3], [2, 4]]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253flat_map {|e| e + [100]}, arr.flat_map {|e| e + [100]}
    end

    def test_grep
        arr = (1..10).to_a
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253grep(2..5) {|e| [e, -e]}, arr.grep(2..5) {|e| [e, -e]}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253grep("really") {|e| e.length}.to_a, arr.grep("really") {|e| e.length}

        arr = [[1, 3], [2, 4], 3]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253grep([1, 3]) {|e| e}, arr.grep([1, 3]) {|e| e}
    end

    def test_grep_v
        arr = (1..10).to_a
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253grep_v(0..5) {|e| [e, -e]}, arr.grep_v(0..5) {|e| [e, -e]}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253grep_v("really") {|e| e.length}, arr.grep_v("really") {|e| e.length}

        arr = [[1, 3], [2, 4], 3]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253grep([1, 3]) {|e| e}, arr.grep([1, 3]) {|e| e}
    end

    def test_group_by
        arr = (1..10).to_a
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253group_by {|e| e%3}, arr.group_by {|e| e%3}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253group_by {|e| e.length}, arr.group_by {|e| e.length}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253group_by {|e| e.length}, arr.group_by {|e| e.length}
    end

    def test_include
        arr = [1, 3, 5, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253include?(3) , arr.include?(3)
        arr = [[1, 3], [5, 7]]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253include?([1, 3]), arr.include?([1, 3])
        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253include?(""), arr.include?("")
    end

    def test_inject
        arr = CS253Array.new([1, 3, 5, 7])
        assert_equal arr.cs253inject() {|sum, n| sum + n}, 16
        arr = CS253Array.new([1, 3, 5, 7])
        assert_equal arr.cs253inject(1) {|product, n| product * n}, 105
        longest = CS253Array.new(%w{ Oh you really dance }).cs253inject do |memo, word|
            memo.length > word.length ? memo : word
        end
        assert_equal longest, "really"
    end

    def test_map
        arr = CS253Array.new([1, 3, 5, 7])
        assert_equal arr.cs253map {|e| 2*e}.to_a, [2, 6, 10, 14]

        arr = CS253Array.new(["Oh", "you", "really", "dance"])
        assert_equal arr.cs253map {|e| e.length}.to_a, [2, 3, 6, 5]

        arr = CS253Array.new([[1, 3], [2, 4]])
        assert_equal arr.cs253map {|e| e.max}.to_a, [3, 4]
    end

    def test_max
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253max {|a, b| a <=> b}, arr.max {|a, b| a <=> b}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253max {|a, b| a <=> b}, arr.max {|a, b| a <=> b}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253max(3) {|a, b| a.length <=> b.length}, arr.max(3) {|a, b| a.length <=> b.length}
    end

    def test_max_by
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253max_by {|a| a}, arr.max_by {|a| a}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253max_by {|a| a}, arr.max_by {|a| a}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253max_by(3) {|a| a.length}, arr.max_by(3) {|a| a.length}
    end

    def test_member?
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253member?(1), arr.member?(1)

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253member?(1), arr.member?(1)

        arr = ["Oh", nil, 3, [1]]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253member?(nil), arr.member?(nil)
    end

    def test_min
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253min {|a, b| a <=> b}, arr.min {|a, b| a <=> b}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253min {|a, b| a <=> b}, arr.min {|a, b| a <=> b}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253min(3) {|a, b| a <=> b}, arr.min(3) {|a, b| a <=> b}
    end

    def test_min_by
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253min_by {|a| a }, arr.min_by {|a| a }

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253min_by {|a| a }, arr.min_by {|a| a }

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253min_by(3) {|a| a }, arr.min_by(3) {|a| a }
    end

    def test_minmax
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253minmax {|a, b| a <=> b}, arr.minmax {|a, b| a <=> b}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253minmax {|a, b| a <=> b}, arr.minmax {|a, b| a <=> b}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253minmax {|a, b| a <=> b}, arr.minmax {|a, b| a <=> b}
    end

    def test_minmax_by
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253minmax_by {|a| a }, arr.minmax_by{|a| a }

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253minmax_by {|a| a }, arr.minmax_by{|a| a }

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253minmax_by {|a| a }, arr.minmax_by{|a| a }
    end

    def test_none?
        arr = [1, 3, 5, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253none? {|e| e > 5},arr.none? {|e| e > 5}
        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253none? {|e| e > 5},arr.none? {|e| e > 5}
        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253none? {|e| e.length <= 3}, arr.none? {|e| e.length <= 3}
    end

    def test_one?
        arr = [1, 3, 5, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253one? {|e| e > 5},arr.one? {|e| e > 5}
        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253one? {|e| e > 5},arr.one? {|e| e > 5}
        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253one? {|e| e.length <= 3}, arr.one? {|e| e.length <= 3}
    end

    def test_partition
        arr = [1, 3, 5, 7]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253partition {|e| e > 5},arr.partition {|e| e > 5}
        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253partition {|e| e > 5},arr.partition {|e| e > 5}
        arr = []
        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253partition {|e| e.length <= 3}, arr.partition {|e| e.length <= 3}
    end

    def test_reduce
        arr = CS253Array.new([1, 3, 5, 7])
        assert_equal arr.cs253reduce() {|sum, n| sum + n}, 16
        arr = CS253Array.new([1, 3, 5, 7])
        assert_equal arr.cs253reduce(1) {|product, n| product * n}, 105
        longest = CS253Array.new(%w{ Oh you really dance }).cs253reduce do |memo, word|
            memo.length > word.length ? memo : word
        end
        assert_equal longest, "really"
    end

    def test_reject
        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253reject{|e| e==2}, arr.reject{|e| e==2}

        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253reject {|e| e != nil}, arr.reject {|e| e != nil}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253reject {|e| e%3 == 0}, arr.reject {|e| e%3 == 0}
    end

    def test_reverse_each
        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        arr1 = []
        arr2 = []
        cscarr.cs253reverse_each{|e| arr1 << e}
        arr.reverse_each{|e| arr2 << e}
        assert_equal arr1, arr2

        arr = [2, 3, 1, 4]
        cscarr = CS253Array.new(arr)
        arr1 = []
        arr2 = []
        cscarr.cs253reverse_each {|e| e + 1}
        arr.reverse_each {|e| e + 1}.to_a
        assert_equal arr1, arr2

        arr = [2, 3, 1, 4]
        cscarr = CS253Array.new(arr)
        arr1 = []
        arr2 = []
        cscarr.cs253reverse_each {|e| e + 1}
        arr.reverse_each {|e| e + 1}.to_a
        assert_equal arr1, arr2
    end

    def test_slice_after
        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_after{|e| e == "you"}, arr.slice_after{|e| e == "you"}.to_a

        arr = [2, 3, 1, 4, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_after{|e| e%2 == 0}, arr.slice_after{|e| e%2 == 0}.to_a

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_after{|e| e%2 == 0}, arr.slice_after{|e| e%2 == 0}.to_a
    end

    def test_slice_before
        arr = [nil, true, 1, "you"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_before{|e| e == "you"}, arr.slice_before{|e| e == "you"}.to_a

        arr = [2, 3, 1, 4, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_before{|e| e%2 == 0}, arr.slice_before{|e| e%2 == 0}.to_a

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_before{|e| e%2 == 0}, arr.slice_before{|e| e%2 == 0}.to_a
    end

    def test_slice_when
        arr = [1,2,4,9,10,11,12,15,16,19,20,21]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_when {|i, j| i+1 == j}, arr.slice_when {|i, j| i+1 == j}.to_a

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_when {|i, j| i.length+1 == j.length}, arr.slice_when {|i, j| i.length+1 == j.length}.to_a

        arr = ["Oh"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253slice_when {|i, j| i.length+1 == j.length}, arr.slice_when {|i, j| i.length+1 == j.length}.to_a
    end

    def test_sort
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sort {|a, b| b <=> a}, arr.sort {|a, b| b <=> a}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sort {|a, b| b <=> a}, arr.sort {|a, b| b <=> a}

        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sort {|a, b| a - b <=> a}, arr.sort {|a, b| a - b <=> a}
    end

    def test_sort_by
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sort_by {|a| a}, arr.sort_by {|a| a}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sort_by {|a| a}, arr.sort_by {|a| a}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sort_by {|a| a.length}, arr.sort_by {|a| a.length}
    end

    def test_sum
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sum {|a| a}, 16

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sum {|a| a*2}, 0

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253sum {|a| a.length}, 16
    end

    def test_take
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253take(3) , arr.take(3)

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253take(4) , arr.take(4)

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253take(4) , arr.take(4)
    end

    def test_take_while
        arr = [3, 1, 7, 5]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253take_while {|i| i%3 == 2} , arr.take_while {|i| i%3 == 2}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253take_while {|i| i%3 == 2} , arr.take_while {|i| i%3 == 2}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253take_while {|i| i.length%3 == 2} , arr.take_while {|i| i.length%3 == 2}
    end

    def test_to_h
        arr = [[1, 3], [2, 4]]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253to_h , arr.to_h

        arr = [[44, 3], [2, 4]]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253to_h , arr.to_h

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253take_while {|i| i.length%3 == 2} , arr.take_while {|i| i.length%3 == 2}
    end

    def test_to_a
        arr = Triple.new(1, 2, 3)
        cscarr = Triple.new(1, 2, 3)
        assert_equal cscarr.cs253to_a, arr.to_a


        arr = Triple.new("go", nil, 3)
        cscarr = Triple.new("go", nil, 3)
        assert_equal cscarr.cs253to_a, arr.to_a

        arr = Triple.new
        cscarr = Triple.new
        assert_equal cscarr.cs253to_a, arr.to_a
    end

    def test_uniq
        arr = [3, 1, 7, 5, 4, 3, 5, 2, 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253uniq{|e| e} , arr.uniq{|e| e}

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253uniq{|e| e} , arr.uniq{|e| e}

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253uniq{|e| e.length%2} , arr.uniq{|e| e.length%2}
    end

    def test_zip
        arr = [nil, true, 1, "you"]
        b = [2, 3, 4]
        c = [1, "fuck"]
        res1 = []
        res2 = []
        cscarr = CS253Array.new(arr)
        cscarr.cs253zip(b, c){|e| res1 << e}
        arr.zip(b, c){|e| res2 << e}
        assert_equal res1, res2

        arr = [nil, true, 1, "you"]
        b = []
        res1 = []
        res2 = []
        cscarr = CS253Array.new(arr)
        cscarr.cs253zip(b){|e| res1 << e}
        arr.zip(b){|e| res2 << e}
        assert_equal res1, res2

        arr = [nil, true, 1, "you"]
        res1 = []
        res2 = []
        cscarr = CS253Array.new(arr)
        cscarr.cs253zip{|e| res1 << e}
        arr.zip{|e| res2 << e}
        assert_equal res1, res2
    end

    def test_length
        arr = [3, 1, 7, 5, 4, 3, 5, 2, 1]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253length, arr.length

        arr = []
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253length, arr.length

        arr = ["Oh", "you", "really", "dance"]
        cscarr = CS253Array.new(arr)
        assert_equal cscarr.cs253length, arr.length
    end

end

