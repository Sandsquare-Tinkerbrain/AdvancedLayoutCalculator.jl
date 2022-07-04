"""
    AbstractPiece

An abstract type representing a piece of text.
"""
abstract type AbstractPiece end


"""
    RawPiece

Stores n-gram counts of a piece of text. Only accounts for raw characters.

```jldoctest
julia> using InputLayoutGenerator.TextProcessor

julia> d = Dict("a" => 10, "e" => 4); 

julia> RawPiece(d, 15)
ERROR: Sum of 'counts' (14) must equal the 'total' (15)!
```
"""
struct RawPiece <: AbstractPiece
    counts::Dict{String, Int}
    total::Int

    function RawPiece(c, t)
        s = sum(values(c))
        s != t ? error("Sum of 'counts' ($s) must equal the 'total' ($t)!") : new(c, t)
    end
end

function RawPiece(rawtext::String)
    
end


"""
    getngrams(::String)

Test thing

```jldoctest
julia> using InputLayoutGenerator.TextProcessor

julia> getngrams("hello")
5
```
"""
function getngrams(str)
    # placeholder

    return length(str)
end