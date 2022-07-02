module InputLayoutGenerator

include("TextProcessor/TextProcessor.jl")
using .TextProcessor
export getngrams



include("layout.jl")
export GeneralLayout



test() = println("test")
export test

end

