"""
Look for interesting objects on screen.
"""
module Vision

include("../prelude.jl")
include("font.jl")
include("objects.jl")

function recognize_objects(pixels::Matrix{UInt32})
    colors = pixels |> unique |> sort

    # Allow the rest of this function to assume all four colors are present.
    # Can be the source of some mismatches. None have been a blocking issue to date.
    while length(colors) < 4
        push!(colors, 0)
    end

    paletteized = (pixels |> Base.Fix1(map, p -> begin
                                           for (i, c) in enumerate(colors)
                                               if p == c
                                                   return i - 1
                                               end
                                           end
                                           0
                                       end))

    out = Matrix{Union{ObjectOfInterest, Nothing}}(nothing, 9, 10)
    for col in 1:10
        for row in 1:9
            region = paletteized[(row-1)*16+1:row*16 , (col-1)*16+1:col*16]

            for (obj, shape) in catalog
                if region == shape # TODO: Extend to allow masking when shapes don't take up a full tile
                    out[row, col] = obj
                    break
                end
            end
        end
    end

    return out
end

function recognize_chars(pixels::Matrix{UInt32})
    maxColor = maximum(pixels)
    minColor = minimum(pixels)

    filtered = (pixels |> Base.Fix1(map, p -> p == maxColor ? 0x01 : (p == minColor ? 0x00 : 0x02)))

    out = Matrix{Char}(undef, 18, 20)
    for col in 1:20
        for row in 1:18
            region = filtered[(row-1)*8+1:row*8 , (col-1)*8+1:col*8]
            out[row, col] = ' '
            for (letter, glyph) in font
                if region == glyph
                    out[row, col] = letter
                    break
                end
            end
        end
    end
    out
end

function recognize(pixels::Ptr{UInt32})::Tuple{Matrix{Union{ObjectOfInterest, Nothing}}, Matrix{Char}}
    frame = Matrix{UInt32}(undef, 144, 160)

    for j in 1:144
        for i in 1:160
            frame[j, i] = unsafe_load(pixels, i + (j-1)*160)
        end
    end

    objs = recognize_objects(frame)
    chars = recognize_chars(frame)
    (objs, chars)
end

export ObjectOfInterest
@exportinstances ObjectOfInterest

export recognize
end
