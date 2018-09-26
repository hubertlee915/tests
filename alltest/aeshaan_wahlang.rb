# $LOAD_PATH << '.'
require 'minitest/autorun.rb'
require_relative './cs253Array.rb'

class CS253EnumTests < Minitest::Test
    def test_collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253collect{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.cs253collect{|i| i.length}.to_a,[6,13,10]
    end
    
    def test_all
        int_triple = CS253Array.new([1, 5, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253all?{|i| i>0},true
        assert_equal int_triple.cs253all?{|i| i%2 == 0},false 
        assert_equal str_triple.cs253all?{|i| i.length > 2},true
    end

    def test_any
        int_triple = CS253Array.new([1, 5, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253any?{|i| i>4},true
        assert_equal int_triple.cs253any?{|i| i%2 == 0},false 
        assert_equal str_triple.cs253any?{|i| i.length>2},true
    end

    #bad test
    # def test_collect_concat
    #     int_triple = CS253Array.new([1, 5, 3])
    #     str_triple = CS253Array.new(["string", "dog", "food"])

    #     assert_equal int_triple.cs253collect_concat{|i| i*10},[1,10,5,50,3,30]
    #     assert_equal int_triple.cs253collect_concat{|i| i%2},[1,1,5,1,3,1]
    #     assert_equal str_triple.cs253collect_concat{|i| i.length},['string',6,'dog',3,'food',4]
    # end

    def test_count
        int_triple = CS253Array.new([1, 5, 3, 4, 6, 3, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253count,7
        assert_equal int_triple.cs253count{|i| i%2 == 0},2
        assert_equal int_triple.cs253count(3),3
    end

    # def test_cycle
    #     int_triple = CS253Array.new([10, 20, 30])
    #     str_triple = CS253Array.new(["string", "anotherString", "lastString"])

    #     assert_equal int_triple.cs253cycle(2){|i| puts(i)}.to_a,[10,20,30,10,20,30]
    #     assert_equal int_triple.cs253cycle(2){|i| puts(i/10)}.to_a,[1,2,3,1,2,3]
    #     assert_equal int_triple.cs253cycle(1){|i| puts("hello")}.to_a,["hello"]
    # end

    def test_detect
        int_triple = CS253Array.new([1, 5, 3, 4, 6, 3, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253detect{|i| i%2==0 },4
        # assert_equal int_triple.cs253detect(77){|i| i%7==0},77
        assert_equal int_triple.cs253detect{|i| i%57==0},nil
    end

    def test_drop
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253drop(2),[3,4,5,6]
        assert_equal str_triple.cs253drop(2),['lastString']
        assert_equal int_triple.cs253drop(6),[]
    end

    def test_drop_while
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
        int_triple2 = CS253Array.new([1, 2, 3, 4, 5, 6])

        assert_equal int_triple.cs253drop_while{|i| i<=3 },[4,5,6]
        assert_equal str_triple.cs253drop_while{|i| i.length < 8},["anotherString", "lastString"]
        assert_equal int_triple2.cs253drop_while{|i| i<10},[]
    end

    def test_each_slice
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253each_slice(2){|i| print(i)},nil
        assert_equal int_triple.cs253each_slice(2){|i| i},nil
        assert_equal str_triple.cs253each_slice(2){|i| i},nil
    end

    #bad test
    # def test_each_with_index
    #     int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
    #     str_triple = CS253Array.new(["string", "anotherString", "lastString"])

    #     assert_equal int_triple.cs253each_slice(2){|i| print(i)},nil
    #     # assert_equal int_triple.cs253count{|i| i%2 == 0},2
    #     # assert_equal int_triple.cs253count(3),3
    # end

    def test_each_cons
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253each_cons(2){|i| print(i)},nil
        assert_equal int_triple.cs253each_cons(2){|i| i},nil
        assert_equal str_triple.cs253each_cons(2){|i| i},nil
    end

    def test_each_with_object
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253each_with_object([]){|i, a| a << i*2},[2,4,6,8,10,12]
        assert_equal str_triple.cs253each_with_object([]){|i, a| a << i.length},[3,4,6]
        assert_equal empty_obj.cs253each_with_object([]){|i, a| a << i*2},[]
    end

    def test_entries
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253entries,[1, 2, 3, 4, 5, 6]
        assert_equal str_triple.cs253entries,["dog", "bear", "parrot"]
        assert_equal empty_obj.cs253entries,[]
    end
    
    def test_find
        int_triple = CS253Array.new([1, 5, 3, 4, 6, 3, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253find{|i| i%2==0 },4
        assert_equal int_triple.cs253find(77){|i| i%7==0},77
        assert_equal int_triple.cs253find{|i| i%57==0},nil
    end

    def test_find_all
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253find_all{|i| i.even? },[2,4,6]
        assert_equal str_triple.cs253find_all{|i| i.length <= 3},["dog"]
        assert_equal empty_obj.cs253find_all{|i| i>0 },[]
    end

    def test_find_index
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253find_index{|i| i.even? },1
        assert_equal str_triple.cs253find_index("parrot"),2
        assert_equal empty_obj.cs253find_index{|i| i>0 },nil
    end

    #return nil
    def test_first
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253first, 1
        assert_equal int_triple.cs253first(3),[1,2,3]
        # assert_equal empty_obj.cs253first,[]
    end

    # def test_flat_map
    #     int_triple = CS253Array.new([1, 5, 3])
    #     str_triple = CS253Array.new(["string", "dog", "food"])

    #     assert_equal int_triple.cs253flat_map{|i| i*10},[1,10,5,50,3,30]
    #     assert_equal int_triple.cs253flat_map{|i| i*2},[1,2,5,10,3,6]
    #     assert_equal str_triple.cs253flat_map{|i| i.length},["string",6, "dog",3, "food",4]
    # end

    def test_grep
        int_triple = CS253Array.new([1, 5, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253grep(/String/),["anotherString", "lastString"]
        assert_equal str_triple.cs253grep(/String/){|i| i.length},[13, 10]
        assert_equal str_triple.cs253grep(/not/),["anotherString","notThis"]
    
    end

    def test_grep_v
        int_triple = CS253Array.new([1, 5, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253grep_v(/String/),["string", "notThis"]
        assert_equal str_triple.cs253grep_v(/String/){|i| i.length},[6, 7]
        assert_equal str_triple.cs253grep_v(/not/),["string","lastString"]
    end

    def test_include?
        int_triple = CS253Array.new([1, 5, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253include?('string'),true
        assert_equal int_triple.cs253include?(5),true
        assert_equal int_triple.cs253include?(15),false
    end

    def test_map
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253map{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.cs253map{|i| i.length}.to_a,[6,13,10]
        assert_equal int_triple.cs253map{|i| i*2}.to_a,[2,4,6]
    end

    def test_member?
        int_triple = CS253Array.new([1, 5, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253member?('string'),true
        assert_equal int_triple.cs253member?(5),true
        assert_equal int_triple.cs253member?(15),false
    end

    def test_inject
        int_triple = CS253Array.new([2, 5, 3, 2])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal int_triple.cs253inject{|acc, i| i*acc},60
        assert_equal int_triple.cs253inject(2){|acc, i| i*acc},120
        assert_equal int_triple.cs253inject(:+),12
        assert_equal int_triple.cs253inject(2,:*),120
    end

    def test_max
        int_triple = CS253Array.new([1, 5, 3, 2,77,99])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal int_triple.cs253max{|acc, i| acc <=> i},99
        assert_equal int_triple.cs253max(3){|acc, i| acc <=> i},[99,77,5]
        assert_equal int_triple.cs253max,99
        assert_equal int_triple.cs253max(3),[99,77,5]
    end

    def test_max_by
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253max_by{|i| i.length},"anotherString"
        assert_equal str_triple.cs253max_by(3){|i| i.length},["anotherString","lastString",'notThis']
        assert_equal int_triple.cs253max_by(3){|i| i},[99,77,5]
    end

    def test_min
        int_triple = CS253Array.new([1, 5, 3, 2,77,99])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal int_triple.cs253min{|acc, i| acc <=> i},1
        assert_equal int_triple.cs253min(3){|acc, i| acc <=> i},[1,2,3]
        assert_equal int_triple.cs253min,1
        assert_equal int_triple.cs253min(3),[1,2,3]
    end

    def test_min_by
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253min_by{|i| i.length},"string"
        assert_equal str_triple.cs253min_by(3){|i| i.length},["string","notThis","lastString"]
        assert_equal int_triple.cs253min_by(3){|i| i},[1,2,3]
    end

    def test_minmax
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal int_triple.cs253minmax{|a,b| a <=> b},[1,99]
        assert_equal str_triple.cs253minmax{|a,b| a.length <=> b.length},["string","anotherString"]
        assert_equal int_triple.cs253minmax,[1,99]
    end

    def test_minmax_by
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])
        int_triple2 = CS253Array.new([1, 5, 5, 3, 2,7])

        assert_equal int_triple.cs253minmax_by{|a| a},[1,99]
        assert_equal str_triple.cs253minmax_by{|a| a.length},["string","anotherString"]
        assert_equal int_triple2.cs253minmax_by{|a| a},[1,7]

    end

    def test_none?
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253none?{|a| a.length <3},true
        # assert_equal str_triple.cs253none?,true
        assert_equal str_triple.cs253none?{|a| a.length >8},false
    end

    def test_one?
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253one?{|a| a.length >11},true
        assert_equal str_triple.cs253one?,false
        assert_equal str_triple.cs253one?{|a| a.length >8},false
    end

    def test_partition
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253partition{|a| a.length <3},[[],["string", "anotherString", "lastString","notThis"]]
        assert_equal int_triple.cs253partition{|i| i.even?},[[2],[1,5,99,3,77]]
        assert_equal int_triple.cs253partition{|i| i.odd?},[[1,5,99,3,77],[2]]
    end

    def test_reduce
        int_triple = CS253Array.new([2, 5, 3, 2])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal int_triple.cs253reduce{|acc, i| i*acc},60
        assert_equal int_triple.cs253reduce(2){|acc, i| i*acc},120
        assert_equal int_triple.cs253reduce(:+),12
        assert_equal int_triple.cs253reduce(2,:*),120
    end

    def test_reject
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(["string", "anotherString", "lastString","notThis"])

        assert_equal str_triple.cs253reject{|a| a.length <11},["anotherString"]
        assert_equal int_triple.cs253reject{|a| a.even?},[1,5,99,3,77]
        assert_equal str_triple.cs253reject{|a| a.length >8},["string", "notThis"]
    end

    def test_select
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253select{|i| i.even? },[2,4,6]
        assert_equal str_triple.cs253select{|i| i.length <= 3},["dog"]
        assert_equal empty_obj.cs253select{|i| i>0 },[]
    end

    def test_slice_after
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(['dog','food','apple','sheep','ace','cloud'])

        assert_equal int_triple.cs253slice_after{|i| i.even?}, [[1,5,99,3,2],[77]]
        assert_equal str_triple.cs253slice_after(/^a/),[['dog','food','apple'],['sheep','ace'],['cloud']]
        assert_equal int_triple.cs253slice_after{|i| i>10}, [[1,5,99],[3,2,77]]
    end

    def test_slice_before
        int_triple = CS253Array.new([1, 5, 99, 3, 2,77])
        str_triple = CS253Array.new(['dog','food','apple','sheep','ace','cloud'])

        assert_equal int_triple.cs253slice_before{|i| i.even?}, [[1,5,99,3],[2,77]]
        assert_equal str_triple.cs253slice_before(/^a/),[['dog','food'],['apple','sheep'],['ace','cloud']]
        assert_equal int_triple.cs253slice_before{|i| i>10}, [[1,5],[99,3,2],[77]]
    end

    def test_sum 
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253sum{|i| i*10 },210
        assert_equal int_triple.cs253sum,21
        assert_equal int_triple.cs253sum{|i| i-1 },15
    end

    def test_take
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253take(2),[1,2]
        assert_equal int_triple.cs253take(4), [1,2,3,4]
        assert_equal str_triple.cs253take(1), ['dog']
    end

    def test_take_while
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 2])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253take_while{|i| i<4},[1,2,3]
        assert_equal int_triple.cs253take_while{|i| i%2==0},[]
        assert_equal str_triple.cs253take_while{|i| i.length <4},['dog']
    end

    def test_to_a
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 2])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253to_a,[1,2,3,4,5,2]
        assert_equal str_triple.cs253to_a,["dog", "bear", "parrot"]
        assert_equal empty_obj.cs253to_a,[]
    end

    def test_uniq
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 2])
        str_triple = CS253Array.new(["dog", "bear","dog","parrot", "dog", "bear"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253uniq,[1,2,3,4,5]
        assert_equal str_triple.cs253uniq,["dog", "bear", "parrot"]
        assert_equal empty_obj.cs253uniq,[]
    end

    #bad test suppose to return nil with no block
    def test_zip
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 2])
        str_triple = CS253Array.new(["dog", "bear", "parrot"])
        obj = CS253Array.new([1,2,3])

        assert_equal int_triple.cs253zip([1,1,1],[2,2,2]),[[1, 1, 2], [2, 1, 2], [3, 1, 2], [4, nil, nil], [5, nil, nil], [2, nil, nil]]
        assert_equal int_triple.cs253zip([1,1],[2,2,2,2,2,2]),[[1, 1, 2], [2, 1, 2], [3, nil, 2], [4, nil, 2], [5, nil, 2], [2, nil, 2]]
        # assert_equal obj.cs253zip([4,5,6]){|arr| arr[0] + arr[1] },[5,7,9]
    end

    def test_length
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 2])
        str_triple = CS253Array.new(["dog", "bear","dog"])
        empty_obj = CS253Array.new([])

        assert_equal int_triple.cs253length,6
        assert_equal str_triple.cs253length,3
        assert_equal empty_obj.cs253length,0
    end

    def test_slice_when
        int_triple = CS253Array.new([1,2,3,50,60,70])
        str_triple = CS253Array.new(['dog','food','apple','apple','ace','cloud'])

        assert_equal int_triple.cs253slice_when{|a,b| b-a > 20},[[1,2,3],[50,60,70]]
        assert_equal int_triple.cs253slice_when{|a,b| b-a > 2},[[1, 2, 3], [50], [60], [70]]
        assert_equal int_triple.cs253slice_when{|a,b| b-a > 1},[[1, 2, 3], [50], [60], [70]]
    end


    # def test_chunk
    #     int_triple = CS253Array.new([1,2,3,50,60,70])
    #     str_triple = CS253Array.new(['dog','food','apple','apple','ace'])

    #     assert_equal int_triple.cs253chunk{|a| a.even?} ,[false,[1],true,[2],false,[3],true,[50,60,70]]
    #     assert_equal str_triple.cs253chunk{|a| a.length == 3},[true,['dog'],false,['food','apple','apple'],true,['ace']]
    #     assert_equal str_triple.cs253chunk{|a| a.length >80},[false,['dog','food','apple','apple','ace']]
    # end

    def test_chunk_while
        int_triple = CS253Array.new([1,2,3,5,6,7])
        str_triple = CS253Array.new(['dog','food','apple','apple','ace'])

        assert_equal int_triple.cs253chunk_while{|a,b| a + 1 == b},[[1,2,3],[5,6,7]]
        assert_equal int_triple.cs253chunk_while{|a,b| a.even?},[[1], [2, 3], [5], [6, 7]]
        assert_equal int_triple.cs253chunk_while{|a,b| a.odd?},[[1, 2], [3, 5, 6]]
    end

    def test_group_by
        int_triple = CS253Array.new([1,2,3,5,6,7])
        str_triple = CS253Array.new(['dog','food','apple','ace'])

        assert_equal int_triple.cs253group_by{|i| i.even?},{true => [2,6], false => [1,3,5,7]}
        assert_equal int_triple.cs253group_by{|i| i < 3},{true => [1,2], false => [3,5,6,7]}
        assert_equal str_triple.cs253group_by{|i| i.length<4},{true => ['dog','ace'], false => ['food','apple']}
    end

    def test_group_by
        int_triple = CS253Array.new([1,2,3,5,6,7])
        str_triple = CS253Array.new(['dog','food','apple','ace'])

        assert_equal int_triple.cs253group_by{|i| i.even?},{true => [2,6], false => [1,3,5,7]}
        assert_equal int_triple.cs253group_by{|i| i < 3},{true => [1,2], false => [3,5,6,7]}
        assert_equal str_triple.cs253group_by{|i| i.length<4},{true => ['dog','ace'], false => ['food','apple']}
    end

    def test_reverse_each
        int_triple = CS253Array.new([1,2,3,5,6,7])
        str_triple = CS253Array.new(['dog','food','apple','ace'])

        assert_equal int_triple.cs253reverse_each{|i| i}.to_a,[7,6,5,3,2,1]
        assert_equal int_triple.cs253reverse_each{|i| i}.to_a,[7,6,5,3,2,1]
        assert_equal str_triple.cs253reverse_each{|i| i}.to_a,['ace','apple','food','dog']
    end
    
    #bad test
    # def test_sort_by
    #     int_triple = CS253Array.new([1,2,3,5,6,7])
    #     str_triple = CS253Array.new(['dog','food','apples'])

    #     assert_equal int_triple.cs253sort_by{|i| i},[7,6,5,3,2,1]
    #     assert_equal int_triple.cs253sort_by{|i| i*2},[7,6,5,3,2,1]
    #     assert_equal str_triple.cs253sort_by{|i| i.length},['apples','food','dog']
    # end

    #possibly wrong
    # def test_to_h
    #     int_triple = CS253Array.new(['a','b'])
    #     str_triple = CS253Array.new(['dog','food'])
    #     int_triple2 = CS253Array.new([1,2])

    #     assert_equal int_triple.cs253to_h,{'a' => 0, 'b' => 1}
    #     assert_equal int_triple2.cs253to_h,{1 => 0, 2 => 1}
    #     assert_equal str_triple.cs253to_h,{'dog' => 0, 'food' => 1}
    # end

end





