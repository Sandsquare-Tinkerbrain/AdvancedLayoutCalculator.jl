"""
    AbstractPiece

An abstract type representing a piece of text.
"""
abstract type AbstractPiece end


"""
    RawPiece

Stores n-gram counts of a piece of text. Only accounts for raw characters.

```jldoctest
julia> using AdvancedLayoutCalculator.TextProcessor

julia> d = Dict("a" => 10, "e" => 4); 

julia> RawPiece(d, 15)
ERROR: Sum of 'counts' (14) must equal the 'total' (15)!
```
"""
struct RawPiece <: AbstractPiece
    counts::Dict{String, Int}
    total::Int

    function RawPiece(c::Dict{<:PChar, <:Number})
        newc = Dict(convert(String, k) => convert(Int, v) for (k, v) in pairs(c))
        s = sum(values(newc))
        return new(newc, s)
    end
    function RawPiece(c::Dict{<:PChar, <:Number}, t::Int)
        newc = Dict(convert(String, k) => convert(Int, v) for (k, v) in pairs(c))
        s = sum(values(newc))
        s != t ? error("Sum of 'counts' ($s) must equal the 'total' ($t)!") : new(newc, t)
    end
end

function RawPiece(rawtext::String, up2n::Int)
    d = getngrams(rawtext, up2n)
    newd = Dict(convert(String, k) => convert(Int, v) for (k, v) in pairs(d))
    return RawPiece(newd)
end


"""
    getngrams(::String, ::Int)

Get all n-grams up to n.

```jldoctest
julia> using AdvancedLayoutCalculator.TextProcessor

julia> getngrams("heLo", 4)
Dict{Union{AbstractString, Symbol}, Number} with 10 entries:
  "eLo"  => 1
  "heLo" => 1
  "e"    => 1
  "o"    => 1
  "Lo"   => 1
  "L"    => 1
  "he"   => 1
  "h"    => 1
  "eL"   => 1
  "heL"  => 1

```
"""
function getngrams(rawtext::String, up2n::Int)
    total = length(rawtext)
    if up2n > total
        error("Max ngram size ($up2n) can't be greater than length of text ($total)!")
    end
    d = Dict{PChar, Number}()

    subgramsizes = 1:up2n-1
    for i in 1:total-up2n+1
        ss = view(rawtext, i:i+up2n-1)
        for sgs in subgramsizes
            untouched = if i == 1 ss else view(ss, length(ss)-sgs+1:length(ss)) end
            subgrams = _ngram(untouched, sgs)
            _updatedict!(d, subgrams)
        end
        _updatedict!(d, ss)
    end

    return d
end

"""
    _ngram(::String, ::Int)

https://stackoverflow.com/questions/42360957/generate-ngrams-with-julia

```jldoctest
julia> AdvancedLayoutCalculator.TextProcessor._ngram("hello Ez", 3)
6-element Vector{SubString{String}}:
 "hel"
 "ell"
 "llo"
 "lo "
 "o E"
 " Ez"
```
"""
_ngram(s::AbstractString, n::Int) = [view(s,i:i+n-1) for i=1:length(s)-n+1]


"""
    _updatedict!(::Dict, ::PChar)

```jldoctest updatedictdoctests
julia> using AdvancedLayoutCalculator.TextProcessor

julia> d = Dict{PChar, Number}("a" => 1);

julia> AdvancedLayoutCalculator.TextProcessor._updatedict!(d, "a")
Dict{Union{String, Symbol}, Number} with 1 entry:
  "a" => 2
```
"""
function _updatedict!(d::Dict{<:PChar, <:Number}, k::PChar)
    d[k] = get(d, k, 0) + 1
    return d
end

"""
    _updatedict!(::Dict, ::PChar)

```jldoctest updatedictdoctests
julia> using AdvancedLayoutCalculator.TextProcessor

julia> d = Dict{PChar, Number}("a" => 2);

julia> AdvancedLayoutCalculator.TextProcessor._updatedict!(d, PChar[:shift, "e", "e", "C", "a"])
Dict{Union{String, Symbol}, Number} with 4 entries:
  :shift => 1
  "e"    => 2
  "C"    => 1
  "a"    => 3
```
"""
function _updatedict!(d::Dict{<:PChar, <:Number}, karr::Array{<:PChar})
    for k in karr
        _updatedict!(d, k)
    end
    return d
end
