using AdvancedLayoutCalculator.TextProcessor
using AdvancedLayoutCalculator.TextProcessor: _updatedict!, _ngram


@testset "Processing strings" begin
    
    p = PString(["1", "h", :shift, "p"]);
    q = to_string(p)
    @test q == "1hP"
    
    backp = to_pstring(q)
    @test backp[1] == "1"
    @test backp[2] == "h"
    @test backp[3] == :shift
    @test backp[4] == "p"

    p = to_pstring("helLo")
    @test p[1] == "h"
    @test p[2] == "e"
    @test p[3] == "l"
    @test p[4] == :shift
    @test p[5] == "l"
    @test p[6] == "o"

    @test to_string(p) == "helLo"

end

@testset "Frequency" begin

    using AdvancedLayoutCalculator.TextProcessor: _updatedict!, _ngram
    
    d = Dict{PChar, Number}("a" => 1)
    _updatedict!(d, "a")
    @test length(d) == 1
    @test d["a"] == 2
    
    _updatedict!(d, PChar[:shift, "e", "e", "C", "a"])
    @test length(d) == 4
    @test d[:shift] == 1
    @test d["e"] == 2
    @test d["C"] == 1
    @test d["a"] == 3

    subgrams = _ngram("hello Ez", 3)
    @test subgrams[1] == "hel"

    d = getngrams("heLh", 3)
    @test length(d) == 8
    @test d["h"] == 2
    @test d["e"] == 1
    @test d["L"] == 1
    @test d["he"] == 1
    @test d["eL"] == 1
    @test d["Lh"] == 1
    @test d["heL"] == 1
    @test d["eLh"] == 1

    r1 = RawPiece("heLh", 3)
    @test r1.counts == d
    @test r1.total == 9
    r2 = RawPiece(d, 9)
    @test r2.counts == d
    @test r2.total == 9
    r3 = RawPiece(d)
    @test r3.counts == d
    @test r3.total == 9
    let err = nothing
        try
            RawPiece(d, 8)
        catch err
        end

        @test err isa Exception
        @test sprint(showerror, err) == "Sum of 'counts' (9) must equal the 'total' (8)!"
    end

    let err = nothing
        try
            getngrams("heLo", 5)
        catch err
        end

        @test err isa Exception
        @test sprint(showerror, err) == "Max ngram size (5) can't be greater than length of text (4)!"
    end

    d = getngrams("apapaL", 3)
    @test length(d) == 9
    @test d["a"] == 3
    @test d["p"] == 2
    @test d["L"] == 1
    @test d["ap"] == 2
    @test d["pa"] == 2
    @test d["aL"] == 1
    @test d["apa"] == 2
    @test d["pap"] == 1
    @test d["paL"] == 1

    r1 = RawPiece("apapaL", 3)
    @test r1.counts == d
    @test r1.total == 15

    d = getngrams("hasta", 4)
    @test length(d) == 13
    @test d["h"] == 1
    @test d["a"] == 2
    @test d["s"] == 1
    @test d["t"] == 1
    @test d["ha"] == 1
    @test d["as"] == 1
    @test d["st"] == 1
    @test d["ta"] == 1
    @test d["has"] == 1
    @test d["ast"] == 1
    @test d["sta"] == 1
    @test d["hast"] == 1
    @test d["asta"] == 1

    r1 = RawPiece("hasta", 4)
    @test r1.counts == d
    @test r1.total == 14
end

