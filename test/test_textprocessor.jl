using AdvancedLayoutCalculator.TextProcessor
using AdvancedLayoutCalculator.TextProcessor: _updatedict!, _ngram


# @testset "Processing strings" begin
    
#     p = PString(["1", "h", :shift, "p"]);
#     q = to_string(p)
#     @test q == "1hP"
    
#     backp = to_pstring(q)
#     @test backp[1] == "1"
#     @test backp[2] == "h"
#     @test backp[3] == :shift
#     @test backp[4] == "p"

#     p = to_pstring("helLo")
#     @test p[1] == "h"
#     @test p[2] == "e"
#     @test p[3] == "l"
#     @test p[4] == :shift
#     @test p[5] == "l"
#     @test p[6] == "o"

#     @test to_string(p) == "helLo"

# end

@testset "update dict" begin

    using AdvancedLayoutCalculator.TextProcessor: _updatedict!, _ngram
    
    d = Dict{Int, Dict{String, Int}}(1 => Dict("a" => 1))
    _updatedict!(d, "a")
    @test length(d) == 1
    @test length(d[1]) == 1
    @test d[1]["a"] == 2
    _updatedict!(d, "sa")
    @test length(d) == 2
    @test length(d[2]) == 1
    @test d[2]["sa"] == 1
    
    d = Dict{Int, Dict{PString, Int}}(1 => Dict(PString("a") => 1))
    _updatedict!(d, PString[:shift, "e", "e", "c", "a", "bd"])
    @test length(d) == 2
    @test length(d[1]) == 4
    @test d[1][:shift] == 1
    @test d[1]["e"] == 2
    @test d[1]["c"] == 1
    @test d[1]["a"] == 2
    @test d[2]["bd"] == 1
    @test length(d[2]) == 1
end

# @testset "ngram" begin

#     subgrams = _ngram("hello Ez", 3)
#     @test subgrams[1] == "hel"

#     d = getngrams("heLh", 3)
#     @test length(d) == 8
#     @test d["h"] == 2
#     @test d["e"] == 1
#     @test d["L"] == 1
#     @test d["he"] == 1
#     @test d["eL"] == 1
#     @test d["Lh"] == 1
#     @test d["heL"] == 1
#     @test d["eLh"] == 1

#     r1 = RawPiece("heLh", 3)
#     @test getcountsdict(r1) == d
#     @test gettotal(r1) == 9
#     r2 = RawPiece(d, 9)
#     @test getcountsdict(r2) == d
#     @test gettotal(r2) == 9
#     r3 = RawPiece(d)
#     @test getcountsdict(r3) == d
#     @test gettotal(r3) == 9
#     let err = nothing
#         try
#             RawPiece(d, 8)
#         catch err
#         end

#         @test err isa Exception
#         @test sprint(showerror, err) == "Sum of 'counts' (9) must equal the 'total' (8)!"
#     end

#     let err = nothing
#         try
#             getngrams("heLo", 5)
#         catch err
#         end

#         @test err isa Exception
#         @test sprint(showerror, err) == "Max ngram size (5) can't be greater than length of text (4)!"
#     end

#     d = getngrams("apapaL", 3)
#     @test length(d) == 9
#     @test d["a"] == 3
#     @test d["p"] == 2
#     @test d["L"] == 1
#     @test d["ap"] == 2
#     @test d["pa"] == 2
#     @test d["aL"] == 1
#     @test d["apa"] == 2
#     @test d["pap"] == 1
#     @test d["paL"] == 1

#     r1 = RawPiece("apapaL", 3)
#     @test getcountsdict(r1) == d
#     @test gettotal(r1) == 15

#     d = getngrams("hasta", 4)
#     @test length(d) == 13
#     @test d["h"] == 1
#     @test d["a"] == 2
#     @test d["s"] == 1
#     @test d["t"] == 1
#     @test d["ha"] == 1
#     @test d["as"] == 1
#     @test d["st"] == 1
#     @test d["ta"] == 1
#     @test d["has"] == 1
#     @test d["ast"] == 1
#     @test d["sta"] == 1
#     @test d["hast"] == 1
#     @test d["asta"] == 1

#     r1 = RawPiece("hasta", 4)
#     @test getcd(r1) == d
#     @test gett(r1) == 14
# end

# @testset "actual text" begin
#     f = "../1342-0.txt"
#     open(f, "r") do fi
#         s = read(f, String)
#         println(length(s))
#         d = getngrams(s, 4)
#         println(length(d))

#     end

# end

