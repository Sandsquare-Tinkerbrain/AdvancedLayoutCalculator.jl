module TextProcessor

    include("frequency.jl")
    export getngrams, RawPiece

    include("processedstring.jl")
    export PChar, PString, getv, to_string, to_pstring

end