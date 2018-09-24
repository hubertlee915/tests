require 'minitest/autorun'
require_relative './cs253Array.rb'
require_relative './triple.rb'













class DumbHash < Hash
  include CS253Enumerable
end

class CS253EnumTests < Minitest::Test

  parallelize_me!

  make_my_diffs_pretty!

  def setup
    @empty_array = CS253Array.new([])
  end







  def test_collect_empty

    assert_equal @empty_array.cs253collect { |i| i.nil? }.to_a, []
    assert_equal @empty_array.cs253map { |i| i.nil? }.to_a, []

    # Correctness check
    assert_equal @empty_array.collect { |i| i.nil? }.to_a, []
    assert_equal @empty_array.map { |i| i.nil? }.to_a, []

  end

  def test_collect_array
    hodge_podge = CS253Array.new([1,nil,"435",:pleeze, Triple.new(1, 3, 1), ["nested"], {:key => "value"}, CS253Array, CS253Array.new(["teehee"])])
    assert_equal(
        hodge_podge.cs253collect {|i| i.class.included_modules.include? CS253Enumerable}.to_a,
        [false,false,false,false,true,false,false,false,true]
        )
    assert_equal(
        hodge_podge.cs253map {|i| i.class.included_modules.include? CS253Enumerable}.to_a,
        [false,false,false,false,true,false,false,false,true]
    )
    # Correctness check
    assert_equal(
        hodge_podge.collect {|i| i.class.included_modules.include? CS253Enumerable}.to_a,
        [false,false,false,false,true,false,false,false,true]
    )

    assert_equal(
        hodge_podge.map {|i| i.class.included_modules.include? CS253Enumerable}.to_a,
        [false,false,false,false,true,false,false,false,true]
    )
  end

  def test_collect_triple
    int_triple = Triple.new(1, 2, 3)
    str_triple = Triple.new("string", "anotherString", "lastString")

    assert_equal int_triple.cs253collect {|i| i.to_s}.to_a, ["1", "2", "3"]
    assert_equal str_triple.cs253collect {|i| i.length}.to_a, [6, 13, 10]

    assert_equal int_triple.cs253map {|i| i.to_s}.to_a, ["1", "2", "3"]
    assert_equal str_triple.cs253map {|i| i.length}.to_a, [6, 13, 10]

    # Correctness Check
    assert_equal int_triple.collect {|i| i.to_s}.to_a, ["1", "2", "3"]
    assert_equal str_triple.collect {|i| i.length}.to_a, [6, 13, 10]

    assert_equal int_triple.map {|i| i.to_s}.to_a, ["1", "2", "3"]
    assert_equal str_triple.map {|i| i.length}.to_a, [6, 13, 10]
  end

  def test_take_while_empty
    assert_equal @empty_array.cs253take_while { |i| i }.to_a, []
    # Correctness check
    assert_equal @empty_array.take_while { |i| i }.to_a, []
  end

  def test_take_while_not_first
    false_first_array = CS253Array.new([false, true, true])
    false_first_triple = Triple.new(false, true, true)

    assert_equal false_first_array.cs253take_while { |el| el }.to_a, []
    assert_equal false_first_triple.cs253take_while { |el| el }.to_a, []

    # Correctness check
    assert_equal false_first_array.take_while { |el| el }.to_a, []
    assert_equal false_first_triple.take_while { |el| el }.to_a, []
  end

  def test_take_while_all
    false_first_array = CS253Array.new([1, 2, 3])
    false_first_triple = Triple.new(1, 2, 3)

    assert_equal false_first_array.cs253take_while { |el| el < 4 }.to_a, [1, 2, 3]
    assert_equal false_first_triple.cs253take_while { |el| el < 4 }.to_a, [1, 2, 3]

    # Correctness check
    assert_equal false_first_array.take_while { |el| el < 4 }.to_a, [1, 2, 3]
    assert_equal false_first_triple.take_while { |el| el < 4 }.to_a, [1, 2, 3]
  end

  def test_take_while_not_end
    false_first_array = CS253Array.new([1, 2, 3])
    false_first_triple = Triple.new(1, 2, 3)

    assert_equal false_first_array.cs253take_while { |el| el < 3 }.to_a, [1, 2]
    assert_equal false_first_triple.cs253take_while { |el| el < 3 }.to_a, [1, 2]

    # Correctness check
    assert_equal false_first_array.take_while { |el| el < 3 }.to_a, [1, 2]
    assert_equal false_first_triple.take_while { |el| el < 3 }.to_a, [1, 2]
  end

  def test_take_while_not_middle
    false_first_array = CS253Array.new([1, 2, 3])
    false_first_triple = Triple.new(1, 2, 3)

    assert_equal false_first_array.cs253take_while { |el| el < 2 }.to_a, [1]
    assert_equal false_first_triple.cs253take_while { |el| el < 2 }.to_a, [1]

    # Correctness check
    assert_equal false_first_array.take_while { |el| el < 2 }.to_a, [1]
    assert_equal false_first_triple.take_while { |el| el < 2 }.to_a, [1]
  end


  def test_take_zero
    int_array = CS253Array.new([0,1,2,4])
    string_triple = Triple.new("one", "seven", "nine")

    assert_equal @empty_array.cs253take(0).to_a, []
    assert_equal int_array.cs253take(0).to_a, []
    assert_equal string_triple.cs253take(0).to_a, []

    # Correctness check
    assert_equal @empty_array.take(0).to_a, []
    assert_equal int_array.take(0).to_a, []
    assert_equal string_triple.take(0).to_a, []
  end

  def test_take_middle
    int_array = CS253Array.new([0,1,2,4])
    string_triple = Triple.new("one", "seven", "nine")

    assert_equal int_array.cs253take(3).to_a, [0,1,2]
    assert_equal string_triple.cs253take(2).to_a, ["one", "seven"]

    # Correctness check
    assert_equal int_array.take(3).to_a, [0,1,2]
    assert_equal string_triple.take(2).to_a, ["one", "seven"]
  end

  def test_take_beyond
    int_array = CS253Array.new([0,1,2,4])
    string_triple = Triple.new("one", "seven", "nine")

    assert_equal @empty_array.cs253take(22).to_a, []
    assert_equal int_array.cs253take(33).to_a, [0, 1, 2 , 4]
    assert_equal string_triple.cs253take(88).to_a, ["one", "seven", "nine"]

    # Correctness check
    assert_equal @empty_array.take(22).to_a, []
    assert_equal int_array.take(33).to_a, [0, 1, 2 , 4]
    assert_equal string_triple.take(88).to_a, ["one", "seven", "nine"]
  end

  def test_first_default
    int_array = CS253Array.new([0,1,2,4])
    string_triple = Triple.new("one", "seven", "nine")
    nil_first_array = CS253Array.new([nil, 2, 3])
    nil_first_triple = Triple.new(nil, 2,3)

    assert_nil @empty_array.cs253first
    assert_equal int_array.cs253first, 0
    assert_equal string_triple.cs253first, "one"
    assert_nil nil_first_array.cs253first
    assert_nil nil_first_triple.cs253first

    # Correctness check
    assert_nil @empty_array.first
    assert_equal int_array.first, 0
    assert_equal string_triple.first, "one"
    assert_nil nil_first_array.first
    assert_nil nil_first_triple.first

  end

  def test_first_zero
    int_array = CS253Array.new([0,1,2,4])
    nil_first_array = CS253Array.new([nil, 2, 3])

    assert_equal @empty_array.cs253first(0).to_a, []
    assert_equal int_array.cs253first(0).to_a, []
    assert_equal nil_first_array.cs253first(0).to_a, []

    # Correctness check
    assert_equal @empty_array.first(0).to_a, []
    assert_equal int_array.first(0).to_a, []
    assert_equal nil_first_array.first(0).to_a, []
  end

  def test_first_middle
    int_array = CS253Array.new([0,1,2,4])
    string_triple = Triple.new("one", "seven", "nine")

    assert_equal int_array.cs253first(3).to_a, [0,1,2]
    assert_equal string_triple.cs253first(2).to_a, ["one", "seven"]

    # Correctness check
    assert_equal int_array.first(3).to_a, [0,1,2]
    assert_equal string_triple.first(2).to_a, ["one", "seven"]
  end

  def test_first_beyond
    int_array = CS253Array.new([0,1,2,4])
    string_triple = Triple.new("one", "seven", "nine")

    assert_equal @empty_array.cs253first(22).to_a, []
    assert_equal int_array.cs253first(33).to_a, [0, 1, 2 , 4]
    assert_equal string_triple.cs253first(88).to_a, ["one", "seven", "nine"]

    # Correctness check
    assert_equal @empty_array.first(22).to_a, []
    assert_equal int_array.first(33).to_a, [0, 1, 2 , 4]
    assert_equal string_triple.first(88).to_a, ["one", "seven", "nine"]
  end


  def test_inject_init_sym
    string_array = CS253Array.new(['Love ', 'To ', 'Shit.'])
    array_pair = CS253Array.new([3, -3])
    triple_int = Triple.new(-1, 89, 66)
    triple_null = Triple.new(5)

    assert_equal @empty_array.cs253inject(22, :+), 22
    assert_equal string_array.cs253inject('I ', :+), 'I Love To Shit.'
    assert_equal array_pair.cs253inject(7, :*), -63
    assert_equal triple_int.cs253inject(4, :^), 4 ^ -1 ^ 89 ^ 66
    assert_equal triple_null.cs253inject([], :<<).to_a, [5, nil, nil]

    assert_equal @empty_array.cs253reduce(22, :+), 22
    assert_equal string_array.cs253reduce('I ', :+), 'I Love To Shit.'
    assert_equal array_pair.cs253reduce(7, :*), -63
    assert_equal triple_int.cs253reduce(4, :^), 4 ^ -1 ^ 89 ^ 66
    assert_equal triple_null.cs253reduce([], :<<).to_a, [5, nil, nil]


    # Correctness check
    assert_equal @empty_array.inject(22, :+), 22
    assert_equal string_array.inject('I ', :+), 'I Love To Shit.'
    assert_equal array_pair.inject(7, :*), -63
    assert_equal triple_int.inject(4, :^), 4 ^ -1 ^ 89 ^ 66
    assert_equal triple_null.inject([], :<<).to_a, [5, nil, nil]

    assert_equal @empty_array.reduce(22, :+), 22
    assert_equal string_array.reduce('I ', :+), 'I Love To Shit.'
    assert_equal array_pair.reduce(7, :*), -63
    assert_equal triple_int.reduce(4, :^), 4 ^ -1 ^ 89 ^ 66
    assert_equal triple_null.reduce([], :<<).to_a, [5, nil, nil]
  end

  def test_inject_sym
    string_array = CS253Array.new(['Love ', 'To ', 'Shit.'])
    singleton_nil = CS253Array.new(['yo'])
    array_pair = CS253Array.new([3, -3])
    triple_int = Triple.new(-1, 89, 66)
    triple_of_array = Triple.new(["yo", "py"], ["hi", "lol"], [1,2,3,4])


    assert_nil @empty_array.cs253inject(:+)
    assert_equal string_array.cs253inject(:+), 'Love To Shit.'
    assert_equal singleton_nil.cs253inject(:*), 'yo'
    assert_equal array_pair.cs253inject(:-), 6
    assert_equal triple_int.cs253inject(:/), -1/89/66
    assert_equal triple_of_array.cs253inject(:+), ["yo", "py", "hi", "lol", 1 ,2, 3, 4]

    assert_nil @empty_array.cs253reduce(:+)
    assert_equal string_array.cs253reduce(:+), 'Love To Shit.'
    assert_equal singleton_nil.cs253reduce(:*), 'yo'
    assert_equal array_pair.cs253reduce(:-), 6
    assert_equal triple_int.cs253reduce(:/), -1/89/66
    assert_equal triple_of_array.cs253reduce(:+), ["yo", "py", "hi", "lol", 1 ,2, 3, 4]


    # Correctness check
    assert_nil @empty_array.inject(:+)
    assert_equal string_array.inject(:+), 'Love To Shit.'
    assert_equal singleton_nil.inject(:*), 'yo'
    assert_equal array_pair.inject(:-), 6
    assert_equal triple_int.inject(:/), -1/89/66
    assert_equal triple_of_array.inject(:+), ["yo", "py", "hi", "lol", 1 ,2, 3, 4]

    assert_nil @empty_array.reduce(:+)
    assert_equal string_array.reduce(:+), 'Love To Shit.'
    assert_equal singleton_nil.reduce(:*), 'yo'
    assert_equal array_pair.reduce(:-), 6
    assert_equal triple_int.reduce(:/), -1/89/66
    assert_equal triple_of_array.reduce(:+), ["yo", "py", "hi", "lol", 1 ,2, 3, 4]
  end

  def test_inject_init_block
    string_array = CS253Array.new(['Love ', 'To ', 'Shit.'])
    array_pair = CS253Array.new([3, -3])
    triple_int = Triple.new(-1, 89, 66)
    triple_null = Triple.new(5)
    single_nil_array = CS253Array.new([nil])


    assert_equal @empty_array.cs253inject(22) { |memo, obj| memo + obj }, 22
    assert_equal string_array.cs253inject('I ') { |memo, obj| memo + obj }, 'I Love To Shit.'
    assert_equal array_pair.cs253inject(7) { |memo, obj| memo * obj }, -63
    assert_equal triple_int.cs253inject(4) { |memo, obj| memo ^ obj }, 4 ^ -1 ^ 89 ^ 66
    assert_equal triple_null.cs253inject([]) { |memo, obj| memo << obj }.to_a, [5, nil, nil]
    assert single_nil_array.cs253inject(nil) { |memo, obj| memo.nil? && obj.nil? }

    assert_equal @empty_array.cs253reduce(22) { |memo, obj| memo + obj }, 22
    assert_equal string_array.cs253reduce('I ') { |memo, obj| memo + obj }, 'I Love To Shit.'
    assert_equal array_pair.cs253reduce(7) { |memo, obj| memo * obj }, -63
    assert_equal triple_int.cs253reduce(4) { |memo, obj| memo ^ obj }, 4 ^ -1 ^ 89 ^ 66
    assert_equal triple_null.cs253reduce([]) { |memo, obj| memo << obj }.to_a, [5, nil, nil]
    assert single_nil_array.cs253reduce(nil) { |memo, obj| memo.nil? && obj.nil? }

    # Correctness check
    assert_equal @empty_array.inject(22) { |memo, obj| memo + obj }, 22
    assert_equal string_array.inject('I ') { |memo, obj| memo + obj }, 'I Love To Shit.'
    assert_equal array_pair.inject(7) { |memo, obj| memo * obj }, -63
    assert_equal triple_int.inject(4) { |memo, obj| memo ^ obj }, 4 ^ -1 ^ 89 ^ 66
    assert_equal triple_null.inject([])  { |memo, obj| memo << obj }.to_a, [5, nil, nil]
    assert single_nil_array.inject(nil) { |memo, obj| memo.nil? && obj.nil? }

    assert_equal @empty_array.reduce(22) { |memo, obj| memo + obj }, 22
    assert_equal string_array.reduce('I ') { |memo, obj| memo + obj }, 'I Love To Shit.'
    assert_equal array_pair.reduce(7) { |memo, obj| memo * obj }, -63
    assert_equal triple_int.reduce(4) { |memo, obj| memo ^ obj }, 4 ^ -1 ^ 89 ^ 66
    assert_equal triple_null.reduce([])  { |memo, obj| memo << obj }.to_a, [5, nil, nil]
    assert single_nil_array.reduce(nil) { |memo, obj| memo.nil? && obj.nil? }
  end

  def test_inject_block
    string_array = CS253Array.new(['Love ', 'To ', 'Shit.'])
    array_pair = CS253Array.new([3, -3])
    triple_int = Triple.new(-1, 89, 66)
    single_nil_array = CS253Array.new([nil])


    assert_nil(@empty_array.cs253inject{ |memo, obj| memo + obj })
    assert_equal string_array.cs253inject { |memo, obj| memo + obj }, 'Love To Shit.'
    assert_equal array_pair.cs253inject { |memo, obj| memo * obj }, -9
    assert_equal triple_int.cs253inject { |memo, obj| memo ^ obj }, -1 ^ 89 ^ 66
    assert_nil(single_nil_array.cs253inject { |memo, obj| memo.nil? && obj.nil? })

    assert_nil(@empty_array.cs253reduce{ |memo, obj| memo + obj })
    assert_equal string_array.cs253reduce { |memo, obj| memo + obj }, 'Love To Shit.'
    assert_equal array_pair.cs253reduce { |memo, obj| memo * obj }, -9
    assert_equal triple_int.cs253reduce { |memo, obj| memo ^ obj }, -1 ^ 89 ^ 66
    assert_nil(single_nil_array.cs253reduce { |memo, obj| memo.nil? && obj.nil? })

    # Correctness check
    assert_nil(@empty_array.inject{ |memo, obj| memo + obj })
    assert_equal string_array.inject { |memo, obj| memo + obj }, 'Love To Shit.'
    assert_equal array_pair.inject { |memo, obj| memo * obj }, -9
    assert_equal triple_int.inject { |memo, obj| memo ^ obj }, -1 ^ 89 ^ 66
    assert_nil(single_nil_array.inject { |memo, obj| memo.nil? && obj.nil? })

    assert_nil(@empty_array.reduce{ |memo, obj| memo + obj })
    assert_equal string_array.reduce { |memo, obj| memo + obj }, 'Love To Shit.'
    assert_equal array_pair.reduce { |memo, obj| memo * obj }, -9
    assert_equal triple_int.reduce { |memo, obj| memo ^ obj }, -1 ^ 89 ^ 66
    assert_nil(single_nil_array.reduce { |memo, obj| memo.nil? && obj.nil? })

  end

  def test_entries
    string_array = CS253Array.new(['Love ', 'To ', 'Shit.'])
    array_pair = CS253Array.new([3, -3])
    triple_int = Triple.new(-1, 89, 66)
    triple_null = Triple.new(5)
    single_nil_array = CS253Array.new([nil])


    assert_equal @empty_array.cs253entries, []
    assert_equal string_array.cs253entries, ['Love ', 'To ', 'Shit.']
    assert_equal array_pair.cs253entries, [3, -3]
    assert_equal triple_int.cs253entries, [-1, 89, 66]
    assert_equal triple_null.cs253entries, [5, nil, nil]
    assert_equal single_nil_array.cs253entries, [nil]

    assert_equal @empty_array.cs253to_a, []
    assert_equal string_array.cs253to_a, ['Love ', 'To ', 'Shit.']
    assert_equal array_pair.cs253to_a, [3, -3]
    assert_equal triple_int.cs253to_a, [-1, 89, 66]
    assert_equal triple_null.cs253to_a, [5, nil, nil]
    assert_equal single_nil_array.cs253to_a, [nil]

    # Correctness check
    assert_equal @empty_array.entries, []
    assert_equal string_array.entries, ['Love ', 'To ', 'Shit.']
    assert_equal array_pair.entries, [3, -3]
    assert_equal triple_int.entries, [-1, 89, 66]
    assert_equal triple_null.entries, [5, nil, nil]
    assert_equal single_nil_array.entries, [nil]

    assert_equal @empty_array.to_a, []
    assert_equal string_array.to_a, ['Love ', 'To ', 'Shit.']
    assert_equal array_pair.to_a, [3, -3]
    assert_equal triple_int.to_a, [-1, 89, 66]
    assert_equal triple_null.to_a, [5, nil, nil]
    assert_equal single_nil_array.to_a, [nil]


  end

  def test_sum_default
    int_singleton_array = CS253Array.new([4])
    int_triple = Triple.new(4, 7, 9)


    assert_equal @empty_array.cs253sum, 0
    assert_equal int_singleton_array.cs253sum, 4
    assert_equal int_triple.cs253sum, 20

    # Correctness check
    assert_equal @empty_array.sum, 0
    assert_equal int_singleton_array.sum, 4
    assert_equal int_triple.sum, 20
  end

  def test_sum_init
    int_singleton_array = CS253Array.new([4])
    string_array = CS253Array.new(["HI ", "JO ", "SHO ", "POO"])
    int_triple = Triple.new(4, 7, 9)
    triple_of_arrays = Triple.new([1, 2, 3], [4, 5, 6], [7, 8, 9])


    assert_equal @empty_array.cs253sum(2), 2
    assert_equal int_singleton_array.cs253sum(5), 9
    assert_equal string_array.cs253sum(""), "HI JO SHO POO"
    assert_equal int_triple.cs253sum(3), 23
    assert_equal triple_of_arrays.cs253sum([[[]]]), [[[]], 1, 2, 3, 4, 5, 6, 7, 8, 9]

    # Correctness check
    assert_equal @empty_array.sum(2), 2
    assert_equal int_singleton_array.sum(5), 9
    assert_equal string_array.sum(""), "HI JO SHO POO"
    assert_equal int_triple.sum(3), 23
    assert_equal triple_of_arrays.sum([[[]]]), [[[]], 1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def test_sum_init_block
    int_singleton_array = CS253Array.new([4])
    string_array = CS253Array.new(["HI ", "JO ", "SHO ", "POO"])
    int_triple = Triple.new(4, 7, 9)
    triple_of_arrays = Triple.new([1, 2, 3], [4, 5, 6], [7, 8, 9])

    assert_equal @empty_array.cs253sum(2) { |el| el**3 }, 2
    assert_equal int_singleton_array.cs253sum(5) { |el| el+2 }, 11
    assert_equal string_array.cs253sum("") { |el| el.downcase }, "hi jo sho poo"
    assert_equal int_triple.cs253sum(3) { |el| el*2 }, 3+2*(4+7+9)
    assert_equal triple_of_arrays.cs253sum([[[]]]) { |el| el + [0]}, [[[]], 1, 2, 3, 0, 4, 5, 6, 0, 7, 8, 9, 0]

    # Correctness check
    assert_equal @empty_array.sum(2) { |el| el**3 }, 2
    assert_equal int_singleton_array.sum(5) { |el| el+2 }, 11
    assert_equal string_array.sum("") { |el| el.downcase }, "hi jo sho poo"
    assert_equal int_triple.sum(3) { |el| el*2 }, 3+2*(4+7+9)
    assert_equal triple_of_arrays.sum([[[]]]) { |el| el + [0]}, [[[]], 1, 2, 3, 0, 4, 5, 6, 0, 7, 8, 9, 0]
  end

  def test_sum_default_block
    int_singleton_array = CS253Array.new([4])
    int_triple = Triple.new(4, 7, 9)

    assert_equal @empty_array.cs253sum { |el| el * 2 }, 0
    assert_equal int_singleton_array.cs253sum { |el| el**2 }, 16
    assert_equal int_triple.cs253sum { |el| el - 1 }, 17

    # Correctness check
    assert_equal @empty_array.sum { |el| el * 2 }, 0
    assert_equal int_singleton_array.sum { |el| el**2 }, 16
    assert_equal int_triple.sum { |el| el - 1 }, 17

  end

  def test_select
    int_array = CS253Array.new([0, 1, 2, 3, 4])
    bool_trippler = Triple.new(true, false, true)

    assert_equal @empty_array.cs253select { |x| x.even? }, []
    assert_equal int_array.cs253select { |x| x.even? }, [0,2,4]
    assert_equal bool_trippler.cs253select { |x| x }, [true, true]

    assert_equal @empty_array.cs253find_all { |x| x.even? }, []
    assert_equal int_array.cs253find_all { |x| x.even? }, [0,2,4]
    assert_equal bool_trippler.cs253find_all { |x| x }, [true, true]

    # Correctness check
    assert_equal @empty_array.select { |x| x.even? }, []
    assert_equal int_array.select { |x| x.even? }, [0,2,4]
    assert_equal bool_trippler.select { |x| x }, [true, true]


    assert_equal @empty_array.find_all { |x| x.even? }, []
    assert_equal int_array.find_all { |x| x.even? }, [0,2,4]
    assert_equal bool_trippler.find_all { |x| x }, [true, true]


  end

  def test_each_with_index
    int_array = CS253Array.new([0, 1, 2, 3, 4])
    bool_trippler = Triple.new(true, false, true)
    # TODO: How do I check this actual behavior other than return value?

    assert_equal @empty_array.cs253each_with_index { |obj, index| [index, obj] }.to_a, []
    assert_equal int_array.cs253each_with_index { |obj, index| [index, obj] }.to_a, [0, 1, 2, 3, 4]
    assert_equal bool_trippler.cs253each_with_index { |obj, index| [index, obj] }.to_a, [true,false,true]

    # Correctness check
    assert_equal @empty_array.each_with_index { |obj, index| [index, obj] }.to_a, []
    assert_equal int_array.each_with_index { |obj, index| [index, obj] }.to_a, [0, 1, 2, 3, 4]
    assert_equal bool_trippler.each_with_index { |obj, index| [index, obj] }.to_a, [true,false,true]

  end

  def test_flat_map

    weird_array = CS253Array.new([3,2,99,[2,3,],-3,4,44])
    weird_triple = Triple.new(1,CS253Array.new([2,3]),4)

    #
    # nastyness_array = CS253Array.new([1,2,CS253Array.new([3,4,Triple.new(5,6,CS253Array.new([7,8])),9]),10])
    # nastyness_triple = Triple.new(
    #     CS253Array.new(
    #         [1,2,CS253Array.new(
    #             [3,4,Triple.new(5,6, CS253Array.new([7,8]) ),9]),10]),11,12
    # )

    assert_equal([], @empty_array.cs253flat_map { |el| el })
    assert_equal weird_array.cs253flat_map { |el| el }, [3,2,99,2,3,-3,4,44]
    assert_equal weird_triple.cs253flat_map { |el| el }, [1,2,3,4]

    assert_equal([], @empty_array.cs253collect_concat { |el| el })
    assert_equal weird_array.cs253collect_concat { |el| el }, [3,2,99,2,3,-3,4,44]
    assert_equal weird_triple.cs253collect_concat { |el| el }, [1,2,3,4]

    # Correctness check
    assert_equal([], @empty_array.flat_map { |el| el })
    assert_equal weird_array.flat_map { |el| el }, [3,2,99,2,3,-3,4,44]
    assert_equal weird_triple.flat_map { |el| el }, [1,2,3,4]

    assert_equal([], @empty_array.collect_concat { |el| el })
    assert_equal weird_array.collect_concat { |el| el }, [3,2,99,2,3,-3,4,44]
    assert_equal weird_triple.collect_concat { |el| el }, [1,2,3,4]


  end

  def test_count_default
    some_array = CS253Array.new([3,12,58,40,31])
    some_triple = Triple.new(4,3,1)


    assert_equal @empty_array.cs253count, 0
    assert_equal some_array.cs253count, 5
    assert_equal some_triple.cs253count, 3
    # Correctness check
    assert_equal @empty_array.count, 0
    assert_equal some_array.count, 5
    assert_equal some_triple.count, 3
  end

  def test_count_item
    some_array = CS253Array.new([1,CS253Array.new([2,3]),4,3])
    some_triple = Triple.new(CS253Array.new([2,3,4]),1, CS253Array.new([2,3,4]))


    assert_equal @empty_array.cs253count(2), 0
    assert_equal some_array.cs253count(CS253Array.new([2, 3])), 1
    assert_equal some_array.cs253count(CS253Array.new([2, 3, 3])), 0

    assert_equal some_triple.cs253count(CS253Array.new([2,3,4])), 2
    assert_equal some_triple.cs253count(CS253Array.new([2,3,4])) { |el| el < 3 }, 2

    # Correctness check
    assert_equal @empty_array.count(2), 0
    assert_equal some_array.count(CS253Array.new([2, 3])), 1
    assert_equal some_array.count(CS253Array.new([2, 3, 3])), 0

    assert_equal some_triple.count(CS253Array.new([2,3,4])), 2
    assert_equal some_triple.count(CS253Array.new([2,3,4])) { |el| el < 3 }, 2

  end

  def test_count_block
    some_array = CS253Array.new(%w[hi jo not is why])
    some_triple = Triple.new(2,3,9)


    assert_equal @empty_array.cs253count { |el| el.nil? }, 0
    assert_equal some_array.cs253count { |el| el.length == 2 }, 3
    assert_equal some_triple.cs253count { |el| el.odd? }, 2

    # Correctness check
    assert_equal @empty_array.count { |el| el.nil? }, 0
    assert_equal some_array.count { |el| el.length == 2 }, 3
    assert_equal some_triple.count { |el| el.odd? }, 2

  end

  def test_all_default
    nil_triple = Triple.new

    assert(!nil_triple.cs253all?)
    # Correctness check

    assert(!nil_triple.all?)

  end

  def test_all_block
    some_array = CS253Array.new([1,2,3,4,5])
    some_triple = Triple.new(1,2,3)

    assert(@empty_array.cs253all? { |el| el < 7 })
    assert(!some_array.cs253all? { |el| el < 3 })
    assert(some_triple.cs253all? { |el| el < 7 })

    # Correctness check
    assert(@empty_array.all? { |el| el < 7 })
    assert(!some_array.all? { |el| el < 3 })
    assert(some_triple.all? { |el| el < 7 })

  end

  def test_any_default
    nil_triple = Triple.new

    assert !nil_triple.cs253any?
    # Correctness check

    assert(!nil_triple.any?)

  end

  def test_any
    some_array = CS253Array.new([2,4,1,8])
    some_triple = Triple.new(1,3,5)

    assert(!@empty_array.cs253any? { |el| el.even? })
    assert(some_array.cs253any? { |el| el.even? })
    assert(!some_triple.cs253any? { |el| el.even? })

    # Correctness check
    assert(!@empty_array.any? { |el| el.even? })
    assert(some_array.any? { |el| el.even? })
    assert(!some_triple.any? { |el| el.even? })
  end


  # TODO: Test nil return

  def test_cycle
    some_array = CS253Array.new([1,2,3,4])
    some_triple = Triple.new("I ","Love ","Code.\n")

    assert_nil(@empty_array.cs253cycle(4) { |el| el+1 })
    some_array_agg = CS253Array.new([])
    some_array.cs253cycle(3) do |el|
      some_array_agg << el
    end
    assert_equal some_array_agg, some_array * 3
    some_triple_built = ""
    some_triple.cs253cycle(5) do |el|
      some_triple_built += el
    end
    assert_equal some_triple_built, "I Love Code.\n" * 5





    # Correctness check
    assert_nil(@empty_array.cycle(4) { |el| el+1 })
    some_array_agg = CS253Array.new([])
    some_array.cycle(3) do |el|
      some_array_agg << el
    end
    assert_equal some_array_agg, some_array * 3
    some_triple_built = ""
    some_triple.cycle(5) do |el|
      some_triple_built += el
    end
    assert_equal some_triple_built, "I Love Code.\n" * 5
    #TODO can n be false and still work as if nil
  end

  def test_detect_default
    some_array = CS253Array.new([1,2,65,3])
    some_triple = Triple.new(2,1,4)


    assert_nil(@empty_array.cs253detect { |el| true })
    assert_equal some_array.cs253detect { |el| el.odd? && el > 20 }, 65
    assert_nil(some_triple.cs253detect { |el| el > 4 })

    assert_nil(@empty_array.cs253find { |el| true })
    assert_equal some_array.cs253find { |el| el.odd? && el > 20 }, 65
    assert_nil(some_triple.cs253find { |el| el > 4 })

    #Correctness check
    assert_nil(@empty_array.detect { |el| true })
    assert_equal some_array.detect { |el| el.odd? && el > 20 }, 65
    assert_nil(some_triple.detect { |el| el > 4 })

    assert_nil(@empty_array.find { |el| true })
    assert_equal some_array.find { |el| el.odd? && el > 20 }, 65
    assert_nil(some_triple.find { |el| el > 4 })
  end

  def test_detect_ifnone
    some_array = CS253Array.new([1,2,65,3])
    some_triple = Triple.new(2,1,4)
    some_callable = proc { 99 }

    assert_equal @empty_array.cs253detect(some_callable) { |el| true }, 99
    assert_equal some_array.cs253detect(some_callable) { |el| el.odd? && el > 20 }, 65
    assert_equal some_triple.cs253detect(some_callable) { |el| el > 4 }, 99

    # Correctness check
    assert_equal @empty_array.detect(some_callable) { |el| true }, 99
    assert_equal some_array.detect(some_callable) { |el| el.odd? && el > 20 }, 65
    assert_equal some_triple.detect(some_callable) { |el| el > 4 }, 99
  end

  def test_drop_while
    some_array = CS253Array.new([1, 3, 5, 6, 7, 8])
    some_triple = Triple.new(3,9,1)


    assert_equal @empty_array.cs253drop_while { |el| el }, []
    assert_equal some_array.cs253drop_while { |el| el.odd?  }, [6,7,8]
    assert_equal some_triple.cs253drop_while { |el| el.odd? }, []

    # Correctness check
    assert_equal @empty_array.drop_while { |el| el }, []
    assert_equal some_array.drop_while { |el| el.odd?  }, [6,7,8]
    assert_equal some_triple.drop_while { |el| el == 3 }, [9,1]

  end

  def test_drop
    # TODO add enumerable empty combos and extended stuff
    some_array = CS253Array.new([1, 3, 5, 6, 7, 8])
    some_triple = Triple.new(3,9,1)

    assert_equal @empty_array.cs253drop(6), []
    assert_equal some_array.cs253drop(0), [1, 3, 5, 6, 7, 8]
    assert_equal some_triple.cs253drop(2), [1]

    # Correctness check
    assert_equal @empty_array.drop(6), []
    assert_equal some_array.drop(0), [1, 3, 5, 6, 7, 8]
    assert_equal some_triple.drop(2), [1]
  end

  def test_chunk_while
    some_array = CS253Array.new([1,3,0.1,-45,-10,1,-423,5,6,7,8,9])
    some_triple = Triple.new(1,2,1)


    assert_equal @empty_array.cs253chunk_while { |elt_before, elt_after| true }, []
    assert_equal some_array.cs253chunk_while { |elt_before, elt_after|
      elt_before.positive? == elt_after.positive?
    }, [[1,3,0.1],
             [-45,-10],
             [1],
             [-423],
             [5,6,7,8,9]]
    assert_equal some_triple.cs253chunk_while { |elt_before, elt_after|
      elt_before.positive? == elt_after.positive?
    }, [[1,2,1]]


    # Correctness check
    assert_equal @empty_array.chunk_while { |elt_before, elt_after| true }.to_a, []
    assert_equal some_array.chunk_while { |elt_before, elt_after|
      elt_before.positive? == elt_after.positive?
    }.to_a, [[1,3,0.1],
          [-45,-10],
          [1],
          [-423],
          [5,6,7,8,9]]
    assert_equal some_triple.chunk_while { |elt_before, elt_after|
      elt_before.positive? == elt_after.positive?
    }.to_a, [[1,2,1]]

  end


  def test_chunk
    some_array = CS253Array.new([1,3,0.1,-45,-10,1,-423,5,6,7,8,9])
    some_triple = Triple.new(1,2,1)


    assert_equal @empty_array.cs253chunk { |elt| true }, []
    assert_equal(some_array.cs253chunk { |elt|  elt.positive?},
                 [[true, [1,3,0.1]],
                  [false, [-45,-10]],
                  [true,[1]],
                  [false,[-423]],
                  [true,[5,6,7,8,9]]])
    assert_equal some_triple.cs253chunk { |elt|  elt.positive?},
                 [[true, [1,2,1]]]



    # Correctness check
    assert_equal @empty_array.chunk { |elt| true }.to_a, []
    assert_equal(some_array.chunk { |elt|  elt.positive?}.to_a,
                 [[true, [1,3,0.1]],
             [false, [-45,-10]],
             [true,[1]],
             [false,[-423]],
             [true,[5,6,7,8,9]]])
    assert_equal some_triple.chunk { |elt|  elt.positive?}.to_a,
                 [[true, [1,2,1]]]

  end

  def test_each_cons
    some_array = CS253Array.new((2..11).to_a)
    some_triple = Triple.new(3,2,1)

    #TODO test empty and overreach


    assert_nil(@empty_array.cs253each_cons(2) {|el| el})
    some_array_agg = []
    some_array.cs253each_cons(4) { |a| some_array_agg << a }
    assert_equal some_array_agg, [
        [2,3,4,5],
        [3,4,5,6],
        [4,5,6,7],
        [5,6,7,8],
        [6,7,8,9],
        [7,8,9,10],
        [8,9,10,11]
    ]
    some_triple_agg = []
    some_triple.cs253each_cons(3) { |a| some_triple_agg << a }
    assert_equal some_triple_agg, [[3,2,1]]


    # Correctness check
    assert_nil(@empty_array.each_cons(2) {|el| el})
    some_array_agg = []
    some_array.each_cons(4) { |a| some_array_agg << a }
    assert_equal some_array_agg, [
        [2,3,4,5],
        [3,4,5,6],
        [4,5,6,7],
        [5,6,7,8],
        [6,7,8,9],
        [7,8,9,10],
        [8,9,10,11]
    ]
    some_triple_agg = []
    some_triple.each_cons(3) { |a| some_triple_agg << a }
    assert_equal some_triple_agg, [[3,2,1]]

  end

  def test_each_entry
    #TODO test empty be careful its weird

    some_array = CS253Array.new((1..10).to_a)
    some_triple = Triple.new([nil],[],)
    # some_quick_triple = TripleAlt.new(5,6,)


    some_array_agg = []
    some_array.cs253each_entry { |el| some_array_agg << el}
    assert_equal some_array_agg, CS253Array.new((1..10).to_a)

    some_triple_agg = []
    some_triple.cs253each_entry { |el| some_triple_agg << el}
    assert_equal some_triple_agg, [[nil], [], nil]


    some_triple_agg = []
    some_triple.cs253each_entry { |el| some_triple_agg << el}
    assert_equal some_triple_agg, [[nil], [], nil]

    # some_quick_triple_agg = []
    # some_quick_triple.cs253each_entry { |el| some_quick_triple_agg << el}
    # assert_equal [[5,6], nil], some_quick_triple_agg


    # Correctness check
    some_array_agg = []
    some_array.each_entry { |el| some_array_agg << el}
    assert_equal some_array_agg, CS253Array.new((1..10).to_a)

    some_triple_agg = []
    some_triple.each_entry { |el| some_triple_agg << el}
    assert_equal some_triple_agg, [[nil], [], nil]


    some_triple_agg = []
    some_triple.each_entry { |el| some_triple_agg << el}
    assert_equal some_triple_agg, [[nil], [], nil]

    # some_quick_triple_agg = []
    # some_quick_triple.each_entry { |el| some_quick_triple_agg << el}
    # assert_equal some_quick_triple_agg, [[5,6], nil]


  end


  def test_zip_no_block

    some_array = CS253Array.new((7..9).to_a)
    some_triple = Triple.new(1,5,3)

    assert_equal([], @empty_array.cs253zip([]))
    assert_equal [[7,1,11,20],[8,2,12,21],[9,3,13,nil]], some_array.cs253zip([1,2,3,4,5,6],[11,12,13,14],[20,21])
    assert_equal [[1,9],[5,8],[3,7]], some_triple.cs253zip([9,8,7])

    # Correctness check
    assert_equal([], @empty_array.zip([]))
    assert_equal [[7,1,11,20],[8,2,12,21],[9,3,13,nil]], some_array.zip([1,2,3,4,5,6],[11,12,13,14],[20,21])
    assert_equal [[1,9],[5,8],[3,7]], some_triple.zip([9,8,7])

  end

  def test_zip_with_block
    some_array = CS253Array.new((7..9).to_a)
    some_triple = Triple.new(1,5,3)

    assert_nil( @empty_array.cs253zip([]) {|el| el})
    assert_nil(some_array.cs253zip([1,2,3,4,5,6],[11,12,13,14],[20,21]) {|el| el})
    assert_nil(some_triple.cs253zip([9,8,7]) {|el| el})

    # Correctness check
    assert_nil( @empty_array.zip([]) {|el| el})
    assert_nil(some_array.zip([1,2,3,4,5,6],[11,12,13,14],[20,21]) {|el| el})
    assert_nil(some_triple.zip([9,8,7]) {|el| el})
  end




  def test_each_slice

    some_array = CS253Array.new((0..10).to_a)
    some_triple = Triple.new(3,2,1)

    assert_nil @empty_array.cs253each_slice(3) {|el| el}
    some_array_agg = []
    some_array.cs253each_slice(3) { |el| some_array_agg << el }
    assert_equal [[0,1,2],[3,4,5],[6,7,8],[9,10]], some_array_agg

    some_triple_agg = []
    some_triple.cs253each_slice(2) { |el| some_triple_agg << el }
    assert_equal [[3,2],[1]], some_triple_agg

    # Correctness check
    assert_nil @empty_array.each_slice(3) {|el| el}
    some_array_agg = []
    some_array.each_slice(3) { |el| some_array_agg << el }
    assert_equal [[0,1,2],[3,4,5],[6,7,8],[9,10]], some_array_agg

    some_triple_agg = []
    some_triple.each_slice(2) { |el| some_triple_agg << el }
    assert_equal [[3,2],[1]], some_triple_agg
  end

  def test_each_with_object
    # TODO Spread/splat for block first args
    some_array = CS253Array.new((0..10).to_a)
    some_triple = Triple.new(3,1,99)
    some_hash = DumbHash.new
    some_hash[:one] = 1
    some_hash[:two] = 2
    some_hash[:three] = 3

    assert_equal [0,2,4,6,8,10], some_array.cs253each_with_object([]) { |el, memo_obj| memo_obj << el if el.even? }
    assert_equal [], some_triple.cs253each_with_object([]) { |el, memo_obj| memo_obj << el if el.even? }
    assert_equal([[:one, 1], [:two, 2], [:three, 3]], some_hash.cs253each_with_object([])  { |(key, val), memo_obj|  memo_obj << [key, val] })


    # Correctness check
    assert_equal [0,2,4,6,8,10], some_array.each_with_object([]) { |el, memo_obj| memo_obj << el if el.even? }
    assert_equal [], some_triple.each_with_object([]) { |el, memo_obj| memo_obj << el if el.even? }
    assert_equal [[:one, 1], [:two, 2], [:three, 3]], some_hash.each_with_object([]) { |(key, val), memo_obj| memo_obj << [key, val]}


  end

  def test_find_index_value
    some_array = CS253Array.new((0..10).to_a)
    some_array_nil = CS253Array.new([0,3,nil,5,7])
    some_triple = Triple.new(0,4,3)

    assert_equal 3, some_array.cs253find_index(3)
    assert_equal 3, some_array.cs253find_index(3) { |obj| obj.zero? }
    assert_equal 2, some_array_nil.cs253find_index(nil)
    assert_nil some_triple.cs253find_index(1)

    # Correctness check

    assert_equal 3, some_array.find_index(3)
    assert_equal 3, some_array.find_index(3) { |obj| obj.zero? }
    assert_equal 2, some_array_nil.find_index(nil)
    assert_nil some_triple.find_index(1)
  end

  def test_find_index_block
    some_array = CS253Array.new((0..10).to_a)
    some_array_nil = CS253Array.new([0,3,nil,5,7])
    some_triple = Triple.new(0,4,3)


    assert_equal 5, (some_array.cs253find_index { |val| val > 4} )
    assert_equal 1, (some_array.cs253find_index { |val| val.odd? } )
    assert_equal 2, (some_array_nil.cs253find_index { |val| val.nil? })
    assert_nil(some_triple.cs253find_index { |val| val.negative? })

    # Correctness check

    assert_equal 5, (some_array.find_index { |val| val > 4} )
    assert_equal 1, (some_array.find_index { |val| val.odd? } )
    assert_equal 2, (some_array_nil.find_index { |val| val.nil? })
    assert_nil(some_triple.find_index { |val| val.negative? })

    # assert_equal 3, some_array.find_index(3) { |obj| obj.zero? }
    # assert_equal 2, some_array_nil.find_index(nil)
    # assert_nil some_triple.find_index(1)
  end



  def test_grep_noblock
    int_array = CS253Array.new((-1000..1000).to_a)
    string_array = CS253Array.new(["billy", "bob", "joe", "ham", "bip"])


    assert_equal [], @empty_array.cs253grep(1..3)
    assert_equal (1..1000).to_a , int_array.cs253grep(1..10000)
    assert_equal [] , int_array.cs253grep(-1111..-1110)
    assert_equal ["billy", "bob", "bip"], string_array.cs253grep(/\Ab.*\z/)

    # Correctness check
    assert_equal [], @empty_array.grep(1..3)
    assert_equal (1..1000).to_a , int_array.grep(1..10000)
    assert_equal [] , int_array.grep(-1111..-1110)
    assert_equal ["billy", "bob", "bip"], string_array.grep(/\Ab.*\z/)

  end

  def test_grep_block
    int_array = CS253Array.new((-1000..1000).to_a)
    string_array = CS253Array.new(["billy", "bob", "joe", "ham", "bip"])


    assert_equal [], @empty_array.cs253grep(1..3) { |x| x.nil? }
    assert_equal (0..999).to_a , int_array.cs253grep(1..10000) { |x| x - 1 }
    assert_equal [] , int_array.cs253grep(-1111..-1110) { |x| x.nil? }
    assert_equal ["BILLY", "BOB", "BIP"], string_array.cs253grep(/\Ab.*\z/) { |x| x.upcase }

    # Correctness check
    assert_equal [], @empty_array.grep(1..3) { |x| x.nil? }
    assert_equal (0..999).to_a , int_array.grep(1..10000) { |x| x - 1 }
    assert_equal [] , int_array.grep(-1111..-1110) { |x| x.nil? }
    assert_equal ["BILLY", "BOB", "BIP"], string_array.grep(/\Ab.*\z/) { |x| x.upcase }
  end



  def test_grep_v_noblock
    int_array = CS253Array.new((-1000..1000).to_a)
    string_array = CS253Array.new(["billy", "bob", "joe", "ham", "bip"])


    assert_equal [], @empty_array.cs253grep_v(1..3)
    assert_equal (-1000..0).to_a, int_array.cs253grep_v(1..10000)
    assert_equal int_array.to_a, int_array.cs253grep_v(-1111..-1110)
    assert_equal ["joe", "ham"], string_array.cs253grep_v(/\Ab.*\z/)

    # Correctness check
    assert_equal [], @empty_array.grep_v(1..3)
    assert_equal (-1000..0).to_a, int_array.grep_v(1..10000)
    assert_equal int_array.to_a, int_array.grep_v(-1111..-1110)
    assert_equal ["joe", "ham"], string_array.grep_v(/\Ab.*\z/)

  end

  def test_grep_v_block
    int_array = CS253Array.new((-1000..1000).to_a)
    string_array = CS253Array.new(["billy", "bob", "joe", "ham", "bip"])

    assert_equal [], @empty_array.cs253grep_v(1..3) { |x| x.nil? }
    assert_equal (-1001..-1).to_a , int_array.cs253grep_v(1..10000) { |x| x - 1 }
    assert_equal Array.new(int_array.count, false) , int_array.cs253grep_v(-1111..-1110) { |x| x.nil? }
    assert_equal ["JOE", "HAM"], string_array.cs253grep_v(/\Ab.*\z/) { |x| x.upcase }

    # Correctness check
    assert_equal [], @empty_array.grep_v(1..3) { |x| x.nil? }
    assert_equal (-1001..-1).to_a , int_array.grep_v(1..10000) { |x| x - 1 }
    assert_equal Array.new(int_array.count, false) , int_array.grep_v(-1111..-1110) { |x| x.nil? }
    assert_equal ["JOE", "HAM"], string_array.grep_v(/\Ab.*\z/) { |x| x.upcase }
  end

  def test_group_by
    int_array = CS253Array.new((1..10).to_a)
    string_array = CS253Array.new(%w[a is i fart help be she lid are pool])

    assert_equal({}, @empty_array.cs253group_by { |el| el.zero?})
    assert_equal({true => [2,4,6,8,10], false => [1,3,5,7,9]}, int_array.cs253group_by {|el| el.even?})
    assert_equal({1 => %w[a i],2 => %w[is be], 3 => %w[she lid are], 4 => %w[fart help pool]}, string_array.cs253group_by {|el| el.length})


    # Correctness check
    assert_equal({}, @empty_array.group_by { |el| el.zero?})
    assert_equal({true => [2,4,6,8,10], false => [1,3,5,7,9]}, int_array.group_by {|el| el.even?})
    assert_equal({1 => %w[a i],2 => %w[is be], 3 => %w[she lid are], 4 => %w[fart help pool]}, string_array.group_by {|el| el.length})
  end

  def test_include
    int_array = CS253Array.new((1..10).to_a)
    string_array = CS253Array.new(%w[joe JOE is HAPPY])


    assert !@empty_array.cs253include?(1)
    assert int_array.cs253include?(3)
    assert !string_array.cs253include?("IS")

    assert !@empty_array.cs253member?(1)
    assert int_array.cs253member?(3)
    assert !string_array.cs253member?("IS")

    # Correctness check
    assert !@empty_array.include?(1)
    assert int_array.include?(3)
    assert !string_array.include?("IS")

    assert !@empty_array.member?(1)
    assert int_array.member?(3)
    assert !string_array.member?("IS")

  end

  def test_none
    some_array = CS253Array.new([2,4,1,8])
    some_triple = Triple.new(1,3,5)


    assert(@empty_array.cs253none? { |el| el.even? })
    assert(!some_array.cs253none? { |el| el.even? })
    assert(some_triple.cs253none? { |el| el.even? })

    # Correctness check
    assert(@empty_array.none? { |el| el.even? })
    assert(!some_array.none? { |el| el.even? })
    assert(some_triple.none? { |el| el.even? })
  end

  def test_one
    some_array = CS253Array.new([2,4,6,1,8,10])
    some_triple = Triple.new(4,3,2)

    assert(!@empty_array.cs253one? { |el| el.even? })
    assert(some_array.cs253one? { |el| el.odd? })
    assert !some_triple.cs253one? { |el| el < 1 }
    assert !some_triple.cs253one? { |el| el < 4 }

    # Correctness check
    assert(!@empty_array.one? { |el| el.even? })
    assert(some_array.one? { |el| el.odd? })
    assert !some_triple.one? { |el| el < 1 }
    assert !some_triple.one? { |el| el < 4 }

  end

  def test_partition
    some_array = CS253Array.new((1..10).to_a)
    some_triple = Triple.new([],[334],[])

    assert_equal([[],[]], @empty_array.cs253partition {|el| el.even? })
    assert_equal([[2,4,6,8,10],[1,3,5,7,9]], some_array.cs253partition {|el| el.even? })
    assert_equal( [[[],[]],[[334]]], some_triple.cs253partition { |el| el.empty? })

    # Correctness check
    assert_equal([[],[]], @empty_array.partition {|el| el.even? })
    assert_equal([[2,4,6,8,10],[1,3,5,7,9]], some_array.partition {|el| el.even? })
    assert_equal( [[[],[]],[[334]]], some_triple.partition { |el| el.empty? })

  end

  def test_reject
    int_array = CS253Array.new([0, 1, 2, 3, 4])
    bool_tripler = Triple.new(true, false, true)

    assert_equal( [], @empty_array.cs253reject { |x| x.even? })
    assert_equal( [1,3], int_array.cs253reject { |x| x.even? })
    assert_equal( [false], bool_tripler.cs253reject { |x| x })

    # Correctness check
    assert_equal( [], @empty_array.reject { |x| x.even? })
    assert_equal( [1,3], int_array.reject { |x| x.even? })
    assert_equal( [false], bool_tripler.reject { |x| x })
  end

  def test_reverse_each
    #TODO: empty array case
    int_array = CS253Array.new((1..10).to_a)
    string_array = CS253Array.new(%w[R A C E C A R])

    assert_equal(@empty_array, @empty_array.cs253reverse_each {|el| el})
    int_agg = []
    int_array.cs253reverse_each { |el| int_agg << el+1 }
    assert_equal [11,10,9,8,7,6,5,4,3,2].to_a, int_agg

    string_agg = []
    string_array.cs253reverse_each { |el| string_agg << el}
    assert_equal %w[R A C E C A R], string_agg

    # Correctness check

    assert_equal(@empty_array, @empty_array.reverse_each {|el| el})

    int_agg = []
    int_array.reverse_each { |el| int_agg << el+1 }
    assert_equal [11,10,9,8,7,6,5,4,3,2].to_a, int_agg

    string_agg = []
    string_array.reverse_each { |el| string_agg << el}
    assert_equal %w[R A C E C A R], string_agg

  end


  def test_sort
    int_array = CS253Array.new([-22,3,4,8,6,10,-11,2,7,9])
    string_array = CS253Array.new(%w[i betterer love pie soooo])


    assert_equal( [], @empty_array.cs253sort { |a,b| a <=> b })
    assert_equal([-22,-11,2,3,4,6,7,8,9,10], int_array.cs253sort { |a,b| a <=> b })
    assert_equal(%w[i pie love soooo betterer], string_array.cs253sort { |a,b| a.length <=> b.length })

    # Correctness check
    assert_equal( [], @empty_array.sort { |a,b| a <=> b })
    assert_equal([-22,-11,2,3,4,6,7,8,9,10], int_array.sort { |a,b| a <=> b })
    assert_equal(%w[i pie love soooo betterer], string_array.sort { |a,b| a.length <=> b.length })
  end

 #TODO check sort/sort by blocks

  def test_sort_by
    int_array = CS253Array.new([-22,3,4,8,6,10,-11,2,7,9])
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_equal( [], @empty_array.cs253sort_by { |a| a})
    assert_equal([-22,-11,2,3,4,6,7,8,9,10], int_array.cs253sort_by { |a| a })
    assert_equal(%w[i pie love soooo betterer], string_array.cs253sort_by { |a| a.length } )


    # Correctness check
    assert_equal( [], @empty_array.sort_by { |a| a})
    assert_equal([-22,-11,2,3,4,6,7,8,9,10], int_array.sort_by { |a| a })
    assert_equal(%w[i pie love soooo betterer], string_array.sort_by { |a| a.length } )
  end

  def test_max_single
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_nil(@empty_array.cs253max {|a,b| a <=> b})
    assert_equal(10, int_array.cs253max {|a,b| a <=> b})
    assert_equal('betterer', string_array.cs253max { |a,b| a.length <=> b.length })

    # Correctness check
    assert_nil(@empty_array.max {|a,b| a <=> b})
    assert_equal(10, int_array.max {|a,b| a <=> b})
    assert_equal('betterer', string_array.max { |a,b| a.length <=> b.length })

  end

  def test_max_default
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_nil(@empty_array.cs253max)
    assert_equal(10, int_array.cs253max)
    assert_equal('soooo', string_array.cs253max)

    # Correctness check
    assert_nil(@empty_array.max)
    assert_equal(10, int_array.max)
    assert_equal('soooo', string_array.max)

  end

  def test_max_num
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_equal([], @empty_array.cs253max(2) {|a,b| a <=> b})
    assert_equal([10,9,8], int_array.cs253max(3) {|a,b| a <=> b})
    assert_equal(['betterer', 'soooo', 'love', 'pie'], string_array.cs253max(4) { |a,b| a.length <=> b.length })


    # Correctness check
    assert_equal([], @empty_array.max(2) {|a,b| a <=> b})
    assert_equal([10,9,8], int_array.max(3) {|a,b| a <=> b})
    assert_equal(['betterer', 'soooo', 'love', 'pie'], string_array.max(4) { |a,b| a.length <=> b.length })
  end

  def text_max_by_single
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_nil(@empty_array.cs253max_by {|a| a})
    assert_equal(10, int_array.cs253max_by { |a| a })
    assert_equal('betterer', string_array.cs253max_by { |a| a.length  })
    # Correctness check
    assert_nil(@empty_array.max_by {|a| a})
    assert_equal(10, int_array.max_by { |a| a })
    assert_equal('betterer', string_array.max_by { |a| a.length  })
  end



  def test_max_by_num
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_equal([], @empty_array.cs253max_by(2) {|a| a})
    assert_equal([10,9,8], int_array.cs253max_by(3) { |a| a })
    assert_equal(['betterer', 'soooo', 'love', 'pie'], string_array.cs253max_by(4) { |a| a.length  })

    # Correctness check
    assert_equal([], @empty_array.max_by(2) {|a| a})
    assert_equal([10,9,8], int_array.max_by(3) { |a| a })
    assert_equal(['betterer', 'soooo', 'love', 'pie'], string_array.max_by(4) { |a| a.length  })
  end

  
  
  def test_min_single
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_nil(@empty_array.cs253min {|a,b| a <=> b})
    assert_equal(0, int_array.cs253min {|a,b| a <=> b})
    assert_equal('i', string_array.cs253min { |a,b| a.length <=> b.length })
   

    # Correctness check
    assert_nil(@empty_array.min {|a,b| a <=> b})
    assert_equal(0, int_array.min {|a,b| a <=> b})
    assert_equal('i', string_array.min { |a,b| a.length <=> b.length })

  end


  def test_min_default
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_nil(@empty_array.cs253min)
    assert_equal(0, int_array.cs253min)
    assert_equal('betterer', string_array.cs253min)


    # Correctness check
    assert_nil(@empty_array.min)
    assert_equal(0, int_array.min)
    assert_equal('betterer', string_array.min)

  end

  def test_min_num
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_equal([], @empty_array.cs253min(2) {|a,b| a <=> b})
    assert_equal([0,1,2], int_array.cs253min(3) {|a,b| a <=> b})
    assert_equal(%w[i pie love soooo], string_array.cs253min(4) { |a,b| a.length <=> b.length })


    # Correctness check
    assert_equal([], @empty_array.min(2) {|a,b| a <=> b})
    assert_equal([0,1,2], int_array.min(3) {|a,b| a <=> b})
    assert_equal(%w[i pie love soooo], string_array.min(4) { |a,b| a.length <=> b.length })
  end


  def test_min_by_single
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_nil(@empty_array.cs253min_by {|a| a})
    assert_equal(0, int_array.cs253min_by {|a| a })
    assert_equal('i', string_array.cs253min_by { |a| a.length })

    # Correctness check
    assert_nil(@empty_array.min_by {|a| a})
    assert_equal(0, int_array.min_by {|a| a })
    assert_equal('i', string_array.min_by { |a| a.length })

  end

  def test_min_by_num
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_equal([], @empty_array.cs253min_by(2) {|a| a})
    assert_equal([0,1,2], int_array.cs253min_by(3) {|a| a })
    assert_equal(%w[i pie love soooo], string_array.cs253min_by(4) { |a| a.length })

    # Correctness check
    assert_equal([], @empty_array.min_by(2) {|a| a})
    assert_equal([0,1,2], int_array.min_by(3) {|a| a })
    assert_equal(%w[i pie love soooo], string_array.min_by(4) { |a| a.length })
  end

  def test_minmax_default
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])

    assert_equal [nil,nil], @empty_array.cs253minmax
    assert_equal [0,10], int_array.cs253minmax
    assert_equal ["betterer", "soooo"], string_array.cs253minmax

    # Correctness check
    assert_equal [nil,nil], @empty_array.minmax
    assert_equal [0,10], int_array.minmax
    assert_equal ["betterer", "soooo"], string_array.minmax
  end

  def test_minmax_block
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])
    # TODO: minimax more substantial block work

    assert_equal([nil,nil], @empty_array.cs253minmax{|a,b| a <=> b})
    assert_equal([10,0], int_array.cs253minmax {|a,b| -a <=> -b})
    assert_equal(["i", "betterer"], string_array.cs253minmax{ |a, b| a.length <=> b.length } )

    # Correctness check
    assert_equal([nil,nil], @empty_array.minmax{|a,b| a <=> b})
    assert_equal([10,0], int_array.minmax {|a,b| -a <=> -b})
    assert_equal(["i", "betterer"], string_array.minmax { |a, b| a.length <=> b.length } )
  end

  def test_minmax_by
    int_array = CS253Array.new((0..10).to_a)
    string_array = CS253Array.new(%w[i betterer love pie soooo])


    assert_equal([nil,nil], @empty_array.cs253minmax_by {|a| a})
    assert_equal([0,10], int_array.cs253minmax_by {|a| a })
    assert_equal(['i','betterer'], string_array.cs253minmax_by { |a| a.length })

    # Correctness check
    assert_equal([nil,nil], @empty_array.minmax_by {|a| a})
    assert_equal([0,10], int_array.minmax_by {|a| a })
    assert_equal(['i','betterer'], string_array.minmax_by { |a| a.length })
  end

  def test_slice_after_block
    int_array = CS253Array.new((0..10).to_a)
    some_triple = Triple.new("yay", "shoe")

    assert_equal([], @empty_array.cs253slice_after { |el| el.nil? })
    assert_equal([[0,1],[2,3],[4,5],[6,7],[8,9],[10]], int_array.cs253slice_after { |el| el.odd? })
    assert_equal([["yay", "shoe", nil]], some_triple.cs253slice_after { |el| el.nil? })


    # Correctness check
    assert_equal([], @empty_array.slice_after { |el| el.nil? }.to_a)
    assert_equal([[0,1],[2,3],[4,5],[6,7],[8,9],[10]], int_array.slice_after { |el| el.odd? }.to_a)
    assert_equal([["yay", "shoe", nil]], some_triple.slice_after { |el| el.nil? }.to_a)
  end

  def test_slice_after_pattern
    int_array = CS253Array.new((0..10).to_a)
    some_triple = Triple.new("Hello", "g00dbye", "shalom")

    assert_equal([], @empty_array.cs253slice_after((0..10)).to_a)
    assert_equal([[0],[1],[2],[3,4,5,6,7,8,9,10]], int_array.cs253slice_after((0..2)).to_a)
    assert_equal([%w[Hello g00dbye], ["shalom"]], some_triple.cs253slice_after(/.*\d.*/).to_a)

    # Correctness check
    assert_equal([], @empty_array.slice_after((0..10)).to_a)
    assert_equal([[0],[1],[2],[3,4,5,6,7,8,9,10]], int_array.slice_after((0..2)).to_a)
    assert_equal([%w[Hello g00dbye], ["shalom"]], some_triple.slice_after(/.*\d.*/).to_a)
  end

  def test_slice_before_block
    int_array = CS253Array.new((0..10).to_a)
    some_triple = Triple.new("yay", "shoe")

    assert_equal([], @empty_array.cs253slice_before { |el| el.nil? })
    assert_equal([[0,1],[2,3],[4,5],[6,7],[8,9],[10]], int_array.cs253slice_before { |el| el.even? })
    assert_equal([["yay", "shoe"], [nil]], some_triple.cs253slice_before { |el| el.nil? })


    # Correctness check
    assert_equal([], @empty_array.slice_before { |el| el.nil? }.to_a)
    assert_equal([[0,1],[2,3],[4,5],[6,7],[8,9],[10]], int_array.slice_before { |el| el.even? }.to_a)
    assert_equal([["yay", "shoe"], [nil]], some_triple.slice_before { |el| el.nil? }.to_a)
  end

  def test_slice_before_pattern
    int_array = CS253Array.new((0..10).to_a)
    some_triple = Triple.new("Hello", "g00dbye", "shalom")

    assert_equal([], @empty_array.cs253slice_before((0..10)))
    assert_equal([[0],[1],[2],[3,4,5,6,7,8,9,10]], int_array.cs253slice_before((0..3)))
    assert_equal([%w[Hello],  ["g00dbye", "shalom"]], some_triple.cs253slice_before(/.*\d.*/))

    # Correctness check
    assert_equal([], @empty_array.slice_before((0..10)).to_a)
    assert_equal([[0],[1],[2],[3,4,5,6,7,8,9,10]], int_array.slice_before((0..3)).to_a)
    assert_equal([%w[Hello],  ["g00dbye", "shalom"]], some_triple.slice_before(/.*\d.*/).to_a)

  end

  def test_slice_when
    some_array = CS253Array.new([1,3,0.1,-45,-10,1,-423,5,6,7,8,9])
    some_triple = Triple.new(1,2,1)


    assert_equal @empty_array.cs253slice_when { |elt_before, elt_after| true }, []
    assert_equal some_array.cs253slice_when { |elt_before, elt_after|
      elt_before.positive? != elt_after.positive?
    }, [[1,3,0.1],
        [-45,-10],
        [1],
        [-423],
        [5,6,7,8,9]]
    assert_equal some_triple.cs253slice_when { |elt_before, elt_after|
      elt_before.positive? != elt_after.positive?
    }, [[1,2,1]]


    # Correctness check
    assert_equal @empty_array.slice_when { |elt_before, elt_after| true }.to_a, []
    assert_equal some_array.slice_when { |elt_before, elt_after|
      elt_before.positive? != elt_after.positive?
    }.to_a, [[1,3,0.1],
             [-45,-10],
             [1],
             [-423],
             [5,6,7,8,9]]
    assert_equal some_triple.slice_when { |elt_before, elt_after|
      elt_before.positive? != elt_after.positive?
    }.to_a, [[1,2,1]]
  end

  def test_uniq_default
    some_array = CS253Array.new([1,2,3,1,2,3,"hi","bi","hi","bi"])
    some_triple = Triple.new

    assert_equal [], @empty_array.cs253uniq
    assert_equal [1, 2, 3, "hi", "bi"], some_array.cs253uniq
    assert_equal [nil], some_triple.cs253uniq

    # Correctness check
    assert_equal [], @empty_array.uniq
    assert_equal [1, 2, 3, "hi", "bi"], some_array.uniq
    assert_equal [nil], some_triple.uniq
  end

  def test_uniq_block
    some_array = CS253Array.new([1,2,3,1,2,3,"hi","bi","hi","bi"])
    some_triple = Triple.new("derp", )

    assert_equal([], @empty_array.cs253uniq {|el| el.nil?})
    assert_equal([1, "hi"], some_array.cs253uniq {|el| el.class.name})
    assert_equal(["derp", nil], some_triple.cs253uniq {|el| el.nil?})

    # Correctness check
    assert_equal([], @empty_array.uniq {|el| el.nil?})
    assert_equal([1, "hi"], some_array.uniq {|el| el.class.name})
    assert_equal(["derp", nil], some_triple.uniq {|el| el.nil?})
  end

  def test_to_h
    some_pairs_array = CS253Array.new([[:one, 1],[:two,2],[:three,3],[:four,4]])
    some_triple = Triple.new([:class, "253"], [:depart, "CS"], [:hw, "2"])

    assert_equal({}, @empty_array.cs253to_h)
    assert_equal({one: 1, two: 2, three: 3, four: 4}, some_pairs_array.cs253to_h)
    assert_equal({class: "253", depart: "CS", hw: "2"}, some_triple.cs253to_h)

    # Correctness check
    assert_equal({}, @empty_array.to_h)
    assert_equal({one: 1, two: 2, three: 3, four: 4}, some_pairs_array.to_h)
    assert_equal({class: "253", depart: "CS", hw: "2"}, some_triple.to_h)
  end


end



