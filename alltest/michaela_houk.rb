require 'minitest/autorun'
require './cs253Array.rb'
require '../cs253_enum/cs253Enum.rb'
require './triple.rb'

class CS253EnumTests < Minitest::Test
    def test_all?
    	int_triple = CS253Array.new([nil, 2, 3])
        empty_array = CS253Array.new([])
        string_triple = CS253Array.new(["hello", "", "banana"])

        assert_equal false, int_triple.cs253all? {|e| e}
        assert_equal true, empty_array.cs253all? {|e| e.size == 5}
        assert_equal false, string_triple.cs253all? {|e| e[0] == 'h'}
      	assert_equal true, string_triple.cs253all? {|e| e.length < 10}	
    end

    def test_any?
    	string_triple = CS253Array.new(["hello", "", "banana"])
        empty_array = CS253Array.new([])
        mixed_triple = CS253Array.new(["yo", 2, 3])

        assert_equal true, mixed_triple.cs253any? {|e| e%3 ==0}
    	assert_equal true, string_triple.cs253any? {|e| e.size == 0}
        assert_equal false, empty_array.cs253any? {|e| e.size == 0}
    end

    def test_chunk
    	int_triple = CS253Array.new([1, 2, 3])
        empty_array = CS253Array.new([])
        string_many = CS253Array.new(["words", "words", "clam", "shark", "morewords"])

    	assert_equal [[false, [1]], [true, [2]], [false, [3]]], int_triple.cs253chunk {|e| e.even?}
        assert_equal [], empty_array.cs253chunk {|e| e.size}
        assert_equal [[5, ["words", "words"]], [4, ["clam"]], [5, ["shark"]], [9, ["morewords"]]], string_many.cs253chunk {|e| e.length}
    end

    def test_chunk_while
    	int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])
        string_many = CS253Array.new(["words", "clam", "shark", "morewords", "words"])

    	assert_equal [[1, 2, 4, 9, 10, 11, 12, 15, 16, 19, 20, 21],[4],[3]], int_many.cs253chunk_while {|i, j| i < j}
        assert_equal [], empty_array.cs253chunk_while {|i, j| i < j}
        assert_equal [["words"], ["clam", "shark", "morewords"], ["words"]], string_many.cs253chunk_while {|i, j| i.length < j.length}
    end

    def test_collect
	    string_triple = CS253Array.new(["this", "is", "an", "array"])
    	int_array = CS253Array.new([[1,2],[3,4]])
        empty_array = CS253Array.new([])

    	assert_equal  [[1,2,100], [3,4,100]], int_array.cs253collect {|e| e + [100]}
        assert_equal [], empty_array.cs253collect {|e| e + [100]} 
	    assert_equal [4, 2, 2, 5], string_triple.cs253collect {|e| e.length}
    end

    def test_collect_concat
    	int_triple = CS253Array.new([1, 2, 3])
    	int_array = CS253Array.new([[1,2],[3,4]])
    	int_quadruple = CS253Array.new([1, [2,3], 3, 4])
    	int_complicated = CS253Array.new([[1, 2, 100], [3, 4, 100], [[1, 2], [3, 4]]])
        empty_array = CS253Array.new([])

    	assert_equal [1,2,3], int_triple.cs253collect_concat{|e| e}
    	assert_equal [1, 2, 100, 100, 3, 4, 100, 100, [1, 2], [3, 4], 100], int_complicated.cs253collect_concat { |e| e + [100] }
    	assert_equal [1, 2, 100, 3, 4, 100], int_array.cs253collect_concat {|e| e + [100]} 
    	assert_equal [1, 2, 3, 3, 4], int_quadruple.cs253collect_concat {|e| e} 
        assert_equal [], empty_array.cs253collect_concat {|e| e.size==0}
    end

    def test_count
    	int_many = CS253Array.new([1, 2, 3, 2, 0, 2])
    	string_triple = CS253Array.new(["hello", "", "banana"])
        empty_array = CS253Array.new([])

    	assert_equal 4, int_many.cs253count {|e| e%2 == 0}
    	assert_equal 3, int_many.cs253count(2)
    	assert_equal 6, int_many.cs253count
    	assert_equal 3, string_triple.cs253count
    	assert_equal 1, string_triple.cs253count("")
    	assert_equal 1, string_triple.cs253count {|e| e.length == 0}
        assert_equal 0, empty_array.cs253count
        assert_equal 0, empty_array.cs253count {|e| e.length % 5 ==0}
    end

    def test_cycle
    	int_triple = CS253Array.new([1, 2, 3])
        empty_array = CS253Array.new([])
        string_many = CS253Array.new(["words", "clam", "shark", "morewords", "words"])

        answer = []
        int_triple.cs253cycle(4) {|e| answer << e}
    	assert_equal [1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3], answer 
        answer = []
        empty_array.cs253cycle(100) {|e| answer << e}
        assert_equal [], answer
        answer = []
        string_many.cs253cycle(1) {|e| answer << e}
        assert_equal ["words", "clam", "shark", "morewords", "words"], answer

    end

    def test_detect
    	int_triple = CS253Array.new([1, 2, 3])
	    string_many = CS253Array.new(["words", "clam", "shark", "morewords", "words"])
        empty_array = CS253Array.new([])

    	assert_equal 1, int_triple.cs253detect {|e| e < 3}
	    assert_equal "clam", string_many.cs253detect {|e| e[0] == 'c'}
        assert_nil int_triple.cs253detect {|e| e % 3 == 0 && e > 3}
        assert_nil empty_array.cs253detect {|e| e.size == 5}
    end

    def test_drop
    	int_triple = CS253Array.new([1, 2, 3])
        empty_array = CS253Array.new([])
	    string_triple = CS253Array.new(["reindeer", "pancake", "bowl"])

    	assert_equal [], int_triple.cs253drop(3)
        assert_equal [], empty_array.cs253drop(100)
        assert_equal ["pancake", "bowl"], string_triple.drop(1)
        assert_equal ["bowl"], string_triple.drop(2)
    end

    def test_drop_while
    	int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])
        string_triple = CS253Array.new(["zach", "michaela","jackson"])

    	assert_equal [], int_many.cs253drop_while {|e| e >= 1}
        assert_equal [9, 10, 11, 12, 15, 16, 19, 20, 21, 4, 3], int_many.cs253drop_while {|e| e <= 4}
        assert_equal [], empty_array.cs253drop_while {|e| e.size > 450}
        assert_equal ["michaela", "jackson"], string_triple.cs253drop_while {|e| e.length < 8}
    end

    def test_each_cons
    	int_many = CS253Array.new([1, 2, 3, 100, 10])
        empty_array = CS253Array.new([])

        answer = []
        int_many.cs253each_cons(5) {|e| answer << e}
        assert_equal [[1, 2, 3, 100, 10]], answer
        answer = []
        int_many.cs253each_cons(2) {|e| answer << e.size}
    	assert_equal [2, 2, 2, 2], answer
        answer = []
        empty_array.cs253each_cons(4) {|e| answer << e.size}
        assert_equal [], answer
    end

   	class Foo
		include CS253Enumerable		
		def each
			yield "hey"
			yield 100, 22
			yield
		end
	end

    class Bar
        include CS253Enumerable     
        def each
            yield 600, 7, 9, 22, 3
        end
    end

    def test_each_entry
        answer = []
        Foo.new.cs253each_entry{|e| answer << e}
		assert_equal ["hey", [100,22], nil], answer
        answer = []
        Foo.new.cs253each_entry {|e| answer << e.respond_to?('each')}
        assert_equal [false, true, false], answer
        answer = []
        Bar.new.cs253each_entry {|e| answer << e}
        assert_equal [[600, 7, 9, 22, 3]], answer
    end

    def test_each_slice
    	int_many = CS253Array.new([1, 2, 3, 100, 10])
        empty_array = CS253Array.new([])

        answer = []
        int_many.cs253each_slice(30) {|e| answer << e}
    	assert_equal [[1, 2, 3, 100, 10]], answer
        answer = []
        empty_array.cs253each_slice(10) {|e| answer << e}
        assert_equal [], answer
        answer = []
        int_many.cs253each_slice(2) {|e| answer << (e + [10])}
        assert_equal [[1, 2, 10], [3, 100, 10], [10, 10]], answer
    end

    def test_each_with_index
        int_many = CS253Array.new([1, 2, 3, 100, 10])
        empty_array = CS253Array.new([])
        string_triple = CS253Array.new(["hello", "", "banana"])

        assert_equal [1, 2, 3, 100, 10], int_many.cs253each_with_index {|e, i| e}
        assert_equal [], empty_array.cs253each_with_index {|e, i| p e}
        answer = []
        string_triple.cs253each_with_index {|e, i| answer << e.length * i}
        assert_equal [0, 0, 12], answer
    end

    def test_each_with_object
        int_many = CS253Array.new([1, 2, 3, 100, 10])
        empty_array = CS253Array.new([])
        string_triple = CS253Array.new(["hello", "", "banana"])

        assert_equal [2,4,6,200,20], int_many.cs253each_with_object([]) {|e, o| o << e*2}
        assert_equal [], empty_array.cs253each_with_object([]) {|e, i| p "e: #{e} i: #{i}"}
        assert_equal ["hello", "", "banana"], string_triple.cs253each_with_object([]) {|e, o| o << e}
    end

    def test_entries
        string_triple = CS253Array.new(["hello", "", "banana"])
        empty_array = CS253Array.new([])
        int_many = CS253Array.new([1, 2, 7, 5, 5, 8, 10])

        assert_equal [1, 2, 7, 5, 5, 8, 10], int_many.cs253entries
        assert_equal ["hello", "", "banana"], string_triple.cs253entries
        assert_equal [], empty_array.cs253entries
    end

    def test_find
        int_triple = CS253Array.new([1, 2, 3])
        string_many = CS253Array.new(["strings", "are", "hard", "to", "think", "of"])
        empty_array = CS253Array.new([])

        assert_equal 1, int_triple.cs253find {|e| e < 3}
        assert_nil empty_array.cs253find {|e| e.size == 5}
        assert_equal "are", string_many.cs253find {|e| e.size % 3 != 1}
    end

    def test_find_all
        int_triple = CS253Array.new([1, 2, 3])
        empty_array = CS253Array.new([]) 
        string_many = CS253Array.new(["strings", "are", "hard", "to", "think", "of"])


        assert_equal [], int_triple.cs253find_all {|e| e > 3}
        assert_equal [], empty_array.cs253find_all {|e| e.size ==5}
        assert_equal ["strings", "hard"], string_many.cs253find_all {|e| e.size % 3 == 1}
    end

    def test_find_index
        int_many = CS253Array.new([1, 2, 3, 100, 10])
        empty_array = CS253Array.new([])

        assert_nil int_many.cs253find_index {|e| e > 100}
        assert_equal 3, int_many.cs253find_index {|e| e > 3}
        assert_nil empty_array.cs253find_index {|e| e > 3}
    end

    def test_first
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal 1, int_many.cs253first
        assert_equal [1,2,4,9,10,11,12,15,16,19,20,21,4,3], int_many.cs253first(100)
        #assert_nil empty_array.cs253first
        #assert_equal [], empty_array.cs253first(2)
    end

    def test_flat_map
        int_triple = CS253Array.new([1, 2, 3])
        int_array = CS253Array.new([[1,2],[3,4]])
        int_quadruple = CS253Array.new([1, [2,3], 3, 4])
        int_complicated = CS253Array.new([[1, 2, 100], [3, 4, 100], [[1, 2], [3, 4]]])
        empty_array = CS253Array.new([])

        assert_equal [1,2,3], int_triple.cs253collect_concat{|e| e}
        assert_equal [1, 2, 100, 100, 3, 4, 100, 100, [1, 2], [3, 4], 100], int_complicated.cs253collect_concat { |e| e + [100] }
        assert_equal [1, 2, 100, 3, 4, 100], int_array.cs253collect_concat { |e| e + [100] } 
        assert_equal [1, 2, 3, 3, 4], int_quadruple.cs253collect_concat { |e| e }
        assert_equal [], empty_array.cs253flat_map {|e| e.size==0} 
    end

    def test_grep
        string_many = CS253Array.new(["weee", "wham", "whoo", "wherever", "wegmans"])
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal [8], string_many.cs253grep(/whe/) {|e| e.length}
        assert_equal [], string_many.cs253grep(/whem/) {|e| e.length}
        assert_equal [1, 2, 4, 9, 10, 11, 12, 4, 3], int_many.cs253grep(1...15) {|e| e}
        assert_equal [], empty_array.cs253grep(1...15) 
    end

    def test_grep_v
        string_many = CS253Array.new(["weee", "wham", "whoo", "wherever", "wegmans"])
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal [4, 4, 4, 7], string_many.cs253grep_v(/whe/) {|e| e.length}
        assert_equal [4, 4, 4, 8, 7], string_many.cs253grep_v(/whem/) {|e| e.length}
        assert_equal [15, 16, 19, 20, 21], int_many.cs253grep_v(1...15) {|e| e}
        assert_equal [], empty_array.cs253grep_v(1...15) {|e| e}
    end

    def test_group_by
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])
        string_many = CS253Array.new(["beee", "wham", "whoo", "wherever", "wegmans"])


        answer = {1 => [1, 4, 10, 16, 19, 4], 2 => [2, 11, 20], 0 => [9, 12, 15, 21, 3]}
        assert_equal answer, int_many.cs253group_by {|e| e % 3} 
        answer = Hash.new
        assert_equal answer, empty_array.cs253group_by {|e| e % 3}
        answer = {"b"=>["beee"], "w"=>["wham", "whoo", "wherever", "wegmans"]}
        assert_equal answer, string_many.cs253group_by {|e| e[0]}
    end

    def test_include?
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal false, int_many.cs253include?(100)
        assert_equal true, int_many.cs253include?(12)
        assert_equal false, empty_array.cs253include?([1,2])
    end

    def test_inject
        string_triple = CS253Array.new(["bee", "banoodle", "stinky"])
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal 17, string_triple.cs253inject(0) {|sum, e| sum + e.length}
        assert_equal 1, empty_array.cs253inject(1) {|sum, e| sum + e.length}
        assert_nil empty_array.cs253inject {|sum, e| sum + e.length}
        assert_equal 11, int_many.cs253inject(4) {|sum, e| sum + e%2}
    end

    def test_map
        int_array = CS253Array.new([[1,2],[3,4]])
        empty_array = CS253Array.new([])
        string_triple = CS253Array.new(["this", "is", "an", "array"])

        
        assert_equal  [[1,2,100], [3,4,100]], int_array.cs253map {|e| e + [100]}
        assert_equal [], empty_array.cs253map {|e| e + [100]} 
        assert_equal [4, 2, 2, 5], string_triple.cs253map {|e| e.length}
    end

    def test_max
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        string_many = CS253Array.new(["weee", "wham", "whoo", "wherever", "wegmans"])
        empty_array = CS253Array.new([])

        assert_equal "whoo", string_many.cs253max
        assert_equal [30, 21, 20, 19, 19, 16, 15, 12, 11, 10, 9, 7, 4, 3], int_many.cs253max(100) {|a, b| a <=> b} 
        assert_equal 30, int_many.cs253max {|a, b| a <=> b}
        assert_equal [3, 4, 7, 9], int_many.cs253max(4) {|a, b| b <=> a} 
        assert_equal 3, int_many.cs253max {|a, b| b <=> a}
        assert_equal [3, 4, 7, 9, 10, 11, 12, 15, 16, 19, 19, 20, 21, 30], int_many.cs253max(14) {|a, b| b <=> a}
        assert_equal 30, int_many.cs253max 
        assert_nil empty_array.cs253max
    end

    def test_max_by
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        string_many = CS253Array.new(["weee", "wham", "whoo", "wherever", "wegmans"])
        empty_array = CS253Array.new([])

        assert_equal [20, 11, 4, 19, 16, 10, 7, 19, 3, 21, 15, 12, 9, 30], int_many.cs253max_by(100) {|i| i%3} 
        assert_equal "whoo", string_many.cs253max_by {|e| e}
        assert_nil empty_array.cs253max_by {|e| e.length}
    end

    def test_member?
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal false, int_many.cs253member?(100)
        assert_equal true, int_many.cs253member?(12)
        assert_equal false, empty_array.cs253member?([1,2])
    end

    def test_min
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        string_many = CS253Array.new(["weee", "wham", "whoo", "wherever", "wegmans"])
        empty_array = CS253Array.new([])

        assert_equal "weee", string_many.cs253min
        assert_equal ["weee", "wegmans", "wham", "wherever", "whoo"], string_many.cs253min(6)
        assert_equal [3, 4, 7, 9, 10, 11, 12, 15, 16, 19, 19, 20, 21, 30], int_many.cs253min(100) {|a, b| a <=> b} 
        #assert_equal int_many.cs253min(1), int_many.cs253min {|a, b| a <=> b}
        assert_nil empty_array.cs253min
    end

    def test_min_by
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        string_many = CS253Array.new(["weee", "wham", "whoo", "wherever", "wegmans"])
        empty_array = CS253Array.new([])


        assert_equal [30, 9, 12, 15, 21, 3, 19, 7, 10, 16, 19, 4, 11, 20], int_many.cs253min_by(100) {|i| i%3} 
        assert_equal ["weee", "wegmans"], string_many.cs253min_by(2) {|word| word}
        assert_nil empty_array.cs253min_by {|e| e.length}
    end

    def test_minmax
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        int_single = CS253Array.new([5])
        empty_array = CS253Array.new([])


        assert_equal [3, 30], int_many.cs253minmax{|a,b| a <=> b}
        assert_equal int_many.cs253minmax, int_many.cs253minmax{|a,b| a <=> b}
        assert_equal [nil, nil], empty_array.cs253minmax
        assert_equal [5, 5], int_single.cs253minmax

    end

    def test_minmax_by
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        string_many = CS253Array.new(["banana", "ape", "monkey", "human", "apple", "bananagram"])
        int_single = CS253Array.new([5])
        empty_array = CS253Array.new([])

        #assert_equal [30, 20], int_many.cs253minmax_by {|i| i%3}
        assert_equal ["ape", "bananagram"], string_many.cs253minmax_by {|word| word.length}
        assert_equal [nil, nil], empty_array.cs253minmax_by {|i| i.size}
    end

    def test_none?
        string_triple = CS253Array.new(["hello", "", "banana"])
        empty_array = CS253Array.new([])
        assert_equal false, string_triple.cs253none? {|i| i.size == 0}
        assert_equal true, string_triple.cs253none? {|i| i.size > 6}
        assert_equal true, empty_array.cs253none? {|i| i.size == 5}
    end

    def test_one?
        string_triple = CS253Array.new(["hello", "", "banana"])
        empty_array = CS253Array.new([])

        assert_equal true, string_triple.cs253one? {|i| i.size == 0}
        assert_equal false, string_triple.cs253one? {|i| i}
        assert_equal false, empty_array.cs253one? {|i| i.size == 0}
    end

    def test_partition
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        string_many = CS253Array.new(["banana", "ape", "monkey", "human", "apple", "bananagram"])
        empty_array = CS253Array.new([])

        assert_equal [[30, 9, 12, 15, 21, 3], [19, 11, 7, 10, 16, 19, 20, 4]], int_many.cs253partition {|i| i%3==0}
        assert_equal [[], []], empty_array.cs253partition {|i| i%3==0}
        assert_equal [["banana", "monkey", "bananagram"], ["ape", "human", "apple"]], string_many.cs253partition {|e| e.length % 2 == 0}
    end

    def test_reduce
        string_triple = CS253Array.new(["bee", "banoodle", "stinky"])
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal 17, string_triple.cs253reduce(0) {|sum, e| sum + e.length}
        assert_equal 1, empty_array.cs253reduce(1) {|sum, e| sum + e.length}
        assert_nil empty_array.cs253reduce {|sum, e| sum + e.length}
        assert_equal 11, int_many.cs253reduce(4) {|sum, e| sum + e%2}
    end

    def test_reject
        string_triple = CS253Array.new(["bee", "banoodle", "stinky"])
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal ["stinky"], string_triple.cs253reject {|word| word[0] == 'b'}
        assert_equal [], empty_array.cs253reject {|i| i<4}
        assert_equal [1, 9, 11, 15, 19, 21, 3], int_many.cs253reject {|i| i%2 == 0}
    end

    def test_reverse_each
        string_triple = CS253Array.new(["bee", "banoodle", "stinky"])
        empty_array = CS253Array.new([])
        int_many = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21,4,3])

        a = []
        string_triple.cs253reverse_each {|e| a << e}
        assert_equal ["stinky", "banoodle", "bee"], a
        a = []
        empty_array.cs253reverse_each {|e| a << e}
        assert_equal [], a
        a = []
        int_many.cs253reverse_each {|e| a << e}
        assert_equal [3, 4, 21, 20, 19, 16, 15, 12, 11, 10, 9, 4, 2, 1], a
    end

    def test_select
        int_triple = CS253Array.new([1, 2, 3])
        string_triple = CS253Array.new(["bee", "banoodle", "stinky"])
        empty_array = CS253Array.new([])

        assert_equal [], int_triple.cs253select {|e| e > 3}
        assert_equal [], empty_array.cs253select {|e| e > 3}
        assert_equal ["banoodle", "stinky"], string_triple.cs253select {|e| e.length > 3}
        assert_equal [1, 3], int_triple.cs253select {|e| e%2==1}
    end

    # def test_slice_after
    #     string_triple = CS253Array.new(["bee", "banoodle", "stinky"])
    #     int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
    #     empty_array = CS253Array.new([])


    #     assert_equal [nil], empty_array.cs253slice_after(/a/) {|e| p e}
    #     assert_equal [["bee", "banoodle"], ["stinky"]], string_triple.cs253slice_after(/ba/) {|e| e}
    #     assert_equal [[30, 19, 11, 7], [9], [10], [12, 16, 15, 19, 20, 21, 4, 3]], int_many.cs253slice_after(5..10) {|e| e}
    # end

    # def test_slice_before
    #     string_triple = CS253Array.new(["bee", "banoodle", "stinky"])
    #     int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
    #     empty_array = CS253Array.new([])

    #     assert_equal [nil], empty_array.cs253slice_after(/a/) {|e| p e}
    #     assert_equal [["bee"], ["banoodle", "stinky"]], string_triple.cs253slice_before(/b/) {|e| e}
    #     assert_equal [[30, 19, 11], [7], [9], [10, 12, 16, 15, 19, 20, 21], [4], [3]], int_many.cs253slice_before(1..10) {|e| e}
    # end

    def test_slice_when
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        int_more = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21])
        empty_array = CS253Array.new([])

        assert_equal [[30], [19], [11], [7], [9], [10], [12], [16, 15], [19], [20], [21], [4, 3]], int_many.cs253slice_when {|i, j| j+1 != i}
        assert_equal [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]], int_more.cs253slice_when {|i, j| i+1 != j}
        assert_equal [], empty_array.cs253slice_when {|i, j| i.size > j.size}
    end

    def test_sort
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        string_many = CS253Array.new(["banana", "ape", "monkey", "human", "apple", "bananagram"])
        empty_array = CS253Array.new([])

        assert_equal [30, 21, 20, 19, 19, 16, 15, 12, 11, 10, 9, 7, 4, 3], int_many.cs253sort {|a, b| b <=> a}
        assert_equal [], empty_array.cs253sort {|a, b| a <=> b}
        assert_equal ["bananagram", "banana", "monkey", "human", "apple", "ape"], string_many.cs253sort {|a, b| b.length <=> a.length}
    end

    def test_sort_by
        string_many = CS253Array.new(["banana", "ape", "monkey", "human", "apple", "bananagram"])
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal ["ape", "human", "apple", "banana", "monkey", "bananagram"], string_many.cs253sort_by {|word| word.length}
        assert_equal ["ape", "apple", "banana", "bananagram", "human", "monkey"], string_many.cs253sort_by {|word| word}
        assert_equal [30, 10, 20, 11, 21, 12, 3, 4, 15, 16, 7, 19, 9, 19], int_many.cs253sort_by {|i| i%10}
        assert_equal [], empty_array.cs253sort_by {|e| e}
    end

    def test_sum
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        string_triple = CS253Array.new(["bee", "banoodle", "stinky"])
        empty_array = CS253Array.new([])

        assert_equal 196, int_many.cs253sum
        assert_equal 296, int_many.cs253sum(100)
        assert_equal 17, string_triple.cs253sum(0) {|e| e.length}
        assert_equal 0, empty_array.cs253sum {|e| e + 5}
    end

    def test_take
        int_many = CS253Array.new([30,19,11,7,9,10,12,16,15,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal [30,19,11,7,9,10,12,16,15,19,20,21,4,3], int_many.cs253take(100)
        assert_equal [], int_many.cs253take(0)
        assert_equal [], empty_array.cs253take(100)
    end

    def test_take_while
        int_many = CS253Array.new([3,19,11,7,9,10,12,16,15,19,20,21,4,3])
        empty_array = CS253Array.new([])

        assert_equal [], int_many.cs253take_while {|e| nil}
        assert_equal [3, 19], int_many.cs253take_while {|e| e%3 != 2}
        assert_equal [], empty_array.cs253take_while {|e| e%3 != 2}
    end

    def test_to_a
        triple = Triple.new(1, 2, 7)
        string_triple = CS253Array.new(["hello", "", "banana"])
        empty_array = CS253Array.new([])

        assert_equal ["hello", "", "banana"], string_triple.cs253to_a
        assert_equal [], empty_array.cs253to_a
        assert_equal [1, 2, 7], triple.cs253to_a
    end

    def test_to_h
        int_complicated = CS253Array.new([[1,2], ["hello", 4], [6, "bang"]])
        empty_array = CS253Array.new([])
        triple = Triple.new([1,2], [3,4], [5,6])

        answer = {1=>2, "hello"=>4, 6=>"bang"}
        assert_equal answer, int_complicated.cs253to_h
        answer = {}
        assert_equal answer, empty_array.cs253to_h
        answer = {1=>2, 3=>4, 5=>6}
        assert_equal answer, triple.cs253to_h
    end

    def test_uniq
        int_many = CS253Array.new([3,19,11,7,9,10,12,16,15,19,20,21,4,3])
        int_repeats = CS253Array.new([1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 3])
        string_repeats = CS253Array.new(["hello", "", "banana", "", "yo", "Hello"])
        empty_array = CS253Array.new([])


        assert_equal [3, 19, 11, 7, 9, 10, 12, 16, 15, 20, 21, 4], int_many.cs253uniq
        assert_equal [1, 2, 3], int_repeats.cs253uniq
        assert_equal ["hello", "", "banana", "yo", "Hello"], string_repeats.cs253uniq
        assert_equal [], empty_array.cs253uniq
    end

    def test_zip
        int_triple = CS253Array.new([1, 2, 3])
        int_double = CS253Array.new([4,5])
        string_single = CS253Array.new(["hello"])
        empty_array = CS253Array.new([])


        assert_equal [[1, 4, "hello"], [2, 5, nil], [3, nil, nil]], int_triple.cs253zip(int_double, string_single)
        assert_equal [["hello", 1, 4]], string_single.cs253zip(int_triple, int_double)
        assert_equal [], empty_array.zip(int_triple, int_double, string_single)
    end

    def test_triple
        triple = Triple.new(1, 2, 3)
        empty_triple = Triple.new

        result = [] 
        triple.each {|i| result << i}
        assert_equal [1,2,3], result

        result = [] 
        empty_triple.each {|i| result << i}
        assert_equal [nil,nil,nil], result
    end
end