def m0(i)
    a = *source(0)
    sink(a[0]) # $ hasValueFlow=0
    sink(a[1])
    sink(a[i]) # $ hasValueFlow=0
end

def m1(i)
    a = [0, source(1), 2]
    sink(a[0])
    sink(a[1]) # $ hasValueFlow=1
    sink(a[2])
    sink(a[i]) # $ hasValueFlow=1
end

def m2(i)
    a = Array.new(1, source(2.1))
    sink(a[0]) # $ hasValueFlow=2.1
    sink(a[i]) # $ hasValueFlow=2.1

    b = Array.new(a)
    sink(b[0]) # $ hasValueFlow=2.1
    sink(b[i]) # $ hasValueFlow=2.1

    c = Array.new(1) do |x|
        source(2.2)
    end
    sink(c[0]) # $ hasValueFlow=2.2
    sink(c[i]) # $ hasValueFlow=2.2
end

def m3
    a = [source(3), 1]
    b = Array.try_convert(a)
    sink(b[0]) # $ hasValueFlow=3
    sink(b[1])
end

def m4
    a = [source(4.1), 1]
    b = [2, 3, source(4.2)]
    c = a & b
    sink(c[0]) # $ hasValueFlow=4.1 $ hasValueFlow=4.2
    sink(c[1]) # $ hasValueFlow=4.1 $ hasValueFlow=4.2
end

def m5
    a = [source(5), 1]
    b = a * 3
    sink(b[0]) # $ hasValueFlow=5
    sink(b[1]) # $ hasValueFlow=5
end

def m6
    a = [source(6.1), 1]
    b = [2, source(6.2)]
    c = a + b
    sink(c[0]) # $ hasValueFlow=6.1 $ hasValueFlow=6.2
    sink(c[1]) # $ hasValueFlow=6.2
end

def m7
    a = [source(7.1), 1]
    b = [2, source(7.2)]
    c = a - b
    sink(c[0]) # $ hasValueFlow=7.1
    sink(c[1]) # $ hasValueFlow=7.1
end

def m8
    a = [source(8.1), 1]
    b = a << source(8.2)
    sink(b[0]) # $ hasValueFlow=8.1 $ hasValueFlow=8.2
    sink(b[1]) # $ hasValueFlow=8.2
end

def m9(i)
    a = [0, source(9), 2]
    b, c, d = a
    sink(b)
    sink(c) # $ hasValueFlow=9
    sink(d)
end

def m10(i)
    a = [0, source(10), 2]
    b = a[0, 2]
    sink(b[0]) # $ hasValueFlow=10
    sink(b[1]) # $ hasValueFlow=10
    sink(b[i]) # $ hasValueFlow=10
end

def m11(i)
    a = [0, source(11), 2]
    b = a[0..2]
    sink(b[0]) # $ hasValueFlow=11
    sink(b[1]) # $ hasValueFlow=11
    sink(b[i]) # $ hasValueFlow=11
end

def m12(i)
    a = [0, 1]
    a[0, 1] = source(12)
    sink(a[0]) # $ hasValueFlow=12
    sink(a[1]) # $ hasValueFlow=12
    sink(a[i]) # $ hasValueFlow=12
end

def m13(i)
    a = [0, 1]
    a[0, 1] = [0, source(13), 2]
    sink(a[0]) # $ hasValueFlow=13
    sink(a[1]) # $ hasValueFlow=13
    sink(a[i]) # $ hasValueFlow=13
end

def m14(i)
    a = [0, 1]
    a[0..1] = source(14)
    sink(a[0]) # $ hasValueFlow=14
    sink(a[1]) # $ hasValueFlow=14
    sink(a[i]) # $ hasValueFlow=14
end

def m15(i)
    a = [0, 1]
    a[0..1] = [0, source(15), 2]
    sink(a[0]) # $ hasValueFlow=15
    sink(a[1]) # $ hasValueFlow=15
    sink(a[i]) # $ hasValueFlow=15
end

def m16
    a = [0, 1, source(16)]
    a.all? do |x|
        sink x # $ hasValueFlow=16
    end
end

def m17
    a = [0, 1, source(17)]
    a.any? do |x|
        sink x # $ hasValueFlow=17
    end
end

def m18
    a = ["a", 0]
    b = ["b", 1]
    c = ["c", source(18)]
    d = [a, b, c]
    sink (d.assoc("a")[0]) # $ hasValueFlow=18
    sink (d.assoc("c")[0]) # $ hasValueFlow=18
end

def m19(i)
    a = [0, source(19), 2]
    sink(a.at(0))
    sink(a.at(1)) # $ hasValueFlow=19
    sink(a.at(2))
    sink(a.at(i)) # $ hasValueFlow=19
end

def m20
    a = [0, 1, source(20)]
    b = a.bsearch do |x|
        sink x # $ hasValueFlow=20
    end
    sink b # $ hasValueFlow=20
end

def m21
    a = [0, 1, source(21)]
    b = a.bsearch_index do |x|
        sink x # $ hasValueFlow=21
    end
    sink b
end

def m22
    a = [0, 1, source(22.1)]
    b = a.chunk do |x|
        sink x # $ hasValueFlow=22.1
        source 22.2
    end
    sink(b[0]) # $ hasValueFlow=22.1 $ hasValueFlow=22.2
end

def m23
    a = [0, 1, source(23.1), source(23.2)]
    b = a.chunk_while do |x, y|
        sink x # $ hasValueFlow=23.1 $ hasValueFlow=23.2
        sink y # $ hasValueFlow=23.1 $ hasValueFlow=23.2
        x > y
    end
    sink(b)
end

def m24
    a = [0, 1, source(24)]
    a.clear()
    sink(a[2])
end

def m25
    a = [0, 1, source(25)]
    b = a.collect do |x|
        sink x # $ hasValueFlow=25
        x
    end
    sink(b[0]) # $ hasValueFlow=25
end

def m26
    a = [0, 1, source(26)]
    b = a.collect_concat do |x|
        sink x # $ hasValueFlow=26
        [x, x]
    end
    sink(b[0]) # $ hasValueFlow=26
end

def m27
    a = [0, 1, source(27)]
    a.combination(1) do |x|
        sink(x[0]) # $ hasValueFlow=27
    end
end

def m28
    a = [0, 1, source(28)]
    b = a.compact
    sink(b[0]) # $ hasValueFlow=28
end

def m29
    a = [0, 1, source(29.1)]
    b = [0, 1, source(29.2)]
    a.concat(b)
    sink(a[0]) # $ hasValueFlow=29.2
    sink(a[2]) # $ hasValueFlow=29.1 $ hasValueFlow=29.2
end

def m30
    a = [0, 1, source(30)]
    a.count do |x|
        sink x # $ hasValueFlow=30
    end
end

def m31
    a = [0, 1, source(31)]
    a.cycle(2) do |x|
        sink x # $ hasValueFlow=31
    end
end

def m32
    a = [0, 1, source(32.1)]
    b = a.delete(2) { source(32.2) }
    sink b # $ hasValueFlow=32.1 $ hasValueFlow=32.2
end

def m33
    a = [0, 1, source(33)]
    b = a.delete_at(2)
    sink b # $ hasValueFlow=33
end

def m34
    a = [0, 1, source(34)]
    b = a.delete_if do |x|
        sink x # $ hasValueFlow=34
    end
    sink(b[0]) # $ hasValueFlow=34
end

def m35
    a = [0, 1, source(35)]
    b = a.difference([1])
    sink(b[0]) # $ hasValueFlow=35
end

def m36(i)
    a = [0, 1, source(36.1), [0, source(36.2)]]
    sink(a.dig(0))
    sink(a.dig(2)) # $ hasValueFlow=36.1
    sink(a.dig(i)) # $ hasValueFlow=36.1
    sink(a.dig(3,0))
    sink(a.dig(3,1)) # $ hasValueFlow=36.2
end

def m37
    a = [0, 1, source(37.1)]
    b = a.detect(-> { source(37.2) }) do |x|
        sink x # $ hasValueFlow=37.1
    end
    sink b # $ hasValueFlow=37.1 $ hasValueFlow=37.2
end

def m38(i)
    a = [0, 1, source(38.1), source(38.2)]
    b = a.drop(i)
    sink(b[0]) # $ hasValueFlow=38.1 # $ hasValueFlow=38.2
    b = a.drop(1)
    sink(b[0])
    sink(b[1]) # $ hasValueFlow=38.1
    sink(b[i]) # $ hasValueFlow=38.1 # $ hasValueFlow=38.2
    a[i] = source(38.3)
    b = a.drop(1)
    sink(b[1]) # $ hasValueFlow=38.1 # $ hasValueFlow=38.3
    c = b.drop(100)
    sink(c[1]) # $ hasValueFlow=38.3
end

def m39
    a = [0, 1, source(39.1), source(39.2)]
    b = a.drop_while do |x|
        sink x # $ hasValueFlow=39.1 # $ hasValueFlow=39.2
    end
    sink(b[0]) # $ hasValueFlow=39.1 # $ hasValueFlow=39.2
end

def m40
    a = [0, 1, source(40)]
    b = a.each do |x|
        sink x # $ hasValueFlow=40
    end
    sink(b[2]) # $ hasValueFlow=40
end

def m41
    a = [0, 1, source(41)]
    b = for x in a # desugars to an `each` call
        sink x # $ hasValueFlow=41
    end
    sink x # $ hasValueFlow=41
    sink(b[2]) # $ hasValueFlow=41
end

def m42
    a = [0, 1, source(42)]
    a.each_cons(2) do |x|
        sink (x[0]) # $ hasValueFlow=42
    end
end

def m43
    a = [0, 1, source(43)]
    b = a.each_entry do |x|
        sink x # $ hasValueFlow=43
    end
    sink(b[2]) # $ hasValueFlow=43
end

def m44
    a = [0, 1, source(44)]
    b = a.each_index do |x|
        sink x
    end
    sink(b[2]) # $ hasValueFlow=44
end

def m45
    a = [0, 1, 2, source(45)]
    a.each_slice(1) do |x|
        sink(x[0]) # $ hasValueFlow=45
    end
end

def m46
    a = [0, 1, 2, source(46)]
    b = a.each_with_index do |x,i|
        sink(x) # $ hasValueFlow=46
        sink(i)
    end
    sink(b[3]) # $ hasValueFlow=46
end

def m47
    a = [0, 1, 2, source(47.1)]
    b = a.each_with_object(source(47.2)) do |x,a|
        sink(x) # $ hasValueFlow=47.1
        sink(a) # $ hasValueFlow=47.2
    end
    sink(b) # $ hasValueFlow=47.2
end

def m48
    a = [0, 1, 2, source(48)]
    b = a.entries
    sink(b[3]) # $ hasValueFlow=48
end

def m49(i)
    a = [0, 1, 2, source(49.1)]
    b = a.fetch(source(49.2)) do |x|
        sink(x) # $ hasValueFlow=49.2
    end
    sink(b) # $ hasValueFlow=49.1
end

def m50
    a = [0, 1, 2, source(50.1)]
    a.fill(source(50.2), 1, 1)
    sink(a[3]) # $ hasValueFlow=50.1 $ hasValueFlow=50.2
    a.fill(source(50.3))
    sink(a[0]) # $ hasValueFlow=50.3
    a.fill do |i|
        source(50.4)
    end
    sink(a[0]) # $ hasValueFlow=50.4
    a.fill(2) do |i|
        source(50.5)
    end
    sink(a[0]) # $ hasValueFlow=50.4 $ hasValueFlow=50.5
end

def m51
    a = [0, 1, 2, source(51)]
    b = a.filter do |x|
        sink(x) # $ hasValueFlow=51
    end
    sink(b[0]) # $ hasValueFlow=51
end

def m52
    a = [0, 1, 2, source(52)]
    b = a.filter_map do |x|
        sink(x) # $ hasValueFlow=52
    end
    sink(b[0]) # $ hasValueFlow=52
end

def m53
    a = [0, 1, 2, source(53)]
    b = a.filter! do |x|
        sink(x) # $ hasValueFlow=53
        x > 2
    end
    sink(b[0]) # $ hasValueFlow=53
end

def m54
    a = [0, 1, 2, source(54.1)]
    b = a.find(-> { source(54.2) }) do |x|
        sink(x) # $ hasValueFlow=54.1
    end
    sink(b) # $ hasValueFlow=54.1 $ hasValueFlow=54.2
end

def m55
    a = [0, 1, 2, source(55)]
    b = a.find_all do |x|
        sink(x) # $ hasValueFlow=55
    end
    sink(b[0]) # $ hasValueFlow=55
end

def m56
    a = [0, 1, 2, source(56)]
    a.find_index do |x|
        sink(x) # $ hasValueFlow=56
    end
end

def m57(i)
    a = [source(57.1), 1, 2, source(57.2)]
    a[i] = source(57.3)
    sink(a.first) # $ hasValueFlow=57.1 $ hasValueFlow=57.3
    b = a.first(2)
    sink(b[0]) # $ hasValueFlow=57.1 $ hasValueFlow=57.3
    sink(b[4]) # $ hasValueFlow=57.3
    c = a.first(i)
    sink(c[0]) # $ hasValueFlow=57.1 $ hasValueFlow=57.3
    sink(c[3]) # $ hasValueFlow=57.2 $ hasValueFlow=57.3
end

def m58
    a = [0, 1, 2, source(58.1)]
    b = a.flat_map do |x|
        sink(x) # $ hasValueFlow=58.1
        [x, source(58.2)]
    end
    sink(b[0]) # $ hasValueFlow=58.1 $ hasValueFlow=58.2
end

def m59
    a = [0, 1, [2, source(59)]]
    b = a.flatten
    sink(b[0]) # $ hasValueFlow=59
end

def m60
    a = [0, 1, [2, source(60)]]
    sink(a[2][1]) # $ hasValueFlow=60
    a.flatten!
    sink(a[0]) # $ hasValueFlow=60
    sink(a[2][1]) # $ SPURIOUS: hasValueFlow=60
end

def m61
    a = [0, 1, 2, source(61.1)]
    b = a.grep(/.*/)
    sink(b[0]) # $ hasValueFlow=61.1
    b = a.grep(/.*/) do |x|
        sink x # $ hasValueFlow=61.1
        source(61.2)
    end
    sink(b[0]) # $ hasValueFlow=61.2
end

def m62
    a = [0, 1, 2, source(62.1)]
    b = a.grep_v(/A/)
    sink(b[0]) # $ hasValueFlow=62.1
    b = a.grep_v(/A/) do |x|
        sink x # $ hasValueFlow=62.1
        source(62.2)
    end
    sink(b[0]) # $ hasValueFlow=62.2
end

# 63 group_by

def m64
    a = [0, 1, 2, source(64)]
    a.index do |x|
        sink x # $ hasValueFlow=64
    end
end

# 64 map
# 65 max
# 66 max_by
# 67 min
# 68 min_by
# 69 minmax
# 70 minmax_by
# 71 none?
# 72 one?
# 73 partition
# 74 reduce_inject
# 75 reject

def m76
    a = [0, 1, 2, source(76.1)]
    a.replace([source(76.2)])
    sink(a[0]) # $ hasValueFlow=76.2
end

# 77 reverse_each
# 78 select
# 79 slice_after
# 80 slice_before
# 81 slice_when
# 82 sort
# 83 sort_by

def m84
    a = [0, 1, source(84.1)]
    a.prepend(2, 3, source(84.2))
    sink(a[0])
    sink(a[1])
    sink(a[2]) # $ hasValueFlow=84.2
    sink(a[3])
    sink(a[4])
    sink(a[5]) # $ hasValueFlow=84.1
end

# 85 sum
# 86 take
# 87 take_while
# 88 tally

def m89
    a = [0, 1, 2, source(89)]
    b = a.to_a
    sink(b[3]) # $ hasValueFlow=89
end

# 90 uniq
# 91 zip