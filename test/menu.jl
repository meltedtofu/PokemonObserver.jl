using Images, FileIO

@testset "Menu" begin
    @testset "Start Menu" begin
        pixelsRaw = load(joinpath(@__DIR__, "Vision", "images", "pokemonstartmenu.png"))
        colors = Set(pixelsRaw)
        pixelsARGB = Matrix{UInt32}(undef, 144, 160)
        for (i, pr) in enumerate(pixelsRaw)
            pixelsARGB[i] = 0xff000000 | (convert(UInt32, reinterpret(pr.r)) << 16) | (convert(UInt32, reinterpret(pr.g)) << 8) | convert(UInt32, reinterpret(pr.b))
        end

        (_, _, menu) = PokemonObserver.interpretscreen(pixelsARGB)

        @test length(menu) == 3
        @test menu[1] == ("CONTINUE", 1)
        @test menu[2] == ("NEW GAME", 0)
        @test menu[3] == ("OPTION", 0)
    end
end