using InputLayoutGenerator
using Documenter

DocMeta.setdocmeta!(InputLayoutGenerator, :DocTestSetup, :(using InputLayoutGenerator); recursive=true)

makedocs(;
    modules=[InputLayoutGenerator],
    authors="Sh",
    repo="https://github.com/sdgu/InputLayoutGenerator.jl/blob/{commit}{path}#{line}",
    sitename="InputLayoutGenerator.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://sdgu.github.io/InputLayoutGenerator.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/sdgu/InputLayoutGenerator.jl",
    devbranch="master",
)
