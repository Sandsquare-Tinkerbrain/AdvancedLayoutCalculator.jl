abstract type AbstractPString end

PChar = Union{Char, Symbol}

"""
    PString

Special type of string that can keep track of things like mods (e.g., shift).
"""
struct PString <: AbstractPString
    v::AbstractArray{PChar}

end
getv(pstr::PString) = pstr.v
Base.length(pstr::PString) = length(getv(pstr))
Base.getindex(pstr::PString, i::Int64) = getindex(getv(pstr), i)
# TODO: equals

function PString(text::String)::PString
    return to_pstring(text)
end


"""
to_string(::PString)

Converts PString to String.

```jldoctest
julia> using InputLayoutGenerator.TextProcessor

julia> p = PString(['1', 'h', :shift, 'p']);

julia> q = to_string(p)
"1hP"

julia> to_pstring(q)
PString(Union{Char, Symbol}['1', 'h', :shift, 'p'])
```
"""
function to_string(pstr::PString)::String
    outstr = ""
    nextf(x::Char) = identity(x)
    for i in 1:length(pstr)
        c = pstr[i]
        if c == :shift
            nextf = uppercase
            continue
        elseif typeof(c) == Symbol
            continue
        end
        outstr *= nextf(c)
        nextf = identity
    end
    return outstr
end

"""
    to_pstring(::String)

Converts String to PString. Currently only accounts for capital alphas.

```jldoctest
julia> using InputLayoutGenerator.TextProcessor

julia> p = to_pstring("helLo")
PString(Union{Char, Symbol}['h', 'e', 'l', :shift, 'l', 'o'])

julia> to_string(p)
"helLo"
```
"""
function to_pstring(str::String)::PString
    v = PChar[]
    for i in 1:length(str)
        c = str[i]
        if isuppercase(c)
            push!(v, :shift)
            push!(v, lowercase(c))
        else
            push!(v, c)
        end
    end
    return PString(v)
end


