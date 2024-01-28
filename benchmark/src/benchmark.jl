module benchmark

using BenchmarkTools
using PokemonObserver

include("Vision.jl")

function render(io, trial::BenchmarkTools.Trial)
    show(io, MIME("text/plain"), trial)
    print(io, "\n")
end

function render(io, group::BenchmarkTools.BenchmarkGroup)
    for (id, s) in group
        println(io, id)
        render(io, s)
    end
end

function b()
    suite = BenchmarkGroup()
    suite["vision"] = Vision()
    tune!(suite)
    results = run(suite)
    io = IOContext(stdout, :logbins => true)
    render(io, results)
end

export b

end # module benchmark
