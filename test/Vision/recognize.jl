using Images, FileIO

@testset "Recognize" begin
    using PokemonObserver.Vision

    struct TestImage
        name::String
        pixelsRaw::Any
        colors::Any
        expectedText::Matrix{Char}
        pixelsARGB::Matrix{UInt32}

        function TestImage(root, name)
            pixelsRaw = load(joinpath(root, "images", name))
            txt = Base.read(joinpath(root, "output", name), String)
            expected = reduce(vcat, permutedims.(split(txt, r"[\r\n]+") |> Base.Fix1(map, line -> collect(line)) |> Base.Fix1(filter, cs -> length(cs) > 0)))
            colors = Set(pixelsRaw)
            pixelsARGB = Matrix{UInt32}(undef, 144, 160)
            for (i, pr) in enumerate(pixelsRaw)
                pixelsARGB[i] = 0xff000000 | (convert(UInt32, reinterpret(pr.r)) << 16) | (convert(UInt32, reinterpret(pr.g)) << 8) | convert(UInt32, reinterpret(pr.b))
            end
            new(name, pixelsRaw, colors, expected, pixelsARGB)
        end
    end

    basename = dirname(@__FILE__)
    images = readdir(joinpath(basename, "images")) |> Base.Fix1(map, n -> TestImage(basename, n))

    for img in images
        @test size(img.expectedText) == (18, 20)
        @test length(img.colors) > 0 && length(img.colors) <= 4
        @test Vision.recognize_chars(img.pixelsARGB) == img.expectedText
    end
end
