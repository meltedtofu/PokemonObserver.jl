using Images, FileIO

function Vision()::BenchmarkGroup
    function loadPixels(path)::Matrix{UInt32}
        rawPixels = load(path)
        pixels = Matrix{UInt32}(undef, 144, 160)
        for (i, rp) in enumerate(rawPixels)
            pixels[i] = 0xff000000 | (convert(UInt32, reinterpret(rp.r)) << 16) | (convert(UInt32, reinterpret(rp.g)) << 8) | convert(UInt32, reinterpret(rp.b))
        end
        pixels
    end

    basepath = joinpath(dirname(@__FILE__), "..", "..", "test", "Vision", "images")
    images = readdir(basepath) |> Base.Fix1(map, n -> (n, loadPixels(joinpath(basepath, n))))

    g = BenchmarkGroup()
    for (name, pixels) in images
        g[name] = @benchmarkable PokemonObserver.Vision.recognize_chars($pixels)
    end
    g
end
