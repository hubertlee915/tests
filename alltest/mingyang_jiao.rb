require 'minitest/autorun'
require './cs253Array.rb'
require './triple.rb'

class CS253EnumTests < Minitest::Test

    def setup
        @int_array_enum = Triple.new(1,2,3)
        @int_array = [1, 2, 3]
        @str_array_enum = CS253Array.new(["cavil", "captions", "carp"])
        @str_array = ["cavil", "captions", "carp"]
        @long_int_array_enum = CS253Array.new([3,2,5,9,2,2,2,3,4,5])
        @long_int_array = [3,2,5,9,2,2,2,3,4,5]
        @twod_array_enum = CS253Array.new([[1, 2, 3],[4, 5, 6]])
        @twod_array = [[1, 2, 3],[4, 5, 6]]
        @hash_array_enum = CS253Array.new([[1, 2],[4, 5]])
        @hash_array = [[1, 2],[4, 5]]
        @empty_int_array_enum = CS253Array.new([])
        @empty_int_array = []
    end

    def test_cs253all?
    	assert_equal @int_array_enum.cs253all? { |e| e.even? }, @int_array.all? { |e| e.even? }
    	assert_equal @int_array_enum.cs253all? { |e| e < 4 }, @int_array.all?{ |e| e < 4 }	
    	assert_equal @str_array_enum.cs253all? { |e| e.length < 5 }, @str_array.all?{ |e| e.length < 5 }    
    end

    def test_cs253any?
        assert_equal @int_array_enum.cs253any? { |e| e.even? }, @int_array.any? { |e| e.even? }
        assert_equal @int_array_enum.cs253any? { |e| e < 4 }, @int_array.any?{ |e| e < 4 }  
        assert_equal @str_array_enum.cs253any? { |e| e.length < 5 }, @str_array.any?{ |e| e.length < 5 }  
    end

    def test_cs253chunk 
        assert_equal @int_array_enum.cs253chunk { |e| e.even? }, @int_array.chunk { |e| e.even? }.to_a
        assert_equal @long_int_array_enum.cs253chunk { |e| e.even? }, @long_int_array.chunk { |e| e.even? }.to_a
        assert_equal @long_int_array_enum.cs253chunk { |e| e.odd? }, @long_int_array.chunk { |e| e.odd? }.to_a
        assert_equal @empty_int_array_enum.cs253chunk { |e| e.odd? }, @empty_int_array.chunk { |e| e.odd? }.to_a
    end

    def test_cs253chunk_while 
        assert_equal @int_array_enum.cs253chunk_while { |i,j| i<j }, @int_array.chunk_while { |i,j| i<j }.to_a
        assert_equal @long_int_array_enum.cs253chunk_while { |i,j| i<j }, @long_int_array.chunk_while { |i,j| i<j }.to_a
        assert_equal @str_array_enum.cs253chunk_while { |i,j| i.length<j.length }, @str_array.chunk_while { |i,j| i.length<j.length }.to_a
    end

    def test_cs253collect 
        assert_equal @int_array_enum.cs253collect{|i| i+5}, @int_array.collect{|i| i+5}
        assert_equal @long_int_array_enum.cs253collect{|i| i*2}, @long_int_array.collect{|i| i*2}
        assert_equal @str_array_enum.cs253collect{|i| i+"kkk"}, @str_array.collect{|i| i+"kkk"}
    end

    def test_cs253collect_concat 
        assert_equal @int_array_enum.cs253collect_concat{|e| [e,-e]}, @int_array.collect_concat{|e| [e,-e]}.to_a
        assert_equal @str_array_enum.cs253collect_concat{|i| "kkk"}, @str_array.collect_concat{|i| "kkk"}.to_a
        assert_equal @twod_array_enum.cs253collect_concat{|e| e+[1000]}, @twod_array.collect_concat{|e| e+[1000]}.to_a
    end

    def test_cs253count 
        assert_equal @long_int_array_enum.cs253count , @long_int_array.count
        assert_equal @long_int_array_enum.cs253count(3) , @long_int_array.count(3)
        assert_equal @long_int_array_enum.cs253count{ |e| e.even? } , @long_int_array.count{ |e| e.even? }
        assert_equal @str_array_enum.cs253count , @str_array.count
        assert_equal @str_array_enum.cs253count("c") , @str_array.count("c")
        assert_equal @str_array_enum.cs253count{ |e| e.length>5 } , @str_array.count{ |e| e.length>5 }
   end

    def test_cs253cycle 
        assert_equal @long_int_array_enum.cs253cycle(1) { |e| e+1 }, nil
        assert_equal @int_array_enum.cs253cycle(2) { |e| p e }, nil
        assert_equal @str_array_enum.cs253cycle(10) { |e| p e }, nil
    end

    def test_cs253detect
        assert_equal @long_int_array_enum.cs253detect { |e| e%3==0 }, @long_int_array.detect { |e| e%3==0 }
        assert_equal @long_int_array_enum.cs253detect { |e| e%3==1 }, @long_int_array.detect { |e| e%3==1 }
        assert_equal @str_array_enum.cs253detect { |e| e.length < 5 }, @str_array.detect{ |e| e.length < 5 }
    end

    def test_cs253drop
        assert_equal @long_int_array_enum.cs253drop(2), @long_int_array.drop(2)
        assert_equal @long_int_array_enum.cs253drop(1), @long_int_array.drop(1)
        assert_equal @long_int_array_enum.cs253drop(0), @long_int_array.drop(0)
        assert_equal @long_int_array_enum.cs253drop(10), @long_int_array.drop(10)
        assert_equal @str_array_enum.cs253drop(2), @str_array.drop(2)
    end

    def test_cs253drop_while
        assert_equal @long_int_array_enum.cs253drop_while{ |i| i<3 }, @long_int_array.drop_while{ |i| i<3 }.to_a
        assert_equal @long_int_array_enum.cs253drop_while{ |i| i<2 }, @long_int_array.drop_while{ |i| i<2 }.to_a
        assert_equal @str_array_enum.cs253drop_while{ |i| i.length<6 }, @str_array.drop_while{ |i| i.length<6 }.to_a
    end

    def test_cs253each_cons
        assert_equal @long_int_array_enum.cs253each_cons(3){ |e| p e}, @long_int_array.each_cons(3){ |e| p e }
        assert_equal @long_int_array_enum.cs253each_cons(4){ |e| p e}, @long_int_array.each_cons(4){ |e| p e }
        assert_equal @long_int_array_enum.cs253each_cons(1){ |e| p e}, @long_int_array.each_cons(1){ |e| p e }
    end

    def test_cs253each_entry
        assert_equal @int_array_enum.cs253each_entry {|e| p e},@int_array.each_entry {|e| p e}
        assert_equal @long_int_array_enum.cs253each_entry {|e| p e},@long_int_array_enum{|e| p e}
    end

    def test_cs253each_slice 
       assert_equal @long_int_array_enum.cs253each_slice(3){ |e| p e}, @long_int_array.each_slice(3){ |e| p e }
       assert_equal @long_int_array_enum.cs253each_slice(4){ |e| p e}, @long_int_array.each_slice(4){ |e| p e }
       assert_equal @long_int_array_enum.cs253each_slice(1){ |e| p e}, @long_int_array.each_slice(1){ |e| p e }
    end

    def test_cs253each_with_index
        assert_equal @int_array_enum.cs253each_with_index{ |e,i| puts e.to_i+i.to_i}, @int_array_enum
    end

    def test_cs253each_with_object
        assert_equal @int_array_enum.cs253each_with_object([]) {|i, a| a << i * 2 },@int_array.each_with_object([]) {|i, a| a << i * 2 }
        assert_equal @long_int_array_enum.cs253each_with_object([]) {|i, a| a << i * 2 },@long_int_array.each_with_object([]) {|i, a| a << i * 2 }
        assert_equal @str_array_enum.cs253each_with_object({}) { |s, h| h[s] = s.upcase },@str_array.each_with_object({}) { |s, h| h[s] = s.upcase }
    end

    def test_cs253entries
        assert_equal @int_array_enum.cs253entries,@int_array.entries
        assert_equal @twod_array_enum.cs253entries,@twod_array.entries
        assert_equal @empty_int_array_enum.cs253entries,@empty_int_array.entries
        assert_equal @str_array_enum.cs253entries,@str_array.entries        
    end

    def test_cs253find
        assert_equal @long_int_array_enum.cs253find { |e| e % 3 == 0 }, @long_int_array.find { |e| e % 3 == 0 }
        assert_equal @long_int_array_enum.cs253find { |e| e%3==1 }, @long_int_array.find { |e| e%3==1 }
        assert_equal @str_array_enum.cs253find { |e| e.length < 5 }, @str_array.find{ |e| e.length < 5 }
    end

    def test_cs253find_all
        assert_equal @long_int_array_enum.cs253find_all { |num| num.even?}, @long_int_array.find_all { |num| num.even?}
        assert_equal @long_int_array_enum.cs253find_all { |num| num.odd?}, @long_int_array.find_all { |num| num.odd?}
        assert_equal @long_int_array_enum.cs253find_all { |letter| letter =~ /[aeiou]/}, @long_int_array.find_all{ |letter| letter =~ /[aeiou]/}        
    end

    def test_cs253find_index
        assert_equal @long_int_array_enum.cs253find_index { |num| num.even?}, @long_int_array.find_index { |num| num.even?}
        assert_equal @long_int_array_enum.cs253find_index { |num| num.odd?}, @long_int_array.find_index { |num| num.odd?}
        assert_equal @long_int_array_enum.cs253find_index { |num| num%3 == 1}, @long_int_array.find_index { |num| num%3 == 1}
        assert_equal @long_int_array_enum.cs253find_index { |letter| letter =~ /[aeiou]/}, @long_int_array.find_index{ |letter| letter =~ /[aeiou]/}
    end

    def test_cs253first
        assert_equal @long_int_array_enum.cs253first(2), @long_int_array.first(2)
        assert_equal @long_int_array_enum.cs253first(1), @long_int_array.first(1)
        assert_equal @long_int_array_enum.cs253first, @long_int_array.first
        assert_equal @long_int_array_enum.cs253first(10), @long_int_array.first(10)
        assert_equal @str_array_enum.cs253first(2), @str_array.first(2)
    end

    def test_cs253flat_map 
        assert_equal @int_array_enum.cs253flat_map{|e| [e,-e]}, @int_array.flat_map{|e| [e,-e]}.to_a
        assert_equal @str_array_enum.cs253flat_map{|i| "kkk"}, @str_array.flat_map{|i| "kkk"}.to_a
        assert_equal @twod_array_enum.cs253flat_map{|e| e+[1000]}, @twod_array.flat_map{|e| e+[1000]}.to_a
    end

    def test_cs253grep
        assert_equal @int_array_enum.cs253grep(1),@int_array.grep(1)
        assert_equal @int_array_enum.cs253grep(2..5),@int_array.grep(2..5)
        assert_equal @long_int_array_enum.cs253grep(1..3), @long_int_array.grep(1..3)
        assert_equal @str_array_enum.cs253grep(/ca/), @str_array.grep(/ca/)
    end

    def test_cs253grep_v
        assert_equal @int_array_enum.cs253grep_v(1),@int_array.grep_v(1)
        assert_equal @int_array_enum.cs253grep_v(2..5),@int_array.grep_v(2..5)
        assert_equal @long_int_array_enum.cs253grep_v(1..3), @long_int_array.grep_v(1..3)
        assert_equal @str_array_enum.cs253grep_v(/ca/), @str_array.grep_v(/ca/)
    end

    def test_cs253group_by
        assert_equal @int_array_enum.cs253group_by { |num| num.even?}, @int_array.group_by { |num| num.even?}
        assert_equal @long_int_array_enum.cs253group_by { |num| num.odd?}, @long_int_array.group_by { |num| num.odd?}
        assert_equal @long_int_array_enum.cs253group_by { |num| num%3 }, @long_int_array.group_by { |num| num%3 }
        assert_equal @str_array_enum.cs253group_by { |letter| letter =~ /[aeiou]/}, @str_array.group_by{ |letter| letter =~ /[aeiou]/}
    end

    def test_cs253include?
        assert_equal @int_array_enum.cs253include?(2), @int_array.include?(2)
        assert_equal @long_int_array_enum.cs253include?(1), @long_int_array.include?(1)
        assert_equal @long_int_array_enum.cs253include?(10), @long_int_array.include?(10)
        assert_equal @str_array_enum.cs253include?("carp"), @str_array.include?("carp")
    end

    def test_cs253inject
        # test for inject with no block
        assert_equal @int_array_enum.cs253inject("+"), @int_array.inject("+")
        assert_equal @int_array_enum.cs253inject("*"), @int_array.inject("*")
        assert_equal @long_int_array_enum.cs253inject("+"), @long_int_array.inject("+")
        assert_equal @long_int_array_enum.cs253inject("-"), @long_int_array.inject("-")
        assert_equal @int_array_enum.cs253inject(0,"+"), @int_array.inject(0,"+")
        assert_equal @int_array_enum.cs253inject(1,"*"), @int_array.inject(1,"*")
        assert_equal @int_array_enum.cs253inject(2,"*"), @int_array.inject(2,"*")
        assert_equal @int_array_enum.cs253inject(24,"/"), @int_array.inject(24,"/")
        assert_equal @long_int_array_enum.cs253inject(1,"+"), @long_int_array.inject(1,"+")
        assert_equal @long_int_array_enum.cs253inject(3,"-"), @long_int_array.inject(3,"-")

        #test for inject with block
        arr_1 = [1,2,3,4]
        arr_1_result = 10

        arr_2 = [1,2,3,4]
        arr_2_result = 24

        arr_3 = [5,6,7,8,9,10]
        arr_3_result = 151200

        test1 = CS253Array.new(arr_1)
        test2 = CS253Array.new(arr_2)
        test3 = CS253Array.new(arr_3)
        
        
        assert_equal test1.cs253inject(0) {|sum, e| sum+e}, arr_1_result
        assert_equal arr_1.inject(0) {|sum, e| sum+e}, arr_1_result

        assert_equal test2.cs253inject(1) {|product, e| product*e}, arr_2_result
        assert_equal arr_2.inject(1) {|product, e| product*e}, arr_2_result

        assert_equal test3.cs253inject(1) {|product, e| product*e}, arr_3_result
        assert_equal arr_3.inject(1) {|product, e| product*e}, arr_3_result
    end

    def test_cs253map
        assert_equal @int_array_enum.cs253map{|i| i+5}, @int_array.map{|i| i+5}
        assert_equal @long_int_array_enum.cs253map{|i| i*2}, @long_int_array.map{|i| i*2}
        assert_equal @str_array_enum.cs253map{|i| i+"kkk"}, @str_array.map{|i| i+"kkk"}       
    end

    def test_cs253max
        # max return obj
        assert_equal @int_array_enum.cs253max, @int_array.max
        assert_equal @long_int_array_enum.cs253max, @long_int_array.max
        # max{|a,b| block} return obj
        assert_equal @int_array_enum.cs253max{|x,y| x.to_i <=> y.to_i}, @int_array.max{|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253max{|x,y| x.to_i <=> y.to_i}, @long_int_array.max{|x,y| x.to_i <=> y.to_i}
        # max(n) return array
        assert_equal @int_array_enum.cs253max(1), @int_array.max(1)
        assert_equal @long_int_array_enum.cs253max(1), @long_int_array_enum.max(1)
        assert_equal @int_array_enum.cs253max(2), @int_array.max(2)
        assert_equal @long_int_array_enum.cs253max(5), @long_int_array_enum.max(5)
        # max(){|a,b| blcok} return array
        assert_equal @int_array_enum.cs253max(1){|x,y| x.to_i <=> y.to_i}, @int_array.max(1){|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253max(1){|x,y| x.to_i <=> y.to_i}, @long_int_array_enum.max(1){|x,y| x.to_i <=> y.to_i}
        assert_equal @int_array_enum.cs253max(2){|x,y| x.to_i <=> y.to_i}, @int_array.max(2){|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253max(5){|x,y| x.to_i <=> y.to_i}, @long_int_array_enum.max(5){|x,y| x.to_i <=> y.to_i}
    end

    def test_cs253max_by
        assert_equal @int_array_enum.cs253max_by(1){|x| x.to_i}, @int_array.max_by(1) {|x| x.to_i}
        assert_equal @int_array_enum.cs253max_by(1) {|x| x.ord}, @int_array.max_by(1) {|x| x.ord}
        assert_equal @long_int_array_enum.cs253max_by(1) {|x| x.ord}, @long_int_array.max_by(1) {|x| x.ord}
    end

    def test_cs253member?
        assert_equal @int_array_enum.cs253member?(2), @int_array.member?(2)
        assert_equal @long_int_array_enum.cs253member?(1), @long_int_array.member?(1)
        assert_equal @long_int_array_enum.cs253member?(10), @long_int_array.member?(10)
        assert_equal @str_array_enum.cs253member?("carp"), @str_array.member?("carp")
    end

    def test_cs253min
        # min return obj
        assert_equal @int_array_enum.cs253min, @int_array.min
        assert_equal @long_int_array_enum.cs253min, @long_int_array.min
        assert_equal @str_array_enum.cs253min, @str_array.min
        # min{|a,b| block} return obj
        assert_equal @int_array_enum.cs253min{|x,y| x.to_i <=> y.to_i}, @int_array.min{|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253min{|x,y| x.to_i <=> y.to_i}, @long_int_array.min{|x,y| x.to_i <=> y.to_i}
        # min(n) return array
        assert_equal @int_array_enum.cs253min(1), @int_array.min(1)
        assert_equal @long_int_array_enum.cs253min(1), @long_int_array_enum.min(1)
        assert_equal @int_array_enum.cs253min(2), @int_array.min(2)
        assert_equal @long_int_array_enum.cs253min(5), @long_int_array_enum.min(5)
        # min(){|a,b| blcok} return array
        assert_equal @int_array_enum.cs253min(1){|x,y| x.to_i <=> y.to_i}, @int_array.min(1){|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253min(1){|x,y| x.to_i <=> y.to_i}, @long_int_array_enum.min(1){|x,y| x.to_i <=> y.to_i}
        assert_equal @int_array_enum.cs253min(2){|x,y| x.to_i <=> y.to_i}, @int_array.min(2){|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253min(5){|x,y| x.to_i <=> y.to_i}, @long_int_array_enum.min(5){|x,y| x.to_i <=> y.to_i}
    end

    def test_cs253min_by
        assert_equal @int_array_enum.cs253min_by(1){|x| x.to_i}, @int_array.min_by(1) {|x| x.to_i}
        assert_equal @int_array_enum.cs253min_by(1) {|x| x.ord}, @int_array.min_by(1) {|x| x.ord}
        assert_equal @long_int_array_enum.cs253min_by(1) {|x| x.ord}, @long_int_array.min_by(1) {|x| x.ord}
    end

    def test_cs253minmax
        assert_equal @int_array_enum.cs253minmax, @int_array.minmax
        assert_equal @long_int_array_enum.cs253minmax, @long_int_array_enum.minmax
        assert_equal @int_array_enum.cs253minmax{|x,y| x.to_i <=> y.to_i}, @int_array.minmax{|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253minmax{|x,y| x.to_i <=> y.to_i}, @long_int_array_enum.minmax{|x,y| x.to_i <=> y.to_i}
        assert_equal @int_array_enum.cs253minmax{|x,y| x.to_i <=> y.to_i}, @int_array.minmax{|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253minmax{|x,y| x.to_i <=> y.to_i}, @long_int_array_enum.minmax{|x,y| x.to_i <=> y.to_i}
    end

    def test_cs253minmax_by
        assert_equal @int_array_enum.cs253minmax_by{|x| x.to_i}, @int_array.minmax_by {|x| x.to_i}
        assert_equal @int_array_enum.cs253minmax_by {|x| x.ord}, @int_array.minmax_by {|x| x.ord}
        assert_equal @long_int_array_enum.cs253minmax_by {|x| x.ord}, @long_int_array.minmax_by {|x| x.ord}
    end

    def test_cs253none?
        assert_equal @int_array_enum.cs253none? { |e| e.even? }, @int_array.none? { |e| e.even? }
        assert_equal @int_array_enum.cs253none? { |e| e < 4 }, @int_array.none?{ |e| e < 4 } 
        assert_equal @long_int_array_enum.cs253none? { |e| e.even? }, @long_int_array.none? { |e| e.even? }
        assert_equal @long_int_array_enum.cs253none? { |e| e < 4 }, @long_int_array.none?{ |e| e < 4 }   
        assert_equal @str_array_enum.cs253none? { |e| e.length < 5 }, @str_array.none?{ |e| e.length < 5 }    
    end 

    def test_cs253one?
        assert_equal @int_array_enum.cs253one? { |e| e.even? }, @int_array.one? { |e| e.even? }
        assert_equal @int_array_enum.cs253one? { |e| e < 4 }, @int_array.one?{ |e| e < 4 } 
        assert_equal @long_int_array_enum.cs253one? { |e| e.even? }, @long_int_array.one? { |e| e.even? }
        assert_equal @long_int_array_enum.cs253one? { |e| e < 4 }, @long_int_array.one?{ |e| e < 4 }   
        assert_equal @str_array_enum.cs253one? { |e| e.length < 5 }, @str_array.one?{ |e| e.length < 5 }    
    end 

    def test_cs253partition
        assert_equal @int_array_enum.cs253partition { |e| e.even? }, @int_array.partition { |e| e.even? }
        assert_equal @int_array_enum.cs253partition { |e| e < 4 }, @int_array.partition{ |e| e < 4 } 
        assert_equal @long_int_array_enum.cs253partition { |e| e.even? }, @long_int_array.partition { |e| e.even? }
        assert_equal @long_int_array_enum.cs253partition { |e| e < 4 }, @long_int_array.partition{ |e| e < 4 }   
        assert_equal @str_array_enum.cs253partition { |e| e.length < 5 }, @str_array.partition{ |e| e.length < 5 }    
    end

    def test_cs253reduce
        # test for reduce with no block
        assert_equal @int_array_enum.cs253reduce("+"), @int_array.reduce("+")
        assert_equal @int_array_enum.cs253reduce("*"), @int_array.reduce("*")
        assert_equal @long_int_array_enum.cs253reduce("+"), @long_int_array.reduce("+")
        assert_equal @long_int_array_enum.cs253reduce("-"), @long_int_array.reduce("-")
        assert_equal @int_array_enum.cs253reduce(0,"+"), @int_array.reduce(0,"+")
        assert_equal @int_array_enum.cs253reduce(1,"*"), @int_array.reduce(1,"*")
        assert_equal @int_array_enum.cs253reduce(2,"*"), @int_array.reduce(2,"*")
        assert_equal @int_array_enum.cs253reduce(24,"/"), @int_array.reduce(24,"/")
        assert_equal @long_int_array_enum.cs253reduce(1,"+"), @long_int_array.reduce(1,"+")
        assert_equal @long_int_array_enum.cs253reduce(3,"-"), @long_int_array.reduce(3,"-")

        #test for reduce with block
        arr_1 = [1,2,3,4]
        arr_1_result = 10

        arr_2 = [1,2,3,4]
        arr_2_result = 24

        arr_3 = [5,6,7,8,9,10]
        arr_3_result = 151200

        test1 = CS253Array.new(arr_1)
        test2 = CS253Array.new(arr_2)
        test3 = CS253Array.new(arr_3)
        
        
        assert_equal test1.cs253reduce(0) {|sum, e| sum+e}, arr_1_result
        assert_equal arr_1.reduce(0) {|sum, e| sum+e}, arr_1_result

        assert_equal test2.cs253reduce(1) {|product, e| product*e}, arr_2_result
        assert_equal arr_2.reduce(1) {|product, e| product*e}, arr_2_result

        assert_equal test3.cs253reduce(1) {|product, e| product*e}, arr_3_result
        assert_equal arr_3.reduce(1) {|product, e| product*e}, arr_3_result
    end

    def test_cs253reject
        assert_equal @long_int_array_enum.cs253reject { |num| num.even?}, @long_int_array.reject { |num| num.even?}
        assert_equal @long_int_array_enum.cs253reject { |num| num.odd?}, @long_int_array.reject { |num| num.odd?}
        assert_equal @long_int_array_enum.cs253reject { |letter| letter =~ /[aeiou]/}, @long_int_array.reject{ |letter| letter =~ /[aeiou]/}        
    end

    def test_cs253reverse_each
        assert_equal @int_array_enum.cs253reverse_each{ |e| p e}, @int_array_enum
        assert_equal @long_int_array_enum.cs253reverse_each{ |e| p e}, @long_int_array_enum
        assert_equal @twod_array_enum.cs253reverse_each{ |e| p e}, @twod_array_enum
    end

    def test_cs253select
        assert_equal @long_int_array_enum.cs253select { |num| num.even?}, @long_int_array.select { |num| num.even?}
        assert_equal @long_int_array_enum.cs253select { |num| num.odd?}, @long_int_array.select { |num| num.odd?}
        assert_equal @long_int_array_enum.cs253select { |letter| letter =~ /[aeiou]/}, @long_int_array.select{ |letter| letter =~ /[aeiou]/}
    end

    def test_cs253slice_after
        # test for pattern
        assert_equal @str_array_enum.cs253slice_after("captions"), @str_array.slice_after("captions").to_a
        assert_equal @str_array_enum.cs253slice_after("carp"), @str_array.slice_after("carp").to_a
        assert_equal @long_int_array_enum.cs253slice_after(1..3), @long_int_array.slice_after(1..3).to_a
        assert_equal @int_array_enum.cs253slice_after(1..3), @int_array.slice_after(1..3).to_a
        assert_equal @long_int_array_enum.cs253slice_after(2..3), @long_int_array.slice_after(2..3).to_a
        # test for block  
        assert_equal @str_array_enum.cs253slice_after{ |e| e.length < 5 }, @str_array.slice_after{ |e| e.length < 5 }.to_a
        assert_equal @long_int_array_enum.cs253slice_after{ |num| num.even?}, @long_int_array.slice_after{ |num| num.even?}.to_a
        assert_equal @int_array_enum.cs253slice_after{ |num| num.even?}, @int_array.slice_after{ |num| num.even?}.to_a
    end

    def test_cs253slice_before
        # test for pattern
        assert_equal @str_array_enum.cs253slice_before("captions"), @str_array.slice_before("captions").to_a
        assert_equal @str_array_enum.cs253slice_before("carp"), @str_array.slice_before("carp").to_a
        assert_equal @long_int_array_enum.cs253slice_before(1..3), @long_int_array.slice_before(1..3).to_a
        assert_equal @int_array_enum.cs253slice_before(1..3), @int_array.slice_before(1..3).to_a
        assert_equal @long_int_array_enum.cs253slice_before(2..3), @long_int_array.slice_before(2..3).to_a
        # test for block
        assert_equal @str_array_enum.cs253slice_before{ |e| e.length < 5 }, @str_array.slice_before{ |e| e.length < 5 }.to_a
        assert_equal @long_int_array_enum.cs253slice_before{ |num| num.even?}, @long_int_array.slice_before{ |num| num.even?}.to_a
        assert_equal @int_array_enum.cs253slice_before{ |num| num.even?}, @int_array.slice_before{ |num| num.even?}.to_a
    end

    def test_cs253slice_when
        assert_equal @int_array_enum.cs253slice_when { |i,j| i<j }, @int_array.slice_when { |i,j| i<j }.to_a
        assert_equal @long_int_array_enum.cs253slice_when { |i,j| i<j }, @long_int_array.slice_when { |i,j| i<j }.to_a
        assert_equal @long_int_array_enum.cs253slice_when { |i,j| i>j+1 }, @long_int_array.slice_when { |i,j| i>j+1 }.to_a
        assert_equal @str_array_enum.cs253slice_when { |i,j| i.length<j.length }, @str_array.slice_when { |i,j| i.length<j.length }.to_a        
    end

    def test_cs253sort
        assert_equal @int_array_enum.cs253sort{|x,y| x.to_i <=> y.to_i}, @int_array.sort{|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253sort{|x,y| x.to_i <=> y.to_i}, @long_int_array_enum.sort{|x,y| x.to_i <=> y.to_i}
        assert_equal @int_array_enum.cs253sort{|x,y| x.to_i <=> y.to_i}, @int_array.sort{|x,y| x.to_i <=> y.to_i}
        assert_equal @long_int_array_enum.cs253sort{|x,y| x.to_i <=> y.to_i}, @long_int_array_enum.sort{|x,y| x.to_i <=> y.to_i}     
    end

    def test_cs253sort_by
        assert_equal @int_array_enum.cs253sort_by {|x| x.to_i}, @int_array.sort_by {|x| x.to_i}
        assert_equal @int_array_enum.cs253sort_by {|x| x.ord}, @int_array.sort_by {|x| x.ord}
        assert_equal @long_int_array_enum.cs253sort_by {|x| x.ord}, @long_int_array.sort_by {|x| x.ord}
        assert_equal @str_array_enum.cs253sort_by {|x| x.length}, @str_array.sort_by {|x| x.length}
    end

    def test_cs253sum
        assert_equal @int_array_enum.cs253sum(1){|x| x}, 7
        assert_equal @int_array_enum.cs253sum(0) {|x| x*2}, 12
        assert_equal @int_array_enum.cs253sum(1) {|x| x*2}, 13
        assert_equal @long_int_array_enum.cs253sum(1) {|x| x.ord}, 38
    end
    
    def test_cs253take
        assert_equal @long_int_array_enum.cs253take(2), @long_int_array.take(2)
        assert_equal @long_int_array_enum.cs253take(1), @long_int_array.take(1)
        assert_equal @long_int_array_enum.cs253take(0), @long_int_array.take(0)
        assert_equal @long_int_array_enum.cs253take(10), @long_int_array.take(10)
        assert_equal @str_array_enum.cs253take(2), @str_array.take(2)
    end

    def test_cs253take_while
        assert_equal @long_int_array_enum.cs253take_while{ |i| i<3 }, @long_int_array.take_while{ |i| i<3 }.to_a
        assert_equal @long_int_array_enum.cs253take_while{ |i| i<2 }, @long_int_array.take_while{ |i| i<2 }.to_a
        assert_equal @str_array_enum.cs253take_while{ |i| i.length<6 }, @str_array.take_while{ |i| i.length<6 }.to_a
    end

    def test_cs253to_a 
        assert_equal @int_array_enum.cs253to_a,@int_array.to_a
        assert_equal @twod_array_enum.cs253to_a,@twod_array.to_a
        assert_equal @empty_int_array_enum.cs253to_a,@empty_int_array.to_a
        assert_equal @str_array_enum.cs253to_a,@str_array.to_a
    end

    def test_cs253to_h
        assert_equal @hash_array_enum.cs253to_h, @hash_array.to_h
    end

    def test_cs253uniq 
        assert_equal @int_array_enum.cs253uniq, @int_array.uniq
        assert_equal @str_array_enum.cs253uniq, @str_array.uniq
        assert_equal @long_int_array_enum.cs253uniq, @long_int_array.uniq
    end

    def test_cs253zip
        a = [1,2,3,4]
        b = [5,10,15,20]
        c = [6,11,16,21]
        enum_a = CS253Array.new([1,2,3,4])
        enum_b = CS253Array.new([5,10,15,20])
        enum_c = CS253Array.new([6,11,16,21])

        assert_equal enum_a.cs253zip(enum_b),a.zip(b)
        assert_equal enum_b.cs253zip(enum_a),b.zip(a)
        assert_equal enum_a.cs253zip(enum_b,enum_c),a.zip(b,c)
    end

    def test_cs253length
        assert_equal @int_array_enum.cs253length,@int_array.length
        assert_equal @twod_array_enum.cs253length,@twod_array.length
        assert_equal @empty_int_array_enum.cs253length,@empty_int_array.length
        assert_equal @str_array_enum.cs253length,@str_array.length
    end

end



