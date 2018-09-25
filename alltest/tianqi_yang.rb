require 'minitest/autorun'
require './triple.rb'
require './cs253Array.rb'


class CS253EnumTests < Minitest::Test

	def setup  #setup some arrays for all methods
        @int_triple = Triple.new(156,803,336)

        @str_triple = Triple.new("grzkja","ojpamcknldrhgxn","em")

        @float_triple = Triple.new(0.2480833, 0.41273236668,0.0271322001)

        @bool_triple = Triple.new(nil, true, 99)
        @empty_triple = Triple.new()

    end

    def test_collect
        assert_equal ["156", "803", "336"],@int_triple.cs253collect{|i| i.to_s}
        assert_equal [6, 15, 2], @str_triple.cs253collect{|i| i.length}
        assert_equal [24.80833, 41.273236668, 2.71322001], @float_triple.cs253collect{|i| i*100}
    end
    
    def test_all
    	assert_equal false,@int_triple.cs253all?{|i| i%2 == 0}
        assert_equal false,@str_triple.cs253all?{|i| i.length>5}
        assert_equal true, @float_triple.cs253all?{|i| i.class == Float}
        assert_equal false, @bool_triple.cs253all?
        assert_equal false, @empty_triple.cs253all?
    end

    def test_any
        assert_equal true,@int_triple.cs253any?{|i| i%2 == 0}
        assert_equal true,@str_triple.cs253any?{|i| i.length>5}
        assert_equal true,@float_triple.cs253any?{|i| i.class == Float}
        assert_equal true,@bool_triple.cs253any?
        assert_equal false,@empty_triple.cs253any?
    end

    def test_chunk
    	assert_equal [[true, [156]], [false, [803]], [true, [336]]],@int_triple.cs253chunk{|i| i%2 == 0}
        assert_equal [[true, ["grzkja", "ojpamcknldrhgxn"]], [false, ["em"]]], @str_triple.cs253chunk{|i| i.length>5}
        assert_equal [[true, [0.2480833, 0.41273236668, 0.0271322001]]],@float_triple.cs253chunk{|i| i.class == Float}
    end

    def test_chunk_while
    	assert_equal [[156, 803], [336]],@int_triple.cs253chunk_while{|i| i%2 == 0}
        assert_equal [["grzkja", "ojpamcknldrhgxn", "em"]],@str_triple.cs253chunk_while{|i| i.length>5}
        assert_equal [[0.2480833, 0.41273236668, 0.0271322001]],@float_triple.cs253chunk_while{|i| i.class == Float}
    end

    def test_collect_concat
    	assert_equal [256, 903, 436],@int_triple.cs253collect_concat{|i| i + 100}
        assert_equal [[true, ["grzkja", "ojpamcknldrhgxn"]], [false, ["em"]]], @str_triple.cs253chunk{|i| i.length>5}
        assert_equal [[true, [0.2480833, 0.41273236668, 0.0271322001]]], @float_triple.cs253chunk{|i| i.class == Float}
        assert_equal [1, 2, 100, 3, 4, 100],CS253Array.new([[1, 2], [3, 4]]).cs253collect_concat{ |e| e + [100] } 
    end

    def test_count
    	assert_equal 2, @int_triple.cs253count{|i| i%2 == 0}
        assert_equal 2, @str_triple.cs253count{|i| i.length>5}
        assert_equal 3, @float_triple.cs253count{|i| i.class == Float}
    end

    def test_cycle
    	cs253a = []
    	a = [156, 803, 336, 156, 803, 336, 156, 803, 336, 156, 803, 336, 156, 803, 336]
    	@int_triple.cs253cycle(5){|e| cs253a << e}
    	#@int_triple.cycle(5){|e| a << e}
    	assert_equal cs253a,a
    	cs253b = []
    	b = [6, 15, 2, 6, 15, 2, 6, 15, 2, 6, 15, 2, 6, 15, 2]
        @str_triple.cs253cycle(5){|e| cs253b << e.length}
        #@str_triple.cycle(5){|e| b << e.length}
        assert_equal cs253b,b
        cs253c = []
        c = [24.80833, 41.273236668, 2.71322001, 24.80833, 41.273236668, 2.71322001, 24.80833, 41.273236668, 2.71322001, 24.80833, 41.273236668, 2.71322001, 24.80833, 41.273236668, 2.71322001]
        @float_triple.cs253cycle(5){|e| cs253c << e*100}
        #@float_triple.cycle(5){|e| c << e*100}
        assert_equal cs253c,c
    end

    def test_detect
    	assert_equal 156, @int_triple.cs253detect{|i| i%2 == 0}
        assert_equal "grzkja", @str_triple.cs253detect{|i| i.length>3}
        assert_equal 0.2480833, @float_triple.cs253detect{|i| i.class == Float}
    end

    def test_drop
    	n = 2
    	assert_equal [336],@int_triple.cs253drop(n)
        assert_equal ["em"],@str_triple.cs253drop(n)
        assert_equal [0.0271322001],@float_triple.cs253drop(n)
    end

    def test_drop_while
    	assert_equal [803, 336],@int_triple.cs253drop_while{|i| i%2 == 0}
        assert_equal ["em"],@str_triple.cs253drop_while{|i| i.length>5}
        assert_equal [],@float_triple.cs253drop_while{|i| i.class == Float}
    end

    def test_each_cons 
        cs253a = [] 
    	@int_triple.cs253each_cons(2){|e| cs253a << e}
    	#@int_triple.each_cons(2){|e| a << e}
    	assert_equal [[156, 803], [803, 336]],cs253a
    	cs253b = []
        @str_triple.cs253each_cons(2){|e| cs253b << e}
        #@str_triple.each_cons(2){|e| b << e}
        assert_equal [["grzkja", "ojpamcknldrhgxn"], ["ojpamcknldrhgxn", "em"]],cs253b
        cs253c = []
        @float_triple.cs253each_cons(2){|e| cs253c << e} #mode?
        #@float_triple.each_cons(2){|e| c << e}
        assert_equal [[0.2480833, 0.41273236668], [0.41273236668, 0.0271322001]],cs253c
    end

    class Foo 
        include Enumerable
        include CS253Enumerable
        def each
            yield 1
            yield 1, 2
            yield
        end
    end

    def test_each_entry
        #assert_equal [1, [1, 2], nil],Foo.new.cs253each_entry{ |o| o}.to_a 
        #assert_equal [156, 803, 336], @int_triple.cs253each_entry {|o| o}.to_a
        cs253r = []

        @str_triple.cs253each_entry {|o| cs253r << o}

        assert_equal ["grzkja", "ojpamcknldrhgxn", "em"],cs253r
        
    end

    def test_each_slice 
    	cs253a = []
        #a = [] 
    	@int_triple.cs253each_slice(2){|e| cs253a << e}
    	#@int_triple.each_slice(2){|e| a << e}
    	assert_equal [[156, 803], [336]],cs253a
    	cs253b = []
    	#b = []
        @str_triple.cs253each_slice(2){|e| cs253b << e}
        #@str_triple.each_slice(2){|e| b << e}
        assert_equal [["grzkja", "ojpamcknldrhgxn"], ["em"]],cs253b
        cs253c = []
        @float_triple.cs253each_slice(2){|e| cs253c << e} #mode?
        assert_equal [[0.2480833, 0.41273236668], [0.0271322001]],cs253c
    end

    def test_each_with_index
    	cs253a = []

    	@int_triple.cs253each_with_index{|i,e| cs253a <<[i.to_s,e]}
    	assert_equal [["156", 0], ["803", 1], ["336", 2]],cs253a
        
        cs253b = []
    	@str_triple.cs253each_with_index{|i,e| cs253b <<[i.length,e]}
        assert_equal [[6, 0], [15, 1], [2, 2]], cs253b

        cs253c = []
    	@float_triple.cs253each_with_index{|i,e| cs253c<<[i*100,e]}
    	assert_equal [[24.80833, 0], [41.273236668, 1], [2.71322001, 2]],cs253c
    end

    def test_each_with_object
    	assert_equal [312, 1606, 672],@int_triple.cs253each_with_object([]) { |i, a| a << i*2 }
    	assert_equal [6, 15, 2], @str_triple.cs253each_with_object([]) { |i, a| a << i.length }
        assert_equal [0.8083300000000015, 0.2732366680000027, 0.7132200100000001],@float_triple.cs253each_with_object([]) { |i, a| a << i*100%1}
    end

    def test_entries
    	assert_equal [156, 803, 336], @int_triple.cs253entries{|i| i.to_s}.to_a
        assert_equal ["grzkja", "ojpamcknldrhgxn", "em"],@str_triple.cs253entries{|i| i.length}
        assert_equal [0.2480833, 0.41273236668, 0.0271322001],@float_triple.cs253entries{|i| i*100}
    end

    def test_find
    	assert_equal 803,@int_triple.cs253find{|i| i%2 != 0}
        assert_equal "grzkja",@str_triple.cs253find{|i| i.length>3}
        assert_equal 0.2480833,@float_triple.cs253find{|i| i.class == Float}
    end

    def test_find_all
    	assert_equal [156, 336],@int_triple.cs253find_all{|i| i%2 == 0 and i >10}
        assert_equal ["grzkja", "ojpamcknldrhgxn"],@str_triple.cs253find_all{|i| i.length>5}
        assert_equal [0.2480833, 0.41273236668, 0.0271322001],@float_triple.cs253find_all{|i| i.class == Float}
    end

    def test_find_index
    	assert_equal 0, CS253Array.new([2,3,6,12]).cs253find_index{|i| i%2 == 0}
        assert_equal 2,CS253Array.new(["wert","asdfg","zxcvbn"]).cs253find_index{|i| i.length>5}
        assert_equal 0,@float_triple.cs253find_index{|i| i.class == Float}
    end

    def test_first
    	n = 2
    	assert_equal [156, 803], @int_triple.cs253first(n)
        assert_equal ["grzkja", "ojpamcknldrhgxn"], @str_triple.cs253first(n)
        assert_equal [0.2480833, 0.41273236668], @float_triple.cs253first(n)
    end

    def test_flat_map
    	assert_equal [256, 903, 436],@int_triple.cs253flat_map{|i| i + 100}
        assert_equal [true, true, false],@str_triple.cs253flat_map{|i| i.length>5}
        assert_equal [true, true, true],@float_triple.cs253flat_map{|i| i.class == Float}
        #assert_equal [[1, 2], [3, 4]].cs253flat_map{ |e| e + [100] }, [[1, 2], [3, 4]].flat_map{ |e| e + [100] }   
    end

    def test_grep
    	c = CS253Array.new([:WaitReadable, :WaitWritable, :EAGAINWaitReadable, :EAGAINWaitWritable, :EWOULDBLOCKWaitReadable, :EWOULDBLOCKWaitWritable, :EINPROGRESSWaitReadable, :EINPROGRESSWaitWritable, :SEEK_SET, :SEEK_CUR, :SEEK_END, :SEEK_DATA, :SEEK_HOLE, :SHARE_DELETE, :SYNC, :DSYNC, :NOFOLLOW, :LOCK_SH, :LOCK_EX, :LOCK_UN, :LOCK_NB, :NULL, :BINARY, :FNM_EXTGLOB, :FNM_SYSCASE, :TRUNC, :NOCTTY, :FNM_CASEFOLD, :FNM_SHORTNAME, :RDONLY, :FNM_NOESCAPE, :FNM_PATHNAME, :FNM_DOTMATCH, :WRONLY, :RDWR, :APPEND, :CREAT, :EXCL, :NONBLOCK])
    	assert_equal [:SEEK_SET, :SEEK_CUR, :SEEK_END, :SEEK_DATA, :SEEK_HOLE],c.cs253grep(/SEEK/)
    	assert_equal [], @int_triple.cs253grep(1..100)
    	assert_equal [8, 8, 8, 9, 9], c.cs253grep(/SEEK/) {|e| e.length}
    end

    def test_grep_v
    	c = CS253Array.new([:WaitReadable, :WaitWritable, :EAGAINWaitReadable, :EAGAINWaitWritable, :EWOULDBLOCKWaitReadable, :EWOULDBLOCKWaitWritable, :EINPROGRESSWaitReadable, :EINPROGRESSWaitWritable, :SEEK_SET, :SEEK_CUR, :SEEK_END, :SEEK_DATA, :SEEK_HOLE, :SHARE_DELETE, :SYNC, :DSYNC, :NOFOLLOW, :LOCK_SH, :LOCK_EX, :LOCK_UN, :LOCK_NB, :NULL, :BINARY, :FNM_EXTGLOB, :FNM_SYSCASE, :TRUNC, :NOCTTY, :FNM_CASEFOLD, :FNM_SHORTNAME, :RDONLY, :FNM_NOESCAPE, :FNM_PATHNAME, :FNM_DOTMATCH, :WRONLY, :RDWR, :APPEND, :CREAT, :EXCL, :NONBLOCK])
    	assert_equal [:WaitReadable, :WaitWritable, :EAGAINWaitReadable, :EAGAINWaitWritable, :EWOULDBLOCKWaitReadable, :EWOULDBLOCKWaitWritable, :EINPROGRESSWaitReadable, :EINPROGRESSWaitWritable, :SHARE_DELETE, :SYNC, :DSYNC, :NOFOLLOW, :LOCK_SH, :LOCK_EX, :LOCK_UN, :LOCK_NB, :NULL, :BINARY, :FNM_EXTGLOB, :FNM_SYSCASE, :TRUNC, :NOCTTY, :FNM_CASEFOLD, :FNM_SHORTNAME, :RDONLY, :FNM_NOESCAPE, :FNM_PATHNAME, :FNM_DOTMATCH, :WRONLY, :RDWR, :APPEND, :CREAT, :EXCL, :NONBLOCK],c.cs253grep_v(/SEEK/)
    	assert_equal [156, 803, 336], @int_triple.cs253grep_v(1..100)
    	assert_equal [12, 12, 18, 18, 23, 23, 23, 23, 12, 4, 5, 8, 7, 7, 7, 7, 4, 6, 11, 11, 5, 6, 12, 13, 6, 12, 12, 12, 6, 4, 6, 5, 4, 8],c.cs253grep_v(/SEEK/){|e| e.length}
    end

    def test_group_by
    	assert_equal Hash[0=>[156, 336], 1=>[803]], @int_triple.cs253group_by{|i| i%2}
        assert_equal Hash[6=>["grzkja"], 15=>["ojpamcknldrhgxn"], 2=>["em"]], @str_triple.cs253group_by{|i| i.length}
        assert_equal Hash[-0.5602467000000015=>[0.2480833], 0.13949569867999734=>[0.41273236668], -0.6860878099000002=>[0.0271322001]],@float_triple.cs253group_by{|i| i-i*100%1}
    end

    def test_include
    	assert_equal true,CS253Array.new([2,3,6,12]).cs253include?(6)
        assert_equal true,CS253Array.new(["wert","asdfg","zxcvbn"]).cs253include?("wert")
        assert_equal false,@float_triple.cs253include?(0.0)
    end

    def test_inject
    	assert_equal 42090048, @int_triple.cs253inject(1) {|i, e| i*e}
		assert_equal "grzkjaojpamcknldrhgxnem",@str_triple.cs253inject('') {|i, e| i+e}
		assert_equal -1,@float_triple.cs253inject(0) {|i,e| i<=>e}
	end

	def test_map
		assert_equal ["156", "803", "336"],@int_triple.cs253map{|i| i.to_s}.to_a
        assert_equal [6, 15, 2], @str_triple.cs253map{|i| i.length}
        assert_equal [24.80833, 41.273236668, 2.71322001], @float_triple.cs253map{|i| i*100}
    end

    def test_max
    	s_array = CS253Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal 803,@int_triple.cs253max {|i,e| i<=>e}
		assert_equal "Algorithm",s_array.cs253max {|i,e| i.length<=>e.length}
		assert_equal 0.41273236668,@float_triple.cs253max {|i,e| (i*100).round<=>(e*100).round}
	end

	def test_max_by
		s_array = CS253Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal 803,@int_triple.cs253max_by {|i| i}
		assert_equal "Algorithm",s_array.cs253max_by {|i| i.length}
		assert_equal 0.41273236668,@float_triple.cs253max_by {|i| (i*100).round}
	end

	def test_member
		assert_equal true,CS253Array.new([2,3,6,12]).cs253member?(6)
        assert_equal true,CS253Array.new(["wert","asdfg","zxcvbn"]).cs253member?("wert")
        assert_equal false,@float_triple.cs253member?(0.0)
    end

    def test_min
    	s_array = CS253Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal 156,@int_triple.cs253min {|i,e| i<=>e}
		assert_equal "bad",s_array.cs253min {|i,e| i.length<=>e.length}
		assert_equal 0.0271322001,@float_triple.cs253min {|i,e| (i*100).round<=>(e*100).round}
    end

    def test_min_by
		s_array = CS253Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal 156,@int_triple.cs253min_by {|i| i}
		assert_equal "bad",s_array.cs253min_by {|i| i.length}
		assert_equal 0.0271322001,@float_triple.cs253min_by {|i| (i*100).round}
	end

	def test_minmax
		s_array = CS253Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal [156, 803],@int_triple.cs253minmax {|i,e| i<=>e}
		assert_equal ["bad", "Algorithm"],s_array.cs253minmax {|i,e| i.length<=>e.length}
		assert_equal [0.0271322001, 0.41273236668], @float_triple.cs253minmax {|i,e| (i*100).round<=>(e*100).round}
	end

	def test_minmax_by
		s_array = CS253Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal [156, 803],@int_triple.cs253minmax_by {|i| i}
		assert_equal ["bad", "Algorithm"],s_array.cs253minmax_by {|i| i.length}
		assert_equal [0.0271322001, 0.41273236668],@float_triple.cs253minmax_by {|i| (i*100).round}
	end

	def test_none
		assert_equal false,@int_triple.cs253none?{|i| i%2 == 0}
        assert_equal false,@str_triple.cs253none?{|i| i.length>5}
        assert_equal false,@float_triple.cs253none?{|i| i.class == Float}
        assert_equal false,@bool_triple.cs253none?
        assert_equal true, @empty_triple.cs253none?
    end

    def test_one
    	assert_equal false,@int_triple.cs253one?{|i| i%2 == 0}
        assert_equal false,@str_triple.cs253one?{|i| i.length>5}
        assert_equal false,@float_triple.cs253one?{|i| i.class == Float}
        assert_equal false,@bool_triple.cs253one?
        assert_equal false,@empty_triple.cs253one?
    end

    def test_partition
    	assert_equal [[156, 336], [803]],@int_triple.cs253partition{|i| i%2 == 0}
        assert_equal [["grzkja", "ojpamcknldrhgxn"], ["em"]],@str_triple.cs253partition{|i| i.length>5}
        assert_equal [[0.2480833, 0.41273236668, 0.0271322001], []],@float_triple.cs253partition{|i| i.class == Float}
    end

    def test_reduce
    	assert_equal 42090048,@int_triple.cs253reduce(1) {|i, e| i*e}
		assert_equal "grzkjaojpamcknldrhgxnem",@str_triple.cs253reduce('') {|i, e| i+e}
		assert_equal -1,@float_triple.cs253reduce(0) {|i,e| i<=>e}
	end

	def test_reject
		assert_equal [803],@int_triple.cs253reject {|i| i.even? }
		assert_equal ["em"],@str_triple.cs253reject {|i| i.length>5}
		assert_equal [],@float_triple.cs253reject {|i| i*i}
	end

	def test_reverse_each
		# return self
		cs253a = []
		@int_triple.cs253reverse_each{|i| cs253a << i.to_s}
		assert_equal ["336", "803", "156"],cs253a
		cs253b = []
		@str_triple.cs253reverse_each{|i| cs253b << i.length}
        assert_equal [2, 15, 6], cs253b
        cs253c = []
        @float_triple.cs253reverse_each{|i| cs253c << i*100}
        assert_equal [2.71322001, 41.273236668, 24.80833],cs253c
    end

    def test_select
    	assert_equal [156, 336],@int_triple.cs253select {|i| i.even? }
		assert_equal ["grzkja", "ojpamcknldrhgxn"],@str_triple.cs253select {|i| i.length>5}
		assert_equal [0.2480833, 0.41273236668],@float_triple.cs253select {|i| (i*100).round>10}
	end

	def test_slice_after
		assert_equal [[156], [803, 336]],@int_triple.cs253slice_after {|i| i.even? }
		assert_equal [["grzkja"], ["ojpamcknldrhgxn"], ["em"]],@str_triple.cs253slice_after {|i| i.length>5}
		assert_equal [[0.2480833], [0.41273236668], [0.0271322001]],@float_triple.cs253slice_after {|i| (i*100).round>10}
	end

	def test_slice_before
        assert_equal [[156, 803], [336]], @int_triple.cs253slice_before {|i| i.even? }
		assert_equal [["grzkja"], ["ojpamcknldrhgxn", "em"]],@str_triple.cs253slice_before {|i| i.length>5}
		assert_equal [[0.2480833], [0.41273236668, 0.0271322001]], @float_triple.cs253slice_before {|i| (i*100).round>10}
	end

	def test_slice_when
		assert_equal [[156], [803, 336]],@int_triple.cs253slice_when {|i| i.even? }
		assert_equal [["grzkja"], ["ojpamcknldrhgxn"], ["em"]],@str_triple.cs253slice_when {|i| i.length>5}
		assert_equal [[0.2480833], [0.41273236668], [0.0271322001]],@float_triple.cs253slice_when {|i| (i*100).round>10}
	end

	def test_sort
		assert_equal [156, 336, 803], @int_triple.cs253sort{|i,e| i.to_s<=>e.to_s}
        assert_equal ["em", "grzkja", "ojpamcknldrhgxn"], @str_triple.cs253sort{|i,e| i.length<=>e.length}
        assert_equal [0.0271322001, 0.2480833, 0.41273236668],@float_triple.cs253sort{|i,e| i*i<=>e*e}
    end

    def test_sort_by
    	assert_equal [156, 336, 803], @int_triple.cs253sort_by{|i| i.to_s}
        assert_equal ["em", "grzkja", "ojpamcknldrhgxn"], @str_triple.cs253sort_by{|i| i.length}
        assert_equal [0.0271322001, 0.2480833, 0.41273236668], @float_triple.cs253sort_by{|i| i*i}
    end

    def test_sum
    	assert_equal 1295,@int_triple.cs253sum{|i| i}
        assert_equal 23,@str_triple.cs253sum{|i| i.length}
        assert_equal 69,@float_triple.cs253sum{|i| (i*100).round}
    end

    def test_take
    	n = 2
    	assert_equal [156, 803],@int_triple.cs253take(n)
        assert_equal ["grzkja", "ojpamcknldrhgxn"],@str_triple.cs253take(n)
        assert_equal [0.2480833, 0.41273236668],@float_triple.cs253take(n)
    end

    def test_take_while
    	assert_equal [156],@int_triple.cs253take_while{|i| i%2 == 0}
        assert_equal ["grzkja", "ojpamcknldrhgxn"],@str_triple.cs253take_while{|i| i.length>5}
        assert_equal [0.2480833, 0.41273236668, 0.0271322001],@float_triple.cs253take_while{|i| i.class == Float}
    end

    def test_to_a
    	assert_equal [156, 803, 336], @int_triple.cs253to_a
    	assert_equal [0.2480833, 0.41273236668, 0.0271322001],@float_triple.cs253to_a
    	assert_equal ["grzkja", "ojpamcknldrhgxn", "em"],@str_triple.cs253to_a
    end

    def test_to_h
    	assert_equal Hash[0=>1, 1=>2, 2=>3],Triple.new([0,1],[1,2],[2,3]).cs253to_h
    	assert_equal Hash["0"=>"1", "1"=>"2", "2"=>"3"], Triple.new(['0','1'],['1','2'],['2','3']).cs253to_h
    	assert_equal Hash["0"=>["1", 3, 4, "5"], "1"=>["2", 3.45], 2=>["3", "45", 6]], Triple.new(['0',['1',3,4,'5']],['1',['2',3.45]],[2,['3','45',6]]).cs253to_h
    end

    def test_uniq
    	assert_equal [0, 1], Triple.new(0,1,1).cs253uniq
    	assert_equal ["0", "1"],Triple.new('0','1','1').cs253uniq
    	assert_equal [[0, 1], ["0", "1"]],Triple.new([0,1],[0,1],['0','1']).cs253uniq
    end

    def test_zip
    	assert_equal [[156, "grzkja"], [803, "ojpamcknldrhgxn"], [336, "em"]], @int_triple.cs253zip(@str_triple)
    	assert_equal [[156, 1, 1], [803, 2, nil], [336, nil, nil]],@int_triple.cs253zip([1,2],[1])
 
    	c253 = []
    	@int_triple.cs253zip(@float_triple) {|x,y| c253 << ((x+y)*100).round}
    	assert_equal [15625, 80341, 33603],c253

    end

    def test_length
    	assert_equal 3,@int_triple.cs253length
        assert_equal 3,@str_triple.cs253length
        assert_equal 3,@float_triple.cs253length
    end

end





