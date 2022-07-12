module TextProcessor


    const PChar = Union{AbstractString, Symbol}
    export PChar

    include("frequency.jl")
    export getngrams, RawPiece

    include("procpiece.jl")
    export ProcPiece

    include("processedstring.jl")
    export PString, getv, to_string, to_pstring

end