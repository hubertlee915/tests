require 'minitest/autorun'
require './cs253Array.rb'
require './triple.rb'

# Numeric arrays
SIMPLE_A = CS253Array.new([1,2,3])
NEG_A3 = CS253Array.new([-3,-2,-1])
DEC_A3 = CS253Array.new([0.1,0.2,0.3])
EVEN_A3 = CS253Array.new([2,4,8])
SQUARE_A3 = CS253Array.new(EVEN_A3.cs253map{ |x| x ** 2 })
ODD_A5 = CS253Array.new([1,3,5,7,9])
MULT5_A6 = CS253Array.new([5,10,15,20,22,25])
RANGE_A9 = CS253Array.new([*(1..9)])

# String arrays
ANIMAL_STR_A = CS253Array.new(['aardvark', 'anteater', 'boar', 'bat'])
FRUIT_STR_A = CS253Array.new(['apple', 'peach', 'pear', 'plum'])
RUSS_AUTH_STR_A = CS253Array.new(['Dostoyevsky', 'Chekhov', 'Nabokov'])
DAY_SYMS_A = CS253Array.new([:Monday, :Tuesday, :Wednesday, :Mercredi])

# Numeric triples
SIMPLE_T = Triple.new(1,2,3)
MULT5_T = Triple.new(5,10,15)

# String triples
SIMPLE_STR_T = Triple.new('one', 'two', 'three')
EVEN_STR_T = Triple.new('two','four','eight')
SEA_STR_T = Triple.new('jellyfish','octopus','squid')
CEO_STR_T = Triple.new('Jobs', 'Musk', 'Gates')

# Helper function
def enum_to_a(enum)
    enum.each{ |x| x.inspect}
end

# Classes for testing cs253each_entry
class EachEntryTester1
    include CS253Enumerable
    def each
        yield 1, 2, 4
    end
end

class EachEntryTester2
    include CS253Enumerable
    def each
        yield 8
    end
end

class EachEntryTester3
    include CS253Enumerable
    def each
        yield
    end
end

class CS253EnumTests < Minitest::Test
    def test_all?
        assert_equal EVEN_A3.cs253all?{ |x| x.even? }, true
    end

    def test_simple_all?
        assert_equal SIMPLE_A.cs253all?{ |x| x < 4 }, true
    end

    def test_false_all?
        assert_equal ODD_A5.cs253all?{ |x| x < 8 }, false
    end

    def test_any?
        assert_equal SIMPLE_A.cs253any?{ |x| x < 2 }, true
    end

    def test_str_any?
        assert_equal ANIMAL_STR_A.cs253any?{ |x| x[-1] == 'k' }, true
    end

    def test_tr_any?
        assert_equal SIMPLE_T.cs253any?{ |x| x < 1 }, false
    end

    def test_chunk_while_str
        out = enum_to_a(ANIMAL_STR_A.cs253chunk_while{ |a, b| a[0].ord >= b[0].ord })
        assert_equal out, [['aardvark', 'anteater'], ['boar', 'bat']]
    end

    def test_chunk_while
        arr = CS253Array.new([0,3,5,3,4,4,1,2])
        out = enum_to_a(arr.cs253chunk_while{ |a, b| a <= b })
        assert_equal out, [[0,3,5],[3,4,4],[1,2]]
    end

    def test_chunk_while_tr
        assert_equal enum_to_a(CEO_STR_T.cs253chunk_while{ |a, b| a.length == b.length }), [['Jobs', 'Musk'], ['Gates']]
    end

    def test_collect_square
        assert_equal EVEN_A3.cs253collect{ |x| x*x }, SQUARE_A3
    end

    def test_collect_str_len
        assert_equal EVEN_STR_T.cs253collect{ |x| x.length }, [3,4,5]
    end

    def test_collect_tr
        assert_equal MULT5_T.cs253collect{ |x| x % 2 }, [1, 0, 1]
    end

    def test_collect_concat
        assert_equal SIMPLE_A.cs253collect_concat{ |x| [x, x ** 2] }, \
            [1, 1, 2, 4, 3, 9]
    end

    def test_collect_concat_str
        assert_equal SEA_STR_T.cs253collect_concat{ |x| [x[0], x[-1]] }, \
            ['j', 'h', 'o', 's', 's', 'd']
    end

    def test_collect_concat_tr
        assert_equal SIMPLE_T.cs253collect_concat{ |x| [x.to_s] }, \
            ['1', '2', '3']
    end

    def test_count
        assert_equal NEG_A3.cs253count, 3
        assert_equal CS253Array.new.cs253count, 0
    end

    def test_count_tr
        assert_equal SIMPLE_T.cs253count, 3
    end

    def test_count_str
        assert_equal FRUIT_STR_A.cs253count, 4
    end

    def test_detect
        assert_equal SIMPLE_STR_T.cs253detect{ |x| x[0] == 't' }, 'two'
    end

    def test_detect_nil_arg
        assert_nil SIMPLE_STR_T.cs253detect{ |x| x.length > 5 }
    end

    def test_detect_arg
        wrap = -> { return 0 }
        assert_equal SIMPLE_STR_T.cs253detect(ifnone=wrap) { |x| x.length < 3 }, 0
    end

    def test_drop
        assert_equal ODD_A5.cs253drop(0), ODD_A5
        assert_equal ODD_A5.cs253drop(3), [7,9]
        assert_equal ODD_A5.cs253drop(5), []
    end

    def test_drop_str
        assert_equal DAY_SYMS_A.cs253drop(3), [:Mercredi]
    end

    def test_drop_tr
        assert_equal SEA_STR_T.cs253drop(2), ['squid']
    end

    def test_drop_while
        arr = CS253Array.new([1,3,5,2,4])
        assert_equal arr.cs253drop_while{ |x| x.odd? }, [2, 4]
    end

    def test_drop_while_tr
        assert_equal CEO_STR_T.cs253drop_while{ |x| x[-1] == 's' }, \
            ['Musk', 'Gates']
    end

    def test_drop_while_sym
        assert_equal DAY_SYMS_A.cs253drop_while{ |x| /day/ === x }, \
            [:Mercredi]
    end

    def test_drop_all
        assert_equal RUSS_AUTH_STR_A.cs253drop_while{ |x| x.length > 6 }, []
    end

    def test_each_cons
        arr = CS253Array.new([6,5,4,3,2,1])
        out = []
        arr.cs253each_cons(3) { |a| out << a }
        assert_equal out, [[6,5,4],[5,4,3],[4,3,2],[3,2,1]]
    end

    def test_each_cons_tr
        out = []
        SIMPLE_T.cs253each_cons(2) { |a| out << a }
        assert_equal out, [[1,2], [2,3]]
    end

    def test_each_cons_str
        out = []
        ANIMAL_STR_A.cs253each_cons(1) { |a| out << a }
        assert_equal out, [['aardvark'], ['anteater'], ['boar'], ['bat']]
    end

    def test_each_entry1
        out = []
        EachEntryTester1.new.cs253each_entry{ |x| out << x }
        assert_equal out, [[1,2,4]]
    end

    def test_each_entry2
        out = []
        EachEntryTester2.new.cs253each_entry{ |x| out << x }
        assert_equal out, [8]
    end

    def test_each_entry3
        out = []
        EachEntryTester3.new.cs253each_entry{ |x| out << x }
        assert_equal out, [nil]
    end

    def test_each_slice
        out = []
        RANGE_A9.cs253each_slice(3) { |a| out << a }
        assert_equal out, [[1,2,3],[4,5,6],[7,8,9]]
    end

    def test_each_slice_str
        out = []
        ANIMAL_STR_A.cs253each_slice(2) { |a| out << a }
        assert_equal out, [['aardvark', 'anteater'], ['boar', 'bat']]
    end

    def test_each_slice_tr
        out = []
        EVEN_STR_T.cs253each_slice(1) { |a| out << a }
        assert_equal out, [['two'], ['four'], ['eight']]
    end

    def test_each_with_index
        tmp = SIMPLE_A.cs253to_a
        SIMPLE_A.cs253each_with_index{ |x, i| tmp[i] += x }
        assert_equal tmp, [2,4,6]
    end

    def test_each_with_index_str
        out = []
        RUSS_AUTH_STR_A.cs253each_with_index{ |x, i| out << x + i.to_s }
        assert_equal out, ['Dostoyevsky0', 'Chekhov1', 'Nabokov2']
    end

    def test_each_with_index_tr
        tmp = ['one', 'two', 'three']
        CEO_STR_T.cs253each_with_index{ |x, i| tmp[i] += x }
        assert_equal tmp, ['oneJobs', 'twoMusk', 'threeGates']
    end

    def test_each_with_object
        arr = CS253Array.new([4,8,16,32])
        assert_equal arr.cs253each_with_object([]) { |x, obj| obj << x / 2 }, \
            [2,4,8,16]
    end

    def test_each_with_object_str
        assert_equal CEO_STR_T.cs253each_with_object(['Zuckerberg']) { |x, obj| obj << x }, \
            ['Zuckerberg', 'Jobs', 'Musk', 'Gates']
    end

    def test_each_with_object_tr
        tmp = 'zero'
        assert_equal SIMPLE_STR_T.cs253each_with_object(tmp) { |x, obj| obj << x }, \
            'zeroonetwothree'
    end

    def test_entries
        assert_equal SIMPLE_T.cs253entries, [1,2,3]
    end

    def test_entries_tr
        assert_equal SEA_STR_T.cs253entries, ['jellyfish','octopus','squid']
    end

    def test_entries_empty
        assert_equal CS253Array.new.cs253entries, []
    end

    def test_find_all
        assert_equal RANGE_A9.cs253find_all{ |x| x % 3 == 0 }, [3,6,9]
        assert_equal RANGE_A9.cs253find_all{ |x| x < 1 }, []
    end

    def test_find_all_str
        assert_equal ANIMAL_STR_A.cs253find_all{ |x| x[0] == 'a' }, \
            ['aardvark', 'anteater']
    end

    def test_find_all_tr
        assert_equal MULT5_T.cs253find_all{ |x| x % 2 == 0 }, [10]
    end

    def test_find_index
        assert_equal MULT5_A6.cs253find_index{ |x| x % 5 > 0 }, 4
        assert_equal MULT5_A6.cs253find_index{ |x| x % 4 == 0 }, 3
    end

    def test_find_index_nil
        assert_nil SIMPLE_STR_T.cs253find_index{ |x| x.length > 5 }
    end

    def test_find_index_str
        assert_equal RUSS_AUTH_STR_A.cs253find_index{ |x| x[-1] == 'v' }, 1
    end

    def test_first
        assert_equal MULT5_A6.cs253first(3), [5,10,15]
    end

    def test_first_nil
        assert_nil SIMPLE_T.cs253first
    end

    def test_first_tr
        assert_equal MULT5_T.cs253first(2), [5,10]
    end

    def test_flat_map
        assert_equal NEG_A3.cs253flat_map{ |x| [x, x * -1] }, [-3, 3, -2, 2, -1, 1]
    end

    def test_flat_map_tr
        assert_equal SIMPLE_T.cs253flat_map{ |x| [2 ** x] }, EVEN_A3
    end

    def test_flat_map_str
        assert_equal ANIMAL_STR_A.cs253flat_map{ |x| [x[-1]] }, ['k', 'r', 'r', 't']
    end

    def test_grep
        arr = CS253Array.new(IO.constants)
        assert_equal arr.cs253grep(/SYNC/), [:SYNC, :DSYNC, :RSYNC]
    end

    def test_grep_str
        assert_equal RUSS_AUTH_STR_A.cs253grep(/ov/), ['Chekhov', 'Nabokov']
    end

    def test_grep_block
        arr = CS253Array.new(['CATERPILLAR', 'chrysalis', 'butterfly'])
        assert_equal arr.cs253grep(/cat/) { |x| return x.downcase }, \
            ['caterpillar']
    end

    def test_grep_v
        assert_equal DAY_SYMS_A.cs253grep_v(/day/), [:Mercredi]
    end

    def test_grep_v_str
        assert_equal FRUIT_STR_A.cs253grep_v(/ea/), ['apple', 'plum']
    end

    def test_grep_tr
        assert_equal MULT5_T.cs253grep_v(1..5), [10, 15]
    end

    def test_group_by
        arr = CS253Array.new([2,3,4,5,7,8])
        assert_equal arr.cs253group_by{ |x| x % 2 }, {0=>[2,4,8], 1=>[3,5,7]}
    end

    def test_group_by_str
        assert_equal RUSS_AUTH_STR_A.cs253group_by{ |x| x.length > 7 }, \
            {true=>['Dostoyevsky'], false=>['Chekhov', 'Nabokov']}
    end

    def test_group_by_tr
        assert_equal SIMPLE_T.cs253group_by{ |x| x % 2 == 0 }, \
            {true=>[2], false=>[1,3]}
    end

    def test_include
        assert_equal DAY_SYMS_A.cs253include?(:Friday), false
    end

    def test_include_str
        assert_equal RUSS_AUTH_STR_A.cs253include?('Nabokov'), true
    end

    def test_include_tr
        assert_equal EVEN_STR_T.cs253include?('sixteen'), false
    end

    def test_inject_sum_diff
        assert_equal SQUARE_A3.cs253inject(0) { |sum, x| sum + x }, 84
        assert_equal SQUARE_A3.cs253inject(0) { |diff, x| diff - x }, -84
    end

    def test_inject_no_param
        assert_equal SIMPLE_A.cs253inject{ |prod, x| prod * x }, 6
    end

    def test_inject_concat_str
        assert_equal EVEN_STR_T.cs253inject{ |concat, x| concat + x }, \
            'twofoureight'
    end

    def test_map
        assert_equal ODD_A5.cs253map{ |x| x ** 2 }, [1, 9, 25, 49, 81]
    end

    def test_map_str
        assert_equal ANIMAL_STR_A.cs253map{ |x| x[0, 3] }, \
            ['aar', 'ant', 'boa', 'bat']
    end

    def test_map_tr
        assert_equal SIMPLE_T.cs253map{ |x| x % 3 }, [1,2,0]
    end

    def test_max_str
        assert_equal EVEN_STR_T.cs253max{ |a, b| a.length <=> b.length }, 'eight'
    end

    def test_max_num
        assert_equal NEG_A3.cs253max{ |a, b| a <=> b }, -1
    end

    def test_max_no_block
        assert_equal NEG_A3.cs253max, -1
    end

    def test_max_by
        assert_equal SIMPLE_A.cs253max_by{ |x| -x }, 1
    end

    def test_max_by_tr
        assert_equal SIMPLE_T.cs253max_by(2), [3, 2]
    end

    def test_max_by_str
        assert_equal RUSS_AUTH_STR_A.cs253max_by{ |x| x.length }, 'Dostoyevsky'
    end

    def test_member?
        assert_equal SIMPLE_A.cs253member?(2), true
    end

    def test_str_member?
        assert_equal ANIMAL_STR_A.cs253member?('bear'), false
    end

    def test_tr_member?
        assert_equal SEA_STR_T.cs253member?('jellyfish'), true
    end

    def test_min
        assert_equal EVEN_A3.cs253min, 2
        assert_equal NEG_A3.cs253min, -3
    end

    def test_min_arg
        assert_equal RANGE_A9.cs253min(4), [1,2,3,4]
    end

    def test_min_block
        assert_equal CEO_STR_T.cs253min(2) { |a, b| a[0].ord <=> b[0].ord }, ['Gates', 'Jobs']
    end

    def test_min_by
        assert_equal NEG_A3.cs253min_by{ |x| -x }, -1
    end

    def test_min_by_str
        assert_equal SEA_STR_T.cs253min_by{ |x| x.length }, 'squid'
    end

    def test_min_by_tr
        assert_equal SIMPLE_T.cs253min_by(2), [1, 2]
    end

    def test_minmax
        assert_equal DEC_A3.cs253minmax, [0.1, 0.3]
    end

    def test_minmax_block
        assert_equal CEO_STR_T.cs253minmax{ |a, b| a[0].ord <=> b[0].ord }, \
            ['Gates', 'Musk']
    end

    def test_minmax_tr
        assert_equal SEA_STR_T.cs253minmax{ |a, b| a.length <=> b.length }, \
            ['squid', 'jellyfish']
    end

    def test_minmax_by
        arr = CS253Array.new(['gao', 'gao', 'xin', 'xin'])
        assert_equal arr.cs253minmax_by{ |x| x[-1].ord }, ['xin', 'gao']
    end

    def test_minmax_by_str
        assert_equal ANIMAL_STR_A.cs253minmax_by{ |x| x.length }, \
            ['bat', 'aardvark']
    end

    def test_minmax_by_tr
        assert_equal MULT5_T.cs253minmax_by{ |x| -x }, [15, 5]
    end

    def test_none?
        arr = CS253Array.new([1,2,3])
        assert_equal arr.cs253none?{ |x| x < 1 }, true
    end

    def test_str_none?
        assert_equal FRUIT_STR_A.cs253none?{ |x| x.length > 5 }, true
    end

    def test_tr_none?
        assert_equal SIMPLE_T.cs253none?{ |x| x > 2 }, false
    end

    def test_one?
        arr = CS253Array.new(['three', 'blind', 'mice'])
        assert_equal arr.cs253one?{ |x| x.length < 5 }, true
        assert_equal arr.cs253one?{ |x| x.length > 4 }, false
    end

    def test_str_one?
        assert_equal SEA_STR_T.cs253one?{ |x| x.length > 7 }, true
    end

    def test_tr_one?
        assert_equal MULT5_T.cs253one?{ |x| x % 2 == 1 }, false
    end

    def test_partition
        assert_equal ANIMAL_STR_A.cs253partition{ |x| x[0] == 'a' }, \
            [['aardvark', 'anteater'], ['boar', 'bat']]
    end

    def test_partition_str
        assert_equal SEA_STR_T.cs253partition{ |x| x.length > 5 }, \
            [['jellyfish','octopus'], ['squid']]
    end

    def test_partition_tr
        assert_equal SIMPLE_T.cs253partition{ |x| x < 2 }, [[1], [2,3]]
    end

    def test_reduce
        assert_equal SIMPLE_T.cs253reduce(0) { |sum, x| sum + x }, 6
    end

    def test_reduce_str
        assert_equal CEO_STR_T.cs253reduce { |concat, x| concat + x }, 'JobsMuskGates'
    end

    def test_reduce_tr
        assert_equal MULT5_T.cs253reduce(1) { |prod, x| prod * x }, 750
    end

    def test_reject
        assert_equal MULT5_A6.cs253reject{ |x| x % 2 == 1 }, \
            [10,20,22]
    end

    def test_reject_str
        assert_equal FRUIT_STR_A.cs253reject{ |x| x[0] == 'p' }, \
            ['apple']
    end

    def test_reject_tr
        assert_equal SIMPLE_T.cs253reject{ |x| x > 4 }, [1,2,3]
    end

    def test_reverse_each
        out = Array.new
        SIMPLE_T.cs253reverse_each{ |x| out << x }
        assert_equal out, [3,2,1]
    end

    def test_reverse_each_str
        out = Array.new
        RUSS_AUTH_STR_A.cs253reverse_each{ |x| out << x }
        assert_equal out, ['Nabokov', 'Chekhov', 'Dostoyevsky']
    end

    def test_reverse_each_tr
        out = Array.new
        SIMPLE_T.cs253reverse_each{ |x| out << x + 1}
        assert_equal out, [4,3,2]
    end

    def test_select
        assert_equal RANGE_A9.cs253select{ |x| x % 3 == 0 }, [3, 6, 9]
    end

    def test_select_even_odd
        arr = CS253Array.new([0,1,1,2,3])
        assert_equal arr.cs253select{ |x| x.even? }, [0,2]
        assert_equal arr.cs253select{ |x| x.odd? }, [1,1,3]
    end

    def test_select_str
        arr = CS253Array.new(['five', 'Thirty', 'Eight'])
        assert_equal arr.cs253select{ |x| x[0] == x[0].upcase }, \
            ['Thirty', 'Eight']
    end

    def test_slice_after_str
        assert_equal enum_to_a(FRUIT_STR_A.cs253slice_after{ |x| x.length == 5 }), \
            [['apple'], ['peach'], ['pear', 'plum']]
    end

    def test_slice_after
        assert_equal enum_to_a(MULT5_A6.cs253slice_after{ |x| x % 2 == 0 }), \
                               [[5,10],[15,20],[22],[25]]
    end

    def test_slice_after_tr
        assert_equal enum_to_a(SIMPLE_T.cs253slice_after{ |x| x % 3 == 0 }), \
            [[1,2,3]]
    end

    def test_slice_before
        assert_equal enum_to_a(RUSS_AUTH_STR_A.cs253slice_before{ |x| x[-1] == 'v' }), \
            [['Dostoyevsky'], ['Chekhov'], ['Nabokov']]
    end

    def test_slice_before_odd
        assert_equal enum_to_a(ODD_A5.cs253slice_before{ |x| x % 5 == 0 }), \
                               [[1,3],[5,7,9]]
    end

    def test_slice_before_tr
        assert_equal enum_to_a(SIMPLE_T.cs253slice_before{ |x| x > 1 }), [[1],[2],[3]]
    end

    def test_slice_when
        arr = CS253Array.new([0,2,4,6,7,9])
        assert_equal enum_to_a(arr.cs253slice_when{ |a, b| b != a + 2 }), \
            [[0,2,4,6],[7,9]]
    end

    def test_slice_when_str
        assert_equal enum_to_a(ANIMAL_STR_A.cs253slice_when{ |a, b| a[0] != b[0] }), \
                               [['aardvark', 'anteater'], ['boar', 'bat']]
    end

    def test_slice_when_tr
        assert_equal enum_to_a(SIMPLE_T.cs253slice_when{ |a, b| b <= a }), [[1,2,3]]
    end

    def test_sort_str
        assert_equal RUSS_AUTH_STR_A.cs253sort{ |a, b| a[0].ord <=> b[0].ord }, \
            ['Chekhov', 'Dostoyevsky', 'Nabokov']
    end

    def test_sort_tr
        assert_equal SEA_STR_T.cs253sort{ |a, b| a.length <=> b.length }, \
            ['squid', 'octopus', 'jellyfish']
    end

    def test_sort_by
        assert_equal SEA_STR_T.cs253sort_by{ |x| x.length }, \
            ['squid', 'octopus', 'jellyfish']
    end

    def test_sort_by_str
        assert_equal FRUIT_STR_A.cs253sort_by{ |x| x[-1].ord }, \
            ['apple', 'peach', 'plum', 'pear']
    end

    def test_sort_by_tr
        assert_equal MULT5_T.cs253sort_by{ |x| x % 3 }, [15,10,5]
    end

    def test_sum
        assert_equal MULT5_T.cs253sum, 30
        assert_equal MULT5_T.cs253sum(4), 34
    end

    def test_sum_range
        assert_equal RANGE_A9.cs253sum, 45
    end

    def test_sum_tr
        assert_equal MULT5_T.cs253sum, 30
    end

    def test_to_a
        assert_equal SIMPLE_T.cs253to_a, [1,2,3]
    end

    def test_to_a_str
        assert_equal CEO_STR_T.cs253to_a, ['Jobs', 'Musk', 'Gates']
    end

    def test_to_a_tr
        assert_equal MULT5_T.cs253to_a, [5,10,15]
    end

    def test_to_h
        arr = CS253Array.new([[-1,0], [0,1], [1,2]])
        assert_equal arr.cs253to_h, {-1=>0, 0=>1, 1=>2}
    end

    def test_to_h_str
        arr = CS253Array.new([['dog', 'cat'], ['black', 'white'], ['yin', 'yang']]), \
                             {'dog'=>'cat', 'black'=>'white', 'yin'=>'yang'}
    end

    def test_to_h_sym
        arr = CS253Array.new([[:figure, :speech], [:statue, :liberty]]), \
                             {:figure=>:speech, :statue=>:liberty}
    end

    def test_zip
        arr = CS253Array.new([1,4])
        assert_equal arr.cs253zip([2,5], [3,6]), [[1,2,3], [4,5,6]]
    end

    def test_zip_nil
        assert_equal SIMPLE_A.cs253zip([-1,-2]), [[1,-1],[2,-2],[3,nil]]
    end

    def test_zip_block
        out = Array.new
        assert_nil SIMPLE_A.cs253zip(NEG_A3) { |x, y| out << x * y }
        assert_equal out, [-3, -4, -3]
    end
end
