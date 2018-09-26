require 'minitest/autorun'
require './triple.rb'
require './cs253Array.rb'


class CS253Array < Array
    include CS253Enumerable
end

class Range
    include CS253Enumerable
end

class CS253EnumTests < Minitest::Test

    def test_cs253collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253collect{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.cs253collect{|i| i.length}.to_a,[6,13,10]
    end

    def test_cs253all?
        assert %w[ant bear cat].cs253all? { |word| word.length >= 3 } == true
        assert %w[ant bear cat].cs253all? { |word| word.length >= 4 } == false
        assert [4,6,9].cs253all? { |v| v % 2 == 0 } == false
    end

    def test_cs253any?
        assert %w[ant bear cat].any? { |word| word.length >= 3 }
        assert %w[ant bear cat].any? { |word| word.length >= 4 }
        assert [nil, true, 99].any?
    end

    def test_cs253chunk
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253chunk {|n| n.even?}, arr.chunk{|n| n.even?}.to_a

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253chunk {|n| n > 3}, arr.chunk{|n| n > 3}.to_a

        arr = [1,2,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253chunk {|n| n.odd?}, arr.chunk{|n| n.odd?}.to_a

    end

    def test_cs253chunk_while
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253chunk_while {|i, j| i+1 == j}, arr.chunk_while {|i, j| i+1 == j}.to_a

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253chunk_while {|i, j| i % j == 0}, arr.chunk_while {|i, j| i % j == 0}.to_a

        arr = [1,2,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253chunk_while {|i,j| i-j*2 == 0}, arr.chunk_while {|i,j| i-j*2 == 0}.to_a
    end

    def test_cs253collect_concat
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253collect_concat {|e| [e, e+1, e+2]}, arr.collect_concat {|e| [e, e+1, e+2]}

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253collect_concat {|e| [e, -e]}, arr.collect_concat {|e| [e, -e]}

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253collect_concat {|e| [e, e*2]}, arr.collect_concat {|e| [e, e*2]}

    end

    def test_cs253count
        arr = [1, 2, 3, 4, 5, 6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253count {|v| v%2 == 0}, arr.count {|v| v%2 == 0}

        arr = [0, nil, 1]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253count(nil), arr.count(nil)

        arr = [0, nil, 1]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253count {|v| v != nil}, arr.count {|v| v != nil}
    end

    def test_cs253cycle
        arr = ['a','b','c']
        e_arr = []
        e_arr2 = []
        arr.cs253cycle(3){|v| e_arr << v}
        arr.cycle(3){|v| e_arr2 << v}
        assert_equal e_arr, e_arr2

        e_arr.clear
        e_arr2.clear
        arr = [1,2,3]

        arr.cs253cycle(2){|v| e_arr << v}
        arr.cycle(2){|v| e_arr2 << v}
        assert_equal e_arr, e_arr2

        e_arr.clear
        e_arr2.clear
        arr = ["ay","bee","****"]

        arr.cs253cycle(6){|v| e_arr << v}
        arr.cycle(6){|v| e_arr2 << v}
        assert_equal e_arr, e_arr2

    end

    def test_cs253detect

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253detect {|v| v%2==0 and v%3==0}, arr.detect(){|v| v%2==0 and v%3==0}

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253detect {|v| v==5}, arr.detect(){|v| v==5}

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253detect {|v| v==7}, arr.detect(){|v| v==7}

    end

    def test_cs253drop
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253drop(2), arr.drop(2)

        arr = ["a","b","c"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253drop(3), arr.drop(3)

        arr = ["a","b","c"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253drop(1), arr.drop(1)
    end

    def test_cs253drop_while
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253drop_while{|v| v%2==0}, arr.drop_while{|v| v%2==0}

        arr = ["a","a","c"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253drop_while{|v| v=="a"}, arr.drop_while{|v| v=="a"}

        arr = ["ca","ba","c"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253drop_while{|v| v.length > 1}, arr.drop_while{|v| v.length > 1}
    end

    def test_cs253each_cons

        arr = [1]
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_cons(2){|i| t_arr << i}
        arr.each_cons(2){|i| r_arr << i}
        assert_equal t_arr, r_arr

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_cons(2){|i| t_arr << i}
        arr.each_cons(2){|i| r_arr << i}
        assert_equal t_arr, r_arr

        arr = ["a","b","c"]
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_cons(2){|i| t_arr << i}
        arr.each_cons(2){|i| r_arr << i}
        assert_equal t_arr, r_arr

    end

    def test_cs253each_entry

        myarr = []
        t_arr = []
        myarr.cs253each_entry{|e| t_arr << e}
        assert_equal t_arr, myarr

        myarr = [1,2,3]
        t_arr = []
        myarr.cs253each_entry{|e| t_arr << e}
        assert_equal t_arr, myarr

        myarr = ["a","b","c"]
        t_arr = []
        myarr.cs253each_entry{|e| t_arr << e}
        assert_equal t_arr, myarr


    end

    def test_cs253each_slice
        arr = [1, 2, 1, 4]
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_slice(2){|i| t_arr << i}
        arr.each_slice(2){|i| r_arr << i}
        assert_equal t_arr, r_arr


        arr = [nil, 2, true, "really", "dance"]
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_slice(2){|i| t_arr << i}
        arr.each_slice(2){|i| r_arr << i}
        assert_equal t_arr, r_arr


        arr = []
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_slice(2){|i| t_arr << i}
        arr.each_slice(2){|i| r_arr << i}
        assert_equal t_arr, r_arr
    end

    def test_cs253each_with_index

        arr = [1,2,3,4]
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_with_index{|e, i| t_arr << {e:i}}
        arr.each_with_index{|e, i| r_arr << {e:i}}
        assert_equal  t_arr, r_arr

        arr = ["a","b","c"]
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_with_index{|e, i| t_arr << [e, i]}
        arr.each_with_index{|e, i| r_arr << [e, i]}
        assert_equal  t_arr, r_arr

        arr = []
        myarr = CS253Array.new(arr)
        t_arr = []
        r_arr = []
        myarr.cs253each_with_index{|e, i| t_arr << e}
        arr.each_with_index{|e, i| r_arr << e}
        assert_equal  t_arr, r_arr
    end

    def test_cs253each_with_object
        arr = [1,2,3,4]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253each_with_object([]){|v, m| m << v}, arr.each_with_object([]){|v, m| m << v}

        arr = ["a","B","c"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253each_with_object([]){|v, m| m << v}, arr.each_with_object([]){|v, m| m << v}

        arr = [1,2,3,4]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253each_with_object([2]){|v, m| m << v*m[0]}, arr.each_with_object([2]){|v, m| m << v*m[0]}
    end

    def test_cs253entries
        arr = [1,2,3]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253entries, arr.entries

        arr = ["a"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253entries, arr.entries

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253entries, arr.entries

    end

    def test_cs253find
        arr = [0, 1, 1]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find {|v| v==1}, arr.find {|v| v==1}

        arr = [0,1,2]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find {|v| v==2}, arr.find {|v| v==2}

        arr = [nil]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find {|v| v==1}, arr.find {|v| v==1}

    end

    def test_cs253find_all
        arr = [0, 1, 1]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find_all {|v| v==1}, arr.find_all {|v| v==1}

        arr = [0,1,2]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find_all {|v| v==2}, arr.find_all {|v| v==2}

        arr = [nil]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find_all {|v| v==1}, arr.find_all {|v| v==1}
    end


    def test_cs253find_index
        arr = [0,1,2]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find_index {|v| v==2}, arr.find_index {|v| v==2}

        arr = [0,1,2]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find_index {|v| v==3}, arr.find_index {|v| v==3}

        arr = [0,1,2]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253find_index {|v| v%2==0}, arr.find_index {|v| v%2==0}

    end

    def test_cs253first

        arr = [0,1,2,3,4,5,6,7,8,9]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253first, arr.first

        arr = [0,1,2,3,4,5,6,7,8,9]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253first(5), arr.first(5)

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253first, arr.first

    end

    def test_cs253flat_map
        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253flat_map {|e| [e]}, arr.flat_map {|e| [e]}

        arr = [1,2,3,4]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253flat_map {|e| [e,-e]}, arr.flat_map {|e| [e,-e]}

        arr = ["a","b","c","d"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253flat_map {|e| [e.length]}.to_a, arr.flat_map {|e| [e.length]}
    end

    def test_cs253grep
        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253grep("boo"), arr.grep("boo")

        arr = [1,2,3,4]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253grep((1..3)), arr.grep((1..3))

        arr = ["a","ab","c","ad"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253grep(/a/).to_a, arr.grep(/a/)
    end

    def test_cs253grep_v
        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253grep_v("boo"), arr.grep_v("boo")

        arr = [1,2,3,4]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253grep_v((1..3)), arr.grep_v((1..3))

        arr = ["a","ab","c","ad"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253grep_v(/a/).to_a, arr.grep_v(/a/)
    end

    def test_cs253group_by
        arr = [0,1,2,3,4,5,6,7,8,9]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253group_by{|e|e%2==0}, arr.group_by{|e|e%2==0}

        arr = [0,1,2,3,4,5,6,7,8,9]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253group_by{|v| v.odd?}, arr.group_by{|v| v.odd?}

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253group_by{|e|e%2==0}, arr.group_by{|e|e%2==0}
    end

    def test_cs253include
        arr = [0,1,2,3,4,5,6,7,8,9]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253include?(5) , arr.include?(5)

        arr = ["a","b","c","d"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253include?("d"), arr.include?("d")

        arr = [0,1,2,3,4,5,6,7,8,9]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253include?(99), arr.include?(99)

    end

    def test_cs253inject
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253inject() {|sum, n| sum + n}, arr.inject() {|sum, n| sum + n}

        arr = ["a","bb",'ccc',"dddd"]
        myarr = CS253Array.new(arr)
        longest = myarr.cs253inject do |memo, word|
            memo.length > word.length ? memo : word
        end
        assert_equal longest, "dddd"

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253inject(10) {|p, n| p * n}, arr.inject(10) {|p, n| p * n}

    end

    def test_cs253map
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253map {|e| 2*e}, arr.map{|e| 2*e}

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253map {|v| v}, arr.map{|v| v}

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal arr.cs253map {|v| v.even?}, arr.map{|v| v.even?}
    end

    def test_cs253max
        #TODO : FIX MAX METHOD
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253max {|v, x| v <=> x}, arr.max {|v, x| v <=> x}

        arr = ["these","are","words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253max, arr.max

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253max {|v, x| v <=> x}, arr.max {|v, x| v <=> x}
    end

    def test_cs253max_by
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253max_by {|v| v}, arr.max_by {|v| v}

        arr = ["these","are","words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253max_by{|v| v.length}, arr.max_by{|v| v.length}

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253max_by {|v| v.length}, arr.max_by{|v| v.length}
    end

    def test_cs253member?
        arr = [1,2,3]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253member?(1), arr.member?(1)

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253member?(1), arr.member?(1)

        arr = ["a", "aa","aaa"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253member?("aa"), arr.member?("aa")
    end

    def test_cs253min
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253min, arr.min

        arr = ["these","are","words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253min, arr.min

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253min {|v, x| v <=> x}, arr.min {|v, x| v <=> x}
    end

    def test_cs253min_by
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253min_by {|v| v }, arr.min_by {|v| v }

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253min_by {|v| v }, arr.min_by {|v| v }

        arr = ["these","are","words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253min_by(2) {|v| v }, arr.min_by(2) {|v| v }
    end

    def test_cs253minmax_by
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253minmax_by {|v| v }, arr.minmax_by{|v| v }

        arr = ["these","are","words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253minmax_by {|v| v }, arr.minmax_by{|v| v }

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253minmax_by {|v| v }, arr.minmax_by{|v| v }
    end

    def test_cs253none?

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253none? {|v| v < 1}, arr.none? {|v| v < 1}

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253none? {|v| v.even? },arr.none? {|v| v > 5}

        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253none? {|v| v.length <= 3}, arr.none? {|v| v.length <= 3}
    end

    def test_cs253one?
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253one? {|v| v > 5},arr.one? {|v| v > 5}
        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253one? {|v| v > 5},arr.one? {|v| v > 5}
        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253one? {|v| v.length <= 3}, arr.one? {|v| v.length <= 3}
    end

    def test_cs253partition
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253partition {|v| v > 5},arr.partition {|v| v > 5}
        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253partition {|v| v > 5},arr.partition {|v| v > 5}
        arr = []
        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253partition {|v| v.length <= 3}, arr.partition {|v| v.length <= 3}
    end

    def test_cs253reduce

        init_arr = [1,2,3,4,5,6]

        arr = CS253Array.new(init_arr)
        assert_equal arr.cs253reduce() {|sum, n| sum + n}, arr.reduce() {|sum, n| sum + n}

        arr = CS253Array.new(init_arr)
        assert_equal arr.cs253reduce(1) {|product, n| product * n}, arr.reduce(1) {|product, n| product * n}

        longest = CS253Array.new(["these","are","words"]).cs253reduce do |memo, word|
            memo.length > word.length ? memo : word
        end
        longest_real = CS253Array.new(["these","are","words"]).reduce do |memo, word|
            memo.length > word.length ? memo : word
        end

        assert_equal longest, longest_real
    end

    def test_cs253reject
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253reject{|v| v==2}, arr.reject{|v| v==2}

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253reject {|v| v != nil}, arr.reject {|v| v != nil}

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253reject {|v| v%3 == 0}, arr.reject {|v| v%3 == 0}
    end

    def test_cs253reverse_each
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        arr1 = []
        arr2 = []
        myarr.cs253reverse_each{|e| arr1 << e}
        arr.reverse_each{|e| arr2 << e}
        assert_equal arr1, arr2

        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        arr1 = []
        arr2 = []
        myarr.cs253reverse_each {|v| arr1 << v + 1 }
        arr.reverse_each {|v| arr2 << v + 1 }.to_a
        assert_equal arr1, arr2

        arr = [1]
        myarr = CS253Array.new(arr)
        arr1 = []
        arr2 = []
        myarr.cs253reverse_each {|v| arr1 <<  v * 4 }
        arr.reverse_each {|v| arr2 << v * 4 }.to_a
        assert_equal arr1, arr2
    end

    def test_cs253slice_after
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_after{|v| v == 3}, arr.slice_after{|v| v == 3}.to_a

        arr = [2, 3, 1, 4, 5]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_after{|v| v%2 == 0}, arr.slice_after{|v| v%2 == 0}.to_a

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_after{|v| v%2 == 0}, arr.slice_after{|v| v%2 == 0}.to_a
    end

    def test_cs253slice_before
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_before{|v| v == 3}, arr.slice_before{|v| v == 3}.to_a

        arr = [2, 3, 1, 4, 5]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_before{|v| v%2 == 0}, arr.slice_before{|v| v%2 == 0}.to_a

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_before{|v| v%2 == 0}, arr.slice_before{|v| v%2 == 0}.to_a
    end

    def test_cs253slice_when
        arr = [1,2,4,9,10,11,12,15,16,19,20,21]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_when {|i, j| i+1 == j}, arr.slice_when {|i, j| i+1 == j}.to_a

        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_when {|i, j| i.length+1 == j.length}, arr.slice_when {|i, j| i.length+1 == j.length}.to_a

        arr = ["Oh"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253slice_when {|i, j| i.length+1 == j.length}, arr.slice_when {|i, j| i.length+1 == j.length}.to_a
    end

    def test_cs253sum
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253sum {|v| v}, arr.sum

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253sum {|v| v*2}, arr.sum

        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253sum {|v| v.length}, arr.sum{|v| v.length}
    end

    def test_cs253take
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253take(4) , arr.take(4)

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253take(2) , arr.take(2)

        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253take(1) , arr.take(1)
    end

    def test_cs253take_while
        arr = [1,2,3,4,5,6]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253take_while {|v| v%3 == 1} , arr.take_while {|v| v%3 == 1}

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253take_while {|v| v%3 == 1} , arr.take_while {|v| v%3 == 1}

        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253take_while {|v| v.length %3 == 1} , arr.take_while {|v| v.length %3 == 1}
    end

    def test_cs253to_h
        arr = [[1,2],[3,4],[5,6]]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253to_h , arr.to_h

        arr = [["a","b"] ,["c","d"]]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253to_h , arr.to_h

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253take_while {|v| v.length%5 == 1} , arr.take_while {|v| v.length%5 == 1}
    end

    def test_cs253to_a
        arr = [1,2,3]
        myarr = [1,2,3]
        assert_equal myarr.cs253to_a, arr.to_a

        arr = [1,2,3]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253to_a, arr.to_a

        arr = []
        myarr = []
        assert_equal myarr.cs253to_a, []
    end

    def test_cs253uniq
        arr = [1,2,3,4,4,5,3,5]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253uniq{|v| v} , arr.uniq{|v| v}

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253uniq{|v| v} , arr.uniq{|v| v}

        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253uniq{|v| v.length%2==0} , arr.uniq{|v| v.length%2==0}
    end

    def test_cs253length
        arr = [1,2,3,4,5,6,7,8]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253length, arr.length

        arr = []
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253length, arr.length

        arr = ["these", "are", "words"]
        myarr = CS253Array.new(arr)
        assert_equal myarr.cs253length, arr.length
    end

end


