using ConsoleLayoutGenerator
using Documenter

DocMeta.setdocmeta!(ConsoleLayoutGenerator, :DocTestSetup, :(using ConsoleLayoutGenerator); recursive=true)

makedocs(;
    modules=[ConsoleLayoutGenerator],
    authors="Sh",
    repo="https://github.com/sdgu/ConsoleLayoutGenerator.jl/blob/{commit}{path}#{line}",
    sitename="ConsoleLayoutGenerator.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://sdgu.github.io/ConsoleLayoutGenerator.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/sdgu/ConsoleLayoutGenerator.jl",
    devbranch="master",
)
