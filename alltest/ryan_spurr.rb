require 'minitest/autorun'
require './cs253Array.rb'

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
        str_triple = CS253Array.new(["ant", "bear", "cat"])

        assert str_triple.cs253all? { |word| word.length >= 3 } == true
        assert str_triple.cs253all? { |word| word.length >= 4 } == false
        assert CS253Array.new([nil, true, 99]).cs253all? == false
        assert CS253Array.new([]).cs253all?
    end

    def test_cs253any?
	str_triple = CS253Array.new(["ant", "bear", "cat"])
        assert str_triple.any? { |word| word.length >= 3 }
        assert str_triple.any? { |word| word.length >= 4 }
        assert CS253Array.new([nil, true, 99]).any?
        assert !CS253Array.new([]).any?
    end



    # more tests!
end



