require 'minitest/autorun'
require './cs253Array.rb'
require './triple.rb'
require 'prime'


class CS253EnumTests < Minitest::Test
    
    class CS253Range < Range
    	include CS253Enumerable
	end

	class Foo
    	include Enumerable
    	include CS253Enumerable
        def each
            yield 0
            yield [1,2,3],6
            yield
        end
    end

    class Foo1
    	include Enumerable
    	include CS253Enumerable
        def each
            yield 1
            yield [1,2,3]
            yield
        end
    end

    class Foo2
    	include Enumerable
    	include CS253Enumerable
        def each
            yield 4
            yield 10,2
            yield (1..4)
        end
    end

    class CS253String < String
    	include CS253Enumerable
	end

	class CS253Range < Range
    	include CS253Enumerable
	end

    def test_cs253all?
		a = CS253Array.new(%w[rolling waves result])
		b = Triple.new([4,5,6],[1], [0,2])
		assert_equal a.all?{ |word| word.length >= 2 }, a.cs253all? { |word| word.length >= 2 }
		assert_equal a.all? { |word| word.length <= 4 }, a.cs253all? { |word| word.length <= 4 }
		assert_equal false, b.cs253all? {|e| e.size >2 }
    end

    def test_cs253any?
	    a = CS253Array.new(["string", "anotherString", "lastString"])
	    b = Triple.new("rock", 13, 'c')
	    assert_equal a.any?{ |word| word.length >= 5 }, a.cs253any? { |word| word.length >= 5 }
	    assert_equal true, b.cs253any? {|e| e.class == String}
	    assert_equal true, b.cs253any? {|e| e%13 == 0}
	end

	def test_cs253chunk
		a = CS253Array.new([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5])
		assert_equal [[false, [3, 1]], [true, [4]], [false, [1, 5, 9]], [true, [2, 6]], [false, [5, 3, 5]]], a.cs253chunk { |n| n.even?}
		assert_equal [[true, [3]], [false, [1, 4, 1]], [true, [5]], [false, [9]], [true, [2]], [false, [6]], [true, [5, 3, 5]]], a.cs253chunk { |n| Prime.prime? (n)}
		assert_equal [[true, [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]]], a.cs253chunk { |n| n.class == Integer}
	end 

	def test_cs253chunk_while
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.chunk_while{|i, j| i == j }.to_a, a.cs253chunk_while {|i, j| i == j }
		assert_equal a.chunk_while{|i, j| i <= j }.to_a, a.cs253chunk_while {|i, j| i <= j }
		assert_equal a.chunk_while {|i, j| i.floor == j.floor }.to_a, a.cs253chunk_while {|i, j| i.floor == j.floor }
	end

	def test_cs253collect
		a = Triple.new("doctor", "save", "")
		b = CS253Range.new(2,10)
		assert_equal ["", "", ""], a.cs253collect{|e| ""}
		assert_equal b.collect {|i| i*i }, b.cs253collect {|i| i*i }
		assert_equal b.collect {|i| i.even?}, b.cs253collect {|i| i.even?}
	end

	def test_cs253count
		a = CS253Array.new([1,5,4,1])
		assert_equal a.count, a.cs253count
		assert_equal a.count(1), a.cs253count(1)
		assert_equal a.count{|x| x%5==0}, a.cs253count{|x| x%5==0}
	end

	def test_cs253collect_concat
		a = CS253Array.new([[1, 2], [3, 4]])
		b = CS253Array.new([1,2,3,4])
		assert_equal b.collect_concat { |e| [e, -e] }, b.cs253collect_concat{ |e| [e, -e] }
		assert_equal a.collect_concat {|e| e*2}, a.cs253collect_concat{ |e| e*2 }
		c = Triple.new([1,2,3], "string", true)
		assert_equal [1,2,3,"string",true], c.cs253collect_concat{ |e| e }
	end

	def test_cs253cycle
		a = Triple.new("doctor", 256, true)
		d = []
		d1 = []
		a.cycle(3) {|x| d << x}
		a.cs253cycle(3) {|x| d1 << x}
		assert_equal d, d1
		b = CS253Range.new(-5,3)
		b.cs253cycle(1) {|x| d<<x}
		b.cs253cycle(1) {|x| d1<< x}
		assert_equal d, d1
		# assert_equal b.cycle {|x| puts x}, b.cs253cycle {|x| puts x} - runs forever
	end

	def test_cs253detect
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.detect{ |i| i%3 == 0}, a.cs253detect{ |i| i%3 == 0}
		assert_equal a.detect{ |i| i%2 == 0}, a.cs253detect{ |i| i%2 == 0}
		assert_equal a.detect{ |i| Prime.prime? (i)}, a.cs253detect{ |i| Prime.prime? (i)}
	end


	def test_cs253drop
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.drop(3), a.cs253drop(3)
		assert_equal a.drop(a.size()), a.cs253drop(a.size())
		b = Triple.new("doctor", 256, true)
		assert_equal [], b.cs253drop(3)
	end

	def test_cs253dropwhile
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.drop_while {|i| i%2 == 0}, a.cs253drop_while {|i| i%2 == 0}
		assert_equal a.drop_while {|i| i > 20}, a.cs253drop_while {|i| i > 20}
		b = Triple.new([4,5,6],[1], [0,2])
		assert_equal [], b.cs253drop_while {|i| i.length() >= 0}
	end

	def test_cs253each_cons
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		a1, a2 = [], []
		a.each_cons(3){|e| a1 << e}
		a.cs253each_cons(3) {|e| a2 << e}
		assert_equal a1, a2
		b = CS253Array.new([nil, nil, nil])
		b1, b2 = [], []
		b.each_cons(1) {|e| b1 << e}
		b.cs253each_cons(1) {|e| b2 <<e}
		assert_equal b1, b2
		c = CS253Range.new(0,0)
		c1, c2 = [], []
		c.each_cons(1) {|e| c1 << e}
		c.cs253each_cons(1) {|e| c2<<e}
		assert_equal c1, c2
	end

	def test_cs253each_entry
		assert_equal Foo.new.each_entry {|i| i}.to_a, Foo.new.cs253each_entry {|i| i}.to_a
		assert_equal Foo1.new.each_entry {|i| i}.to_a, Foo1.new.cs253each_entry {|i| i}.to_a
		assert_equal Foo2.new.each_entry {|i| i}.to_a, Foo2.new.cs253each_entry {|i| i}.to_a
	end

	def test_cs253each_with_index
		hash = Hash.new
		a = CS253Array["ab","abbg", "babababba"]
		assert_equal a.each_with_index { |item, index| hash[item] = index*2}, a.cs253each_with_index { |item, index| hash[item] = index*2}
		assert_equal a.each_with_index { |item, index| hash[item] = index}, a.cs253each_with_index { |item, index| hash[item] = index}
		assert_equal a.each_with_index { |item, index| hash[item.length] = index}, a.cs253each_with_index { |item, index| hash[item.length] = index}
	end

	def test_cs253each_with_object
		a = CS253Array.new([])
		b = CS253Array.new([1,2,3,4,50,10])
		c = CS253Array.new([nil, nil, nil])
		assert_equal b.each_with_object([]) { |i, a| a << i*2 }, b.cs253each_with_object([]) { |i, a| a << i*2 }
		assert_equal a.each_with_object([]) { |i, a| a[i] = i*2 }, a.cs253each_with_object([]) { |i, a| a[i] = i*2 }
		assert_equal c.each_with_object({}) { |i, a| a[i] = i }, c.cs253each_with_object({}) { |i, a| a[i] = i }
	end

	def test_cs253each_slice
		b = CS253Range.new(-5,3)
		assert_nil b.cs253each_slice(3) { |a| a }
		assert_nil b.cs253each_slice(b.size) { |a| a }
		assert_nil b.cs253each_slice(1) { |a| a }
	end

	def test_cs253entries
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		b = CS253Range.new(-5,3)
		assert_equal a.entries, a.cs253entries
		assert_equal b.entries, b.cs253entries
		assert_equal (Prime.first 5).entries, CS253Array.new((Prime.first 5)).cs253entries
	end

	def test_cs253find
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.find{ |i| i%3 == 0}, a.cs253find{ |i| i%3 == 0}
		assert_equal a.find{ |i| i%2 == 0}, a.cs253find{ |i| i%2 == 0}
		assert_equal a.find{ |i| Prime.prime? (i)}, a.cs253find{ |i| Prime.prime? (i)}
	end

	def test_cs253find_all
		a = CS253Array.new(["", "man", "magnolia", "room", "Mars"])
		b = CS253Array.new([1,3,5])
		c = CS253Array.new([1,2,3,4,5])
		assert_equal a.find_all{|e| e.start_with? "m"}	 , a.cs253find_all {|e| e.start_with? "m"}	
		assert_equal b.find_all { |num|  num.even?  },b.cs253find_all { |num|  num.even?  }
		assert_equal c.find_all { |num|  num.even?  }, c.cs253find_all { |num|  num.even?  }
	end

	def test_find_index
		a = CS253Range.new(-10,30)
		b = CS253Range.new(1,1000)
		assert_equal a.find_index  { |i| i % 2 == 0 and i % 3 == 0 },  a.cs253find_index  { |i| i % 2 == 0 and i % 3 == 0 }
		assert_equal b.find_index { |i| Prime.prime?(i) and i % 7 == 0 }, b.cs253find_index { |i| Prime.prime?(i) and i % 7 == 0 }
		assert_nil b.cs253find_index(-90)  
	end

	def test_cs253first
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.first, a.cs253first
		assert_equal a.first(8), a.cs253first(8)
		b = Triple.new("doctor", 256, true)
		assert_equal "doctor", b.cs253first 
	end

	def test_cs253flat_map
		a = CS253Array.new([[1, 2], [3, 4]])
		b = CS253Array.new([1,2,3,4])
		assert_equal b.flat_map { |e| [e, -e] }, b.cs253flat_map{ |e| [e, -e] }
		assert_equal a.flat_map {|e| e*2}, a.cs253flat_map{ |e| e*2 }
		c = Triple.new([1,2,3], "string", true)
		assert_equal [1,2,3,"string",true], c.cs253flat_map{ |e| e }	end

	def test_cs253grep
		a = CS253Range.new(1,100)
		assert_equal a.grep(1..3), a.cs253grep(1..3)
		assert_equal a.grep(1..3) {|i| i+3}, a.cs253grep(1..3) {|i| i+3}
		assert_equal a.grep(-10..3), a.cs253grep(-10..3)
	end

	def test_cs253grep_v
		a = CS253Range.new(1,100)
		assert_equal a.grep_v(1..3), a.cs253grep_v(1..3)
		assert_equal a.grep_v(-10..3) {|i| i+3}, a.cs253grep_v(1..3) {|i| i+3}
		b = CS253Array.new([nil,nil,nil])
		assert_equal b.grep_v(-10..3), b.cs253grep_v(-10..3)
	end

	def test_cs253group_by
		a = CS253Range.new(1,10)
		assert_equal a.group_by{|i| i/2}, a.cs253group_by{|i| i/2}
		b = Triple.new("mama", "papa", "")
		assert_equal b.group_by{|w| w.length}, b.cs253group_by{|w| w.length}
	end

	def test_cs253include?
		a = CS253Range.new(-50,50)
		assert_equal a.member?(50), a.cs253member?(50)
		assert_equal a.member?(a), a.cs253member?(a)
		assert_equal a.member?(101), a.cs253member?(101)
	end

	def test_cs253inject
		a = CS253Array.new([5,6,7,8,9,10])
		assert_equal a.inject { |sum, n| sum + n }, a.cs253inject { |sum, n| sum + n }
		b = CS253Array.new(["cat", "sheep", "bear"])
		assert_equal  "sheep", 
			b.cs253inject {|memo, word| memo.length > word.length ? memo : word}
		assert_equal a.inject(2) { |product, n| product * n }	, a.cs253inject(2) { |product, n| product * n }	
	end

	def test_cs253map
		a = Triple.new("doctor", "save", "")
		b = CS253Range.new(2,10)
		assert_equal ["", "", ""], a.cs253map{|e| ""}
		assert_equal b.map {|i| i*i }, b.cs253map {|i| i*i }
		assert_equal b.map {|i| i.even?}, b.cs253map {|i| i.even?}
	end

	def test_cs253max_by
		a = CS253Range.new(1,10)
		b = CS253Array.new([0x100, 1, -2**12])
		c = CS253Array.new(["a","abba", "bababab"])
		assert_equal c.max_by{|w| w.length()}, c.cs253max_by{|w| w.length()}
		assert_equal a.max_by(5) {|e| e}, a.cs253max_by(5) {|e| e}
		assert_equal b.max_by(1) {|e| e.bit_length}, b.cs253max_by(1) {|e| e.bit_length}
	end

	def test_cs253_max
		a = CS253Range.new(1,1000)
		b = CS253Array.new(["pelican", "rob", "horse"])
		c = CS253Array.new([5, 1, 3, 4, 2])
		assert_equal a.max(3), a.cs253max(3)
		assert_equal b.max(2) {|a, b| a.length <=> b.length }, b.cs253max(2) {|a, b| a.length <=> b.length }
		assert_equal c.max(3){|a, b| a <=> b}, c.cs253max(3){|a, b| a <=> b}
	end

	def test_cs253member?
		a = CS253Range.new(1,100)
		assert_equal a.member?(50), a.cs253member?(50)
		assert_equal a.member?(a), a.cs253member?(a)
		assert_equal a.member?(101), a.cs253member?(101)
	end

	def test_cs253min_by
		a = CS253Range.new(1,100)
		b = CS253Array.new([0x100, 1, -2**12])
		c = CS253Array.new(["a","abba", "bababab"])
		assert_equal c.min_by(2){|w| w.length()}, c.cs253min_by(2){|w| w.length()}
		assert_equal a.min_by(5) {|e| e}, a.cs253min_by(5) {|e| e}
		assert_equal b.min_by(1) {|e| e.bit_length}, b.cs253min_by(1) {|e| e.bit_length}
	end

	def test_cs253_min
		a = CS253Range.new(1,1000)
		b = CS253Array.new(["perepel", "rob", "horse"])
		c = CS253Array.new([5, 1, 3, 4, 2])
		assert_equal a.min(3), a.cs253min(3)
		assert_equal b.min(2) {|a, b| a.length <=> b.length }, b.cs253min(2) {|a, b| a.length <=> b.length }
		assert_equal c.min(3){|a, b| a <=> b}, c.cs253min(3){|a, b| a <=> b}
	end

	def test_cs253minmax
		a = CS253Range.new(1,1000)
		b = CS253Array.new(["perepel", "rob", "horse"])
		c = CS253Array.new([])
		assert_equal a.minmax, a.minmax
		assert_equal b.minmax{|a, b| a.length <=> b.length }, b.cs253minmax {|a, b| a.length <=> b.length }
		assert_equal c.minmax{|a, b| a <=> b}, c.cs253minmax{|a, b| a <=> b}
	end

	def test_cs253minmax_by
		a = CS253Range.new(1,1000)
		b = CS253Array.new(["perepel", "rob", "horse"])
		c = CS253Array.new([])
		assert_equal a.minmax_by{|a| a}, a.cs253minmax_by{|a|a}
		assert_equal b.minmax_by{|a| a.length}, b.cs253minmax_by {|a| a.length}
		assert_equal c.minmax_by{|a| a}, c.cs253minmax_by{|a| a}
	end

	def test_cs253none?
		a = CS253Array.new(["ror", "lasso", "tupic"])
		b = CS253Array.new([nil, false, true])
		assert_equal a.none? { |word| word.length == 5 }, a.cs253none? { |word| word.length == 5 }
		assert_equal a.none? { |word| word.length > 10 }, a.cs253none? { |word| word.length > 10 }
		assert_equal b.cs253none? {|e| e==false}, b.none? {|e| e==false}
	end

	def test_cs253one?
		b = CS253Array.new(["pelican", "rob", "horse"])
		assert_equal b.one? { |word| word.length >= 4 }, b.cs253one? { |word| word.length >= 4 }
		assert_equal b.one? {|e| e=="rob"}, b.cs253one? {|e| e=="rob"}
		assert_equal b.one? {|e| e.length <10}, b.cs253one? {|e| e.length < 10}
	end

	def test_cs253partition
		a = CS253Range.new(1,10)
		assert_equal a.partition{ |v| v.even? }, a.cs253partition{|v| v.even?}
		assert_equal a.partition { |v| Prime.prime?(v)}, a.cs253partition { |v| Prime.prime?(v)}
		assert_equal a.partition { |v| v%3 == 0 || v %5 == 0}, a.cs253partition { |v| v%3 == 0 || v %5 == 0}
	end

	def test_cs253reduce
		a = CS253Array.new([5,6,7,8,9,10])
		b = CS253Array.new(["cat", "sheep", "bear" ])
		assert_equal a.reduce { |sum, n| sum + n }, a.cs253reduce { |sum, n| sum + n }
		assert_equal  "sheep", 
			(b.cs253reduce do |memo, word|
		    	memo.length > word.length ? memo : word
			end)
		assert_equal a.reduce(2) { |product, n| product * n }, a.cs253reduce(2) { |product, n| product * n }	
	end

	def test_cs253reject
		a = CS253Array.new([5,6,7,8,9,10])
		assert_equal a.reject { |num| num.even? }, a.cs253reject { |num| num.even? }
		assert_equal a.reject { |num| Prime.prime?(num) }, a.cs253reject { |num| Prime.prime?(num) }
		assert_equal a.reject { |num| num.odd? }, a.cs253reject { |num| num.odd? }
	end

	def test_cs253reverse_each
		a = CS253Range.new(1,10)
		assert_equal a.reverse_each{|v| v},a.cs253reverse_each { |v| v }
		assert_equal a.reverse_each{|v| v%3==0},a.cs253reverse_each { |v| v%3 == 0 }
		assert_equal a.reverse_each{|v| v.even?},a.cs253reverse_each { |v| v.even? }
	end

	def test_cs253select
		a = CS253Array.new(["", "man", "magnolia", "room", "Mars"])
		b = CS253Array.new([1,3,5])
		c = CS253Array.new([1,2,3,4,5])
		assert_equal a.select{|e| e.start_with? "m"}	 ,a.cs253select {|e| e.start_with? "m"}	
		assert_equal b.select { |num|  num.even?  } ,b.cs253select { |num|  num.even?  }
		assert_equal c.select { |num|  num.even?  },c.cs253select { |num|  num.even?  }
	end

	def test_cs253slice_after
		a = CS253Range.new(-50,50)
		assert_equal a.slice_after(100).to_a, a.cs253slice_after(100)
		assert_equal a.slice_after(50).to_a, a.cs253slice_after(50)
		b = CS253Array.new([nil, nil,nil])
		assert_equal b.slice_after{|e| e}.to_a,  b.cs253slice_after{|e| e}
	end

	def test_cs253slice_before
		a = CS253Range.new(-50,50)
		assert_equal a.slice_before(100).to_a, a.cs253slice_before(100)
		assert_equal a.slice_before(0).to_a, a.cs253slice_before(0)
		b = CS253Array.new()
		assert_equal b.slice_before{|e| e}.to_a,  b.cs253slice_before {|e| e}
	end

	def test_cs253slice_when
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.slice_when {|i, j| i+1 != j }.to_a, a.cs253slice_when {|i, j| i+1 != j }
		assert_equal a.slice_when {|i, j| i <= j }.to_a, a.cs253slice_when {|i, j| i <= j }
		assert_equal a.slice_when {|i, j| i.even? == j.even? }.to_a, a.cs253slice_when {|i, j| i.even? == j.even?}
	end

	def test_cs253sort
		a = CS253Array.new([10,9,8,7,6,5,4,3,2,1,0])
		assert_equal a.sort, a.cs253sort
		b = CS253Array.new([])
		assert_equal b.sort, b.cs253sort
		assert_equal a.sort{|a, b| b <=> a}, a.cs253sort{|a, b| b <=> a}
	end

	def test_cs253sort_by
		a = CS253Array.new([10,9,8,7,6,5,4,3,2,1,0])
		assert_equal a.sort_by {|a| a}, a.cs253sort_by{|a| a}
		b = Triple.new("environment", "save", "")
		c = CS253Array.new(["pelican", "rob", "horse"])
		assert_equal ["", "save", "environment"], b.cs253sort_by {|w| w.length}
		assert_equal c.sort_by{|w| w.length}, c.cs253sort_by{|w| w.length}
	end

	def test_cs253sum
		a = CS253Range.new(1,5)
		assert_equal a.sum, a.cs253sum 
		assert_equal a.sum { |e| e *2 }, a.cs253sum { |e| e *2 }
		b = Triple.new("crab", "laughter", "wow")
		assert_equal 15, b.cs253sum {|w| w.length}
	end

	def test_cs253take
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.take(2), a.cs253take(2)
		assert_equal a.take(0), a.cs253take(0)
		b = Triple.new("doctor", 256, true)
		assert_equal ["doctor",256], b.cs253take(2) 
	end

	def test_cs253take_while
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.take_while {|i| Prime.prime? (i)}, a.cs253take_while {|i| Prime.prime? (i)  }
		assert_equal a.take_while {|i| i <= 10 }, a.cs253take_while {|i| i <= 10 }
		b = CS253Array.new([nil, nil, nil])
		assert_equal b.take_while {|i, j| i == j }, b.cs253take_while {|i, j| i == j}
	end

	def test_cs253to_a
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		b = CS253Range.new(-5,3)
		c = Triple.new([4,5,6],[1], [0,2])
		assert_equal a.to_a, a.cs253to_a
		assert_equal b.to_a, b.cs253to_a
		assert_equal [[4,5,6],[1], [0,2]], c.cs253to_a
	end

	def test_cs253to_h
		t = Triple.new([1, "one"], [2, "two"], [3, "three"])
   		h = { 1 => "one", 2 => "two", 3 => "three" }
    	assert_equal h, t.cs253to_h
	end

	def test_cs253uniq
		a = CS253Array.new([0,11,12,1,1,2,4,4,20,21])
		b = CS253Array.new([["Vermont","Lola"], ["Vermont","Lila"], ["New York","Laura"]])
		assert_equal a.uniq, a.cs253uniq
		assert_equal b.uniq {|s| s.first}, b.cs253uniq { |s| s.first }
		assert_equal a.uniq{|e| e%2==0}, a.cs253uniq{|e| e%2 == 0}
	end

	def test_cs253zip
		a = CS253Array.new([])
		b = CS253Array.new([1,2,3])
		c = CS253Range.new(1,3)
		assert_equal a.zip(b), a.cs253zip(b)
		assert_equal a.zip(a, b), a. cs253zip(a,b)
		d = CS253Array.new()
		d1 = CS253Array.new()
		c.zip(b) {|y| d << y}
		c.cs253zip(b) {|y| d1 << y}
		assert_equal d, d1
	end
end

