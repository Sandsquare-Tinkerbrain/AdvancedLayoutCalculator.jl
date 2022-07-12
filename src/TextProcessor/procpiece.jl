"""
    ProcPiece

Stores n-gram counts of a piece of text. Converts strings to PChars.

```jldoctest
julia> using AdvancedLayoutCalculator.TextProcessor

julia> d = Dict("A" => 10, "e" => 4); 
```
"""
struct ProcPiece <: AbstractPiece
    counts::Dict{<:PChar, Int}
    total::Int

    function ProcPiece(c::Dict{<:PChar, <:Number})
        newc = Dict(k => convert(Int, v) for (k, v) in pairs(c))
        s = sum(values(newc))
        return new(newc, s)
    end
    function ProcPiece(c::Dict{<:PChar, <:Number}, t::Int)
        newc = Dict(k => convert(Int, v) for (k, v) in pairs(c))
        s = sum(values(newc))
        s != t ? error("Sum of 'counts' ($s) must equal the 'total' ($t)!") : new(newc, t)
    end
end

function ProcPiece(r::RawPiece)
    
end

# function ProcPiece(rawtext::String, up2n::Int)
#     d = getngrams(rawtext, up2n)
#     newd = Dict(k => convert(Int, v) for (k, v) in pairs(d))
#     r = RawPiece(newd)
#     return ProcPiece(r)
# end