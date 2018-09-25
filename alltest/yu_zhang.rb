require 'minitest/autorun'
require_relative 'cs253Array.rb'
require_relative 'triple.rb'

class CS253EnumTests < Minitest::Test
    def test_collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.collect{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.collect{|i| i.length}.to_a,[6,13,10]
    end

    def test_cs253all?
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
        other_triple = CS253Array.new([nil,true,99])

        # assert_equal true, int_triple.cs253all?(Numeric)
        assert_equal false, other_triple.cs253all?
        assert_equal true , CS253Array.new([]).cs253all?
        assert_equal true, str_triple.cs253all?{|word| word.length >= 4}
        # assert_equal true, str_triple.cs253all?(/t/)
    end

    def test_cs253any?
        int_triple = CS253Array.new([1, 2, true])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
        other_triple = CS253Array.new([nil,true,99])

        # assert_equal true, int_triple.cs253any?(Integer)
        assert_equal true, other_triple.cs253any?
        assert_equal false , CS253Array.new([]).cs253any?
        assert_equal true, str_triple.cs253any?{|word| word.length >= 4}
        # assert_equal true, str_triple.cs253any?(/t/)
    end
    def test_cs253chunk
        int_triple = CS253Array.new([3,1,4])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
        assert_equal [[false, ["string"]], [true, ["anotherString", "lastString"]]],str_triple.cs253chunk{|e| e.length > 6}
        assert_equal [[true,[3,1]],[false,[4]]] , int_triple.cs253chunk{|n| n.odd?}
        assert_equal [[false,[3,1]],[true,[4]]]  , int_triple.cs253chunk{|n| n.even?}
    end

    def test_cs253chunk_while
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [[1,2],[4]], int_triple.cs253chunk_while{|i,j| i+1 == j}
        assert_equal [["string", "another"],["lastString"]], str_triple.cs253chunk_while{|i,j| i.length+1 == j.length}
        assert_equal [[1],[2,4]] , int_triple.cs253chunk_while{|i,j| i+2 == j}
    end
    def test_cs253collect
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal [1,4,16], int_triple.cs253collect{|i| i*i}
        assert_equal ['cat','cat','cat'] ,int_triple.cs253collect{|i| 'cat'}
        assert_equal [6,7,10] , str_triple.cs253collect{|i| i.length}
    end
    def test_cs253collect_concat
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new(["string"], ["another"], ["lastString"])
        arr_triple = Triple.new([1,2],[4],[5])
        assert_equal [-1,1,-2,2,-4,4] , int_triple.cs253collect_concat{|i| [-i,i]}
        assert_equal [1,2,100,4,100,5,100], arr_triple.cs253collect_concat{|i| i+[100]}
        assert_equal ["string",'test', "another",'test', "lastString",'test'] ,str_triple.cs253collect_concat{|i| i +['test']}
    end
    def test_cs253collect
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal 3 , int_triple.cs253count
        assert_equal 3 , str_triple.cs253count
        assert_equal 2 ,int_triple.cs253count{|x|x%2==0}
        assert_equal 1,int_triple.cs253count(2)

    end
    def test_cs253cycle
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        a = []
        int_triple.cs253cycle(2){|x| a<<x}
        b = []
        str_triple.cs253cycle(3){|x|b<<x}
        # assert_equal  [], a
        c = []
        int_triple.cs253cycle(3){|x|c<<x*2}
        assert_equal [1,2,4,1,2,4] , a
        assert_equal ["string", "another", "lastString", "string", "another", "lastString", "string", "another", "lastString"],b
        assert_equal [2, 4, 8, 2, 4, 8, 2, 4, 8],c
    end
    def test_cs253detect
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "anothe", "lastString")

        assert_equal 4 , int_triple.cs253detect{|x|x==4}
        assert_equal 2 , int_triple.cs253detect{|x|x%2==0}
        assert_equal 'string' , str_triple.cs253detect{|x| x.length == 6}

    end
    def test_cs253drop
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "anothe", "lastString")
        assert_equal [4] ,int_triple.cs253drop(2)
        assert_equal [2,4],int_triple.cs253drop(1)
        assert_equal ["string", "anothe", "lastString"] , str_triple.cs253drop(0)
        
    end
    def test_cs253drop_while
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [2,4] ,int_triple.cs253drop_while{|x|x<2}
        assert_equal ["another", "lastString"] , str_triple.cs253drop_while{|x|x.length < 7}
        assert_equal ["lastString"] , str_triple.cs253drop_while{|x|x.length < 8}

    end 
    def test_cs253each_cons
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        #todo
        a=[]
        b=[]
        c=[]
        int_triple.cs253each_cons(2){|x| a<<x }
        str_triple.cs253each_cons(2){|x| b<<x }
        str_triple.cs253each_cons(1){|x| c<<x }
        assert_equal [[1,2],[2,4]] , a
        assert_equal [["string", "another"],["another", "lastString"]] , b
        assert_equal [["string"],["another"],["lastString"]], c
        
    end
    def test_cs253each_entry
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        int2_triple = Triple.new(1,3)
        a=[]
        b = []
        c = []
        int_triple.cs253each_entry{|x|a<<x}
        str_triple.cs253each_entry{|x|b<<x}
        int2_triple.cs253each_entry{|x|c<<x}
        assert_equal [1, 2, 4] , a
        assert_equal ["string", "another", "lastString"], b
        assert_equal [1, 3, nil], c
    end
    def test_cs253each_slice
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        # todo
        # assert_equal [[1,2],[4]] ,int_triple.cs253each_slice(2)
        # assert_equal [[1],[2],[4]],int_triple.cs253each_slice(1)
        # assert_equal [["string", "another"],["lastString"]] , str_triple.cs253each_slice(2)
    end
    def test_cs253each_with_index
        int_triple = Triple.new(1,2,4)
        int2_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        a = Hash.new
        b = Hash.new
        c = Hash.new
        int_triple.cs253each_with_index{|it,index|a[it]=index}
        str_triple.cs253each_with_index{|it,index|b[it]=index}
        int2_triple.cs253each_with_index{|it,index|c[it]=index}
        assert_equal [[1,0],[2,1],[4,2]] , a.to_a
        
        assert_equal [["string",0],["another",1],["lastString",2]] , b.to_a
        
        assert_equal [[1, 0], [2, 1], [4, 2]], c.to_a
        
    end

    def test_cs253each_with_object

        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal [1,4,16], int_triple.cs253each_with_object([]){|i,a| a << i*i}
        assert_equal ["string", "another", "lastString"] , str_triple.cs253each_with_object([]){|i,a| a << i}
        assert_equal ["stringstring", "anotheranother", "lastStringlastString"] , str_triple.cs253each_with_object([]){|i,a| a << i*2}

    end

    def test_cs253entries
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        #
    end

    def test_cs253find
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal 4 , int_triple.cs253find{|x|x==4}
        assert_equal 2 , int_triple.cs253find{|x|x%2==0}
        assert_equal 'string' , str_triple.cs253find{|x| x.length == 6}
    end
    def test_cs253find_all
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [2,4] , int_triple.cs253find_all{|x| x%2 == 0}
        assert_equal [ "another", "lastString"], str_triple.cs253find_all{|x| x.length >6}
        assert_equal ['string'], str_triple.cs253find_all{|x| x.length <7}
    end
    def test_cs253find_index
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal 1 , int_triple.cs253find_index(2)
        assert_equal 1, int_triple.cs253find_index{|x| x%2==0 }
        assert_equal 2 ,str_triple.cs253find_index{|x| x[2]=='s'}
    end
    def test_cs253first
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal 1 ,int_triple.cs253first
        assert_equal [1,2] , int_triple.cs253first(2)
        assert_equal ["string", "another"] , str_triple.cs253first(2)
    end
    def test_cs253flat_map
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new(["string"], ["another"], ["lastString"])
        arr_triple = Triple.new([1,2],[4],[5])
        assert_equal [-1,1,-2,2,-4,4] , int_triple.cs253flat_map{|i| [-i,i]}
        assert_equal [1,2,100,4,100,5,100], arr_triple.cs253flat_map{|i| i+[100]}
        assert_equal ["string",'test', "another",'test', "lastString",'test'] ,str_triple.cs253flat_map{|i| i +['test']}
    end

    def test_cs253grep
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "anothe", "lastString")
        assert_equal [2,4], (int_triple.cs253grep 2..4)
        assert_equal ["string","lastString"],str_triple.cs253grep(/ing/)
        assert_equal ["string","lastString"],str_triple.cs253grep(/r/)
        
    end
    def test_cs253grep_v
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal [1,4], int_triple.cs253grep_v(2)
        assert_equal [2,8], int_triple.cs253grep_v(2){|v| v*2}
        assert_equal ["another"] , str_triple.cs253grep_v(/ing/)
    end
    def test_cs253group_by
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal ({1=>[1], 0=>[2,4]}), int_triple.cs253group_by{|i| i%2}

    end
    def test_cs253include?
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        
        assert_equal true ,  int_triple.cs253include?(2)
        assert_equal false , int_triple.cs253include?(5)
        assert_equal true , str_triple.cs253include?('string')

    end
    def test_cs253inject
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        
        assert_equal 7 ,int_triple.cs253inject{|x,y| x+y}
        assert_equal 9 ,int_triple.cs253inject(2){|x,y| x+y}
        assert_equal 7 ,int_triple.cs253inject(:+)
        assert_equal 9 ,int_triple.cs253inject(2,:+)
    end

    def test_cs253map
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [1,4,16], int_triple.cs253map{|i| i*i}
        assert_equal ['cat','cat','cat'] ,int_triple.cs253map{|i| 'cat'}
        assert_equal [6,7,10] , str_triple.cs253map{|i| i.length}
    end
    def test_cs253max
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal 4 ,int_triple.cs253max()
        assert_equal [4,2] , int_triple.cs253max(2)
        assert_equal "lastString",str_triple.cs253max(){|x,y|x.length<=>y.length}
    end
    def test_cs253max_by
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal 4 ,int_triple.cs253max_by{|x|x}
        assert_equal [4,2] , int_triple.cs253max(2){|x|x}
        assert_equal "lastString",str_triple.cs253max(){|x|x.length}
    end
    def test_cs253member?
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        
        assert_equal true ,  int_triple.cs253member?(2)
        assert_equal false , int_triple.cs253member?(5)
        assert_equal true , str_triple.cs253member?('string')

    end
    def test_cs253min_by
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal 1 ,int_triple.cs253min_by{|x|x}
        assert_equal [1,2] , int_triple.cs253min_by(2){|x|x}
        assert_equal "string",str_triple.cs253min_by(){|x|x.length}
    end
    def test_cs253min
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal 1 ,int_triple.cs253min()
        assert_equal [1,2] , int_triple.cs253min(2)
        assert_equal "string",str_triple.cs253min(){|x,y|x.length<=>y.length}
    end

    def test_cs253minmax
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal [1,4], int_triple.cs253minmax
        assert_equal ["another","string", ],str_triple.cs253minmax
        assert_equal ["string", "lastString"], str_triple.cs253minmax{|x,y|x.length<=>y.length}
    end
    def test_cs253minmax_by
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal [1,4], int_triple.cs253minmax_by{|x|x}
        assert_equal ["another","string", ],str_triple.cs253minmax_by{|x|x}
        assert_equal ["string", "lastString"], str_triple.cs253minmax_by{|x|x.length}
    end



    def test_cs253to_a
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        int2_triple = Triple.new([1],[2],[4])
        assert_equal [1,2,4] , int_triple.cs253to_a
        assert_equal ["string", "another", "lastString"] , str_triple.cs253to_a
        assert_equal [[1],[2],[4]] , int2_triple.cs253to_a
    end
    def test_cs253sort
        int_triple = Triple.new(4,2,1)
        str_triple = Triple.new("string", "another", "lastString")
        str2_triple= Triple.new("abc",'bcde','c')
        assert_equal [1,2,4] , int_triple.cs253sort
        assert_equal ["another", "lastString", "string"], str_triple.cs253sort
        assert_equal [4,2,1] ,int_triple.cs253sort{|x,y| y<=> x}
        assert_equal ['c','abc','bcde'], str2_triple.cs253sort{|x,y|x.length<=>y.length}
    end
    def test_cs253sort_by
        int_triple = Triple.new(4,2,1)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [1,2,4] ,int_triple.cs253sort_by{|x|x}
        assert_equal [4,2,1] , int_triple.cs253sort_by{|x|-x}
        assert_equal ["string", "another", "lastString"], str_triple.cs253sort_by{|x|x.length}
    end
    def test_cs253none?
        int_triple = Triple.new(4,2,1)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal true , int_triple.cs253none?{|x|x>10}
        assert_equal false , int_triple.cs253none?{|x|x>3}
        assert_equal true , str_triple.cs253none?{|c|c.length > 100}
    end
    def test_cs253one?
        int_triple = Triple.new(4,2,1)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal false , int_triple.cs253one?{|x|x>10}
        assert_equal true , int_triple.cs253one?{|x|x>3}
        assert_equal false , str_triple.cs253one?{|c|c.length > 100}
    end
    def test_cs253partition
        int_triple = Triple.new(4,2,1)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [[4,2],[1]], int_triple.cs253partition{|v|v.even?}
        assert_equal [[1],[4,2]], int_triple.cs253partition{|v|v.odd?}
        assert_equal [["string"],["another", "lastString"]], str_triple.cs253partition{|x|x.length<7}
    end
    def test_cs253reduce
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        
        assert_equal 7 ,int_triple.cs253reduce{|x,y| x+y}
        assert_equal 9 ,int_triple.cs253reduce(2){|x,y| x+y}
        assert_equal 7 ,int_triple.cs253reduce(:+)
        assert_equal 9 ,int_triple.cs253reduce(2,:+)
    end
    def test_cs253reject
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [1], int_triple.cs253reject{|x|x%2==0}
    end

    def test_cs253slice_when


        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [[1,2],[4]], int_triple.cs253slice_when{|i,j| i+1 != j}
        assert_equal [["string", "another"],["lastString"]], str_triple.cs253slice_when{|i,j| i.length+1 != j.length}
        assert_equal [[1],[2,4]] , int_triple.cs253slice_when{|i,j| i+2 != j}
    end
    def test_cs253sum

        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal 7, int_triple.cs253sum()
        assert_equal 17, int_triple.cs253sum(10)
        assert_equal 14 , int_triple.cs253sum{|x|x*2}
        assert_equal "stringanotherlastString" ,str_triple.cs253sum('')
    end

    def test_cs253take

        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [1], int_triple.cs253take(1)
        assert_equal [1,2], int_triple.cs253take(2)
        assert_equal ["string", "another"],str_triple.cs253take(2)
    end
    def test_cs253take_while

        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")
        assert_equal [1], int_triple.cs253take_while(){|i|i<2}
        assert_equal [1,2], int_triple.cs253take_while(){|i|i<3}
        assert_equal ["string", "another"],str_triple.cs253take_while(){|i|i.length<8}
    end

    def test_cs253to_h
        int2_triple = Triple.new(1,2)
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal ({1 => 2, 3 => 4, 5 => 6}), CS253Array.new(([[1, 2], [3, 4], [5, 6]])).cs253to_h
        #tudo
        # assert_equal ({1=>0, 2=>1, 4=>2}), int_triple.cs253each_with_index.cs253to_h
        # assert_equal ({"string"=>0, "another"=>1, "lastString"=>2}), str_triple.cs253each_with_index.cs253to_h
        # assert_equal ({1=>0, 2=>1, nil=>2}),int2_triple.cs253each_with_index.cs253to_h
    end

    def test_cs253uniq
        int_triple = Triple.new(1,2,2)
        str_triple = Triple.new("another", "another", "lastString")

        assert_equal [1,2] ,int_triple.cs253uniq
        assert_equal ["another", "lastString"] , str_triple.cs253uniq
        assert_equal [1,2] , int_triple.cs253uniq{|v|v*2}
    end

    def test_cs253zip
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("another", "another", "lastString")

        assert_equal [[1, 4], [2, 5], [4, 6]] ,int_triple.cs253zip([4,5,6])
        assert_equal [[1, 4, 8], [2, 5, nil], [4, 6, nil]], int_triple.cs253zip([4,5,6],[8])
        assert_equal [["another", 1], ["another", 2], ["lastString", 3]] , str_triple.cs253zip([1,2,3])
        c = []
        int_triple.cs253zip([1,2,4]){|x,y| c << x+y}
        assert_equal [2,4,8] , c 
    end
    def test_cs253length
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("another", "another", "lastString")
        int2_triple = Triple.new(1,2)
        assert_equal 3, int_triple.cs253length
        assert_equal 3 ,str_triple.cs253length
        assert_equal 3 , int2_triple.cs253length #the length of triple class is inherent that is 3 

    end
    def test_cs253slice_before
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal [[1], [2, 4]] , int_triple.cs253slice_before(2)
        assert_equal [["string"], ["another", "lastString"]], str_triple.cs253slice_before('another')
        assert_equal [[1], [2], [4]] , int_triple.cs253slice_before{|x| x%2 == 0}

    end
    def test_cs253slice_after
        int_triple = Triple.new(1,2,4)
        str_triple = Triple.new("string", "another", "lastString")

        assert_equal [[1, 2], [4]] , int_triple.cs253slice_after(2)
        assert_equal [["string", "another"], ["lastString"]], str_triple.cs253slice_after('another')
        assert_equal [[1, 2], [4]], int_triple.cs253slice_after{|x| x%2 == 0}
    end
        
end



