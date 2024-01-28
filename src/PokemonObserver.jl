module PokemonObserver

using GameBoy

include("./Knowledge/Knowledge.jl")
using .Knowledge: Knowledge, Pkmn, BattleType
include("./Vision/Vision.jl")
using .Vision: ObjectOfInterest, recognize

struct BitIterator{T<:Integer}
    val::T
end
Base.length(itr::BitIterator) = sizeof(itr.val) * 8
Base.eltype(itr::BitIterator) = Bool
function Base.iterate(itr::BitIterator{T}, mask=one(T)) where {T}
    iszero(mask) && return nothing
    return !iszero(itr.val & mask), mask << 1
end

struct Pokedex
    owned::Vector{Union{Pkmn, Nothing}}
    seen::Vector{Union{Pkmn, Nothing}}

    Pokedex() = new([], [])

    function Pokedex(gb::Emulator)
        try
            owned = reduce(vcat, [collect(BitIterator(GameBoy.read(gb, addr))) for addr in 0xd2f7:0xd309])
            seen = reduce(vcat, [collect(BitIterator(GameBoy.read(gb, addr))) for addr in 0xd30a:0xd31c])

            new(zip(owned, instances(Knowledge.Pkmn)) |> Base.Fix1(map, z -> first(z) ? last(z) : nothing),
                zip(seen, instances(Knowledge.Pkmn)) |> Base.Fix1(map, z -> first(z) ? last(z) : nothing))
        catch e
            if e isa InvalidStateException
                return
            else
                rethrow()
            end
        end
    end
end

function playername(gb::Emulator)
    try
        bytes = [GameBoy.read(gb, addr) for addr ∈ 0xd158:0xd162]
        name = nothing
        if first(bytes) != 0x00
            terminatoridx  = findfirst(n -> n == 0x50, bytes)
            if !isnothing(terminatoridx)
                n = String(map(d -> UInt8(d-0x3f), bytes[1:terminatoridx]))
                if !startswith(n, "NINTEN")
                    name = n
                end
            end
        end
        name
    catch e
        if e isa InvalidStateException
            return
        else
            rethrow()
        end
    end
end

function rivalname(gb::Emulator)
    try
        bytes = [GameBoy.read(gb, addr) for addr in 0xd34a:0xd351]
        name = nothing
        if first(bytes) != 0x00
            terminatoridx  = findfirst(n -> n == 0x50, bytes)
            if !isnothing(terminatoridx)
                n = String(map(d -> UInt8(d-0x3f), bytes[1:terminatoridx]))
                if !startswith(n, "SONY")
                    name = n
                end
            end
        end
        name
    catch e
        if e isa InvalidStateException
            return
        else
            rethrow()
        end
    end
end

function readpos(gb::Emulator)::Tuple{UInt8, UInt8, UInt8}
    try
        (GameBoy.read(gb, 0xd35e),
         GameBoy.read(gb, 0xd362),
         GameBoy.read(gb, 0xd361))
    catch e
        if e isa InvalidStateException
            return
        else
            rethrow()
        end
    end
end

function interpretscreen(pixels)
    (objs, txt) = recognize(convert(Ptr{UInt32}, pixels))

    current_menu = nothing

    # look for ▶
    # if present -> attempt to etract the menu options (split text based on lines and join into words?) (obvious fail when keyboard shows up, but :shrug: for now)
    if '▶' ∈ txt
        # Found a menu. attempt to extract it.

        rawoptions = [r |> join |> strip for r ∈ eachrow(txt)] |> Base.Fix1(filter, ro -> !isempty(ro))
        current_menu = rawoptions |> Base.Fix1(map, ro -> (replace(ro, "▶" => ""), occursin("▶", ro)))
        # TODO: Determine type of menu instead of assuming full screen linear. (i.e. anything other than the "New Game" screen.)
        # TODO: Menu with dialog/prompt at bottom.
        # TODO: Overlapping Menus (mostly the select menu)
        # TODO: Keyboard
        # TODO: Settings menu (for automating animations, text speed, etc)
    end

    (objs, txt, current_menu)
end

unrollbcd(b::UInt8)::Int = Int((b & 0xf0) >> 4) * 10 + (b & 0x0f)

function pokedollars(gb::Emulator)::Int
    unrollbcd(GameBoy.read(gb, 0xd347)) * 10000 +
        unrollbcd(GameBoy.read(gb, 0xd348)) * 100 +
        unrollbcd(GameBoy.read(gb, 0xd349))
end

struct Battle
    typ::BattleType
    opposing_pokemon::Union{Pkmn, Nothing}

    Battle() = new(Knowledge.NoBattle, Knowledge.Mew)
    Battle(gb::Emulator) = new(Knowledge.BattleType(GameBoy.read(gb, 0xd057)),
                               Knowledge.memory_to_species(GameBoy.read(gb, 0xcfd8)))
end

"""
The current high-level game state extracted directly from the emulator's memory.
"""
struct GameState
    pokedex::Pokedex
    playername::Union{String, Nothing}
    rivalname::Union{String, Nothing}
    position::Tuple{UInt8, UInt8, UInt8}
    text::Matrix{Char}
    objects::Matrix{Union{ObjectOfInterest, Nothing}}
    menu::Union{Vector{Tuple{String, Bool}}, Nothing}
    battle::Battle
    has_oaks_parcel::Bool # Expand to support other events
    pokedollars::Int

    # somewhat silly stub to make testing primitive planners (ones that don't rely on game state) slightly easier.
    function GameState()
        new(Pokedex(),
            nothing,
            nothing,
            (0, 0, 0),
            [' ' ' '],
            [nothing nothing],
            nothing,
            Battle(),
            false,
            0)
    end

    function GameState(gb::Emulator, pixels)
        (objs, txt, menu) = interpretscreen(pixels)

        new(
            Pokedex(gb),
            playername(gb),
            rivalname(gb),
            readpos(gb),
            txt,
            objs,
            menu,
            Battle(gb),
            Emulator.read(gb, 0xd31e) == 0x46 || Emulator.read(gb, 0xd320) == 0x46,        # Check if the parcel is in item slot 1 or 2.
            pokedollars(gb),
        )
    end
end

export GameState

# TODO Which state (battle, menu, overworld, dialog, etc)
# TODO Which pokemon am I fighting?
# TODO Wild vs trainer battle?

end # module PokemonObserver
