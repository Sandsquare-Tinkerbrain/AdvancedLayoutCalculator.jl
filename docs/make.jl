using InputLayoutGenerator
using Documenter

DocMeta.setdocmeta!(InputLayoutGenerator, :DocTestSetup, :(using InputLayoutGenerator); recursive=true)

makedocs(;
    modules=[InputLayoutGenerator],
    authors="Sh",
    repo="https://github.com/Sandsquare-Tinkerbrain/InputLayoutGenerator.jl/blob/{commit}{path}#{line}",
    sitename="InputLayoutGenerator.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Sandsquare-Tinkerbrain.github.io/InputLayoutGenerator.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Sandsquare-Tinkerbrain/InputLayoutGenerator.jl",
)
