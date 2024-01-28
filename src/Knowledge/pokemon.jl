@enum Pkmn begin
    Bulbasaur
    Ivysaur
    Venusaur
    Charmander
    Charmeleon
    Charizard
    Squirtle
    Wartortle
    Blastoise
    Caterpie
    Metapod
    Butterfree
    Weedle
    Kakuna
    Beedrill
    Pidgey
    Pidgeotto
    Pidgeot
    Rattata
    Raticate
    Spearow
    Fearow
    Ekans
    Arbok
    Pikachu
    Raichu
    Sandshrew
    Sandslash
    Nidoran♀
    Nidorina
    Nidoqueen
    Nidoran♂
    Nidorino
    Nidoking
    Clefairy
    Clefable
    Vulpix
    Ninetales
    Jigglypuff
    Wigglytuff
    Zubat
    Golbat
    Oddish
    Gloom
    Vileplume
    Paras
    Parasect
    Venonat
    Venomoth
    Diglett
    Dugtrio
    Meowth
    Persian
    Psyduck
    Golduck
    Mankey
    Primeape
    Growlithe
    Arcanine
    Poliwag
    Poliwhirl
    Poliwrath
    Abra
    Kadabra
    Alakazam
    Machop
    Machoke
    Machamp
    Bellsprout
    Weepinbell
    Victreebel
    Tentacool
    Tentacruel
    Geodude
    Graveler
    Golem
    Ponyta
    Rapidash
    Slowpoke
    Slowbro
    Magnemite
    Magneton
    Farfetchd
    Doduo
    Dodrio
    Seel
    Dewgong
    Grimer
    Muk
    Shellder
    Cloyster
    Gastly
    Haunter
    Gengar
    Onix
    Drowzee
    Hypno
    Krabby
    Kingler
    Voltorb
    Electrode
    Exeggcute
    Exeggutor
    Cubone
    Marowak
    Hitmonlee
    Hitmonchan
    Lickitung
    Koffing
    Weezing
    Rhyhorn
    Rhydon
    Chansey
    Tangela
    Kangaskhan
    Horsea
    Seadra
    Goldeen
    Seaking
    Staryu
    Starmie
    MrMime
    Scyther
    Jynx
    Electabuzz
    Magmar
    Pinsir
    Tauros
    Magikarp
    Gyarados
    Lapras
    Ditto
    Eevee
    Vaporeon
    Jolteon
    Flareon
    Porygon
    Omanyte
    Omastar
    Kabuto
    Kabutops
    Aerodactyl
    Snorlax
    Articuno
    Zapdos
    Moltres
    Dratini
    Dragonair
    Dragonite
    Mewtwo
    Mew
end

function memory_to_species(b::UInt8)::Pkmn
    if b == 0x01
        return Rhydon
    elseif b == 0x02
        return Kangaskhan
    elseif b == 0x03
        return NidoranM
    elseif b == 0x04
        return Clefairy
    elseif b == 0x05
        return Spearow
    elseif b == 0x06
        return Voltorb
    elseif b == 0x07
        return Nidoking
    elseif b == 0x08
        return Slowbro
    elseif b == 0x09
        return Ivysaur
    elseif b == 0x0A
        return Exeggutor
    elseif b == 0x0B
        return Lickitung
    elseif b == 0x0C
        return Exeggcute
    elseif b == 0x0D
        return Grimer
    elseif b == 0x0E
        return Gengar
    elseif b == 0x0F
        return NidoranF
    elseif b == 0x10
        return Nidoqueen
    elseif b == 0x11
        return Cubone
    elseif b == 0x12
        return Rhyhorn
    elseif b == 0x13
        return Lapras
    elseif b == 0x14
        return Arcanine
    elseif b == 0x15
        return Mew
    elseif b == 0x16
        return Gyarados
    elseif b == 0x17
        return Shellder
    elseif b == 0x18
        return Tentacool
    elseif b == 0x19
        return Gastly
    elseif b == 0x1A
        return Scyther
    elseif b == 0x1B
        return Staryu
    elseif b == 0x1C
        return Blastoise
    elseif b == 0x1D
        return Pinsir
    elseif b == 0x1E
        return Tangela
    elseif b == 0x21
        return Growlithe
    elseif b == 0x22
        return Onix
    elseif b == 0x23
        return Fearow
    elseif b == 0x24
        return Pidgey
    elseif b == 0x25
        return Slowpoke
    elseif b == 0x26
        return Kadabra
    elseif b == 0x27
        return Graveler
    elseif b == 0x28
        return Chansey
    elseif b == 0x29
        return Machoke
    elseif b == 0x2A
        return Mr. Mime
    elseif b == 0x2B
        return Hitmonlee
    elseif b == 0x2C
        return Hitmonchan
    elseif b == 0x2D
        return Arbok
    elseif b == 0x2E
        return Parasect
    elseif b == 0x2F
        return Psyduck
    elseif b == 0x30
        return Drowzee
    elseif b == 0x31
        return Golem
    elseif b == 0x33
        return Magmar
    elseif b == 0x35
        return Electabuzz
    elseif b == 0x36
        return Magneton
    elseif b == 0x37
        return Koffing
    elseif b == 0x39
        return Mankey
    elseif b == 0x3A
        return Seel
    elseif b == 0x3B
        return Diglett
    elseif b == 0x3C
        return Tauros
    elseif b == 0x40
        return Farfetch'd
    elseif b == 0x41
        return Venonat
    elseif b == 0x42
        return Dragonite
    elseif b == 0x46
        return Doduo
    elseif b == 0x47
        return Poliwag
    elseif b == 0x48
        return Jynx
    elseif b == 0x49
        return Moltres
    elseif b == 0x4A
        return Articuno
    elseif b == 0x4B
        return Zapdos
    elseif b == 0x4C
        return Ditto
    elseif b == 0x4D
        return Meowth
    elseif b == 0x4E
        return Krabby
    elseif b == 0x52
        return Vulpix
    elseif b == 0x53
        return Ninetales
    elseif b == 0x54
        return Pikachu
    elseif b == 0x55
        return Raichu
    elseif b == 0x58
        return Dratini
    elseif b == 0x59
        return Dragonair
    elseif b == 0x5A
        return Kabuto
    elseif b == 0x5B
        return Kabutops
    elseif b == 0x5C
        return Horsea
    elseif b == 0x5D
        return Seadra
    elseif b == 0x60
        return Sandshrew
    elseif b == 0x61
        return Sandslash
    elseif b == 0x62
        return Omanyte
    elseif b == 0x63
        return Omastar
    elseif b == 0x64
        return Jigglypuff
    elseif b == 0x65
        return Wigglytuff
    elseif b == 0x66
        return Eevee
    elseif b == 0x67
        return Flareon
    elseif b == 0x68
        return Jolteon
    elseif b == 0x69
        return Vaporeon
    elseif b == 0x6A
        return Machop
    elseif b == 0x6B
        return Zubat
    elseif b == 0x6C
        return Ekans
    elseif b == 0x6D
        return Paras
    elseif b == 0x6E
        return Poliwhirl
    elseif b == 0x6F
        return Poliwrath
    elseif b == 0x70
        return Weedle
    elseif b == 0x71
        return Kakuna
    elseif b == 0x72
        return Beedrill
    elseif b == 0x74
        return Dodrio
    elseif b == 0x75
        return Primeape
    elseif b == 0x76
        return Dugtrio
    elseif b == 0x77
        return Venomoth
    elseif b == 0x78
        return Dewgong
    elseif b == 0x7B
        return Caterpie
    elseif b == 0x7C
        return Metapod
    elseif b == 0x7D
        return Butterfree
    elseif b == 0x7E
        return Machamp
    elseif b == 0x80
        return Golduck
    elseif b == 0x81
        return Hypno
    elseif b == 0x82
        return Golbat
    elseif b == 0x83
        return Mewtwo
    elseif b == 0x84
        return Snorlax
    elseif b == 0x85
        return Magikarp
    elseif b == 0x88
        return Muk
    elseif b == 0x8A
        return Kingler
    elseif b == 0x8B
        return Cloyster
    elseif b == 0x8D
        return Electrode
    elseif b == 0x8E
        return Clefable
    elseif b == 0x8F
        return Weezing
    elseif b == 0x90
        return Persian
    elseif b == 0x91
        return Marowak
    elseif b == 0x93
        return Haunter
    elseif b == 0x94
        return Abra
    elseif b == 0x95
        return Alakazam
    elseif b == 0x96
        return Pidgeotto
    elseif b == 0x97
        return Pidgeot
    elseif b == 0x98
        return Starmie
    elseif b == 0x99
        return Bulbasaur
    elseif b == 0x9A
        return Venusaur
    elseif b == 0x9B
        return Tentacruel
    elseif b == 0x9D
        return Goldeen
    elseif b == 0x9E
        return Seaking
    elseif b == 0xA3
        return Ponyta
    elseif b == 0xA4
        return Rapidash
    elseif b == 0xA5
        return Rattata
    elseif b == 0xA6
        return Raticate
    elseif b == 0xA7
        return Nidorino
    elseif b == 0xA8
        return Nidorina
    elseif b == 0xA9
        return Geodude
    elseif b == 0xAA
        return Porygon
    elseif b == 0xAB
        return Aerodactyl
    elseif b == 0xAD
        return Magnemite
    elseif b == 0xB0
        return Charmander
    elseif b == 0xB1
        return Squirtle
    elseif b == 0xB2
        return Charmeleon
    elseif b == 0xB3
        return Wartortle
    elseif b == 0xB4
        return Charizard
    elseif b == 0xB9
        return Oddish
    elseif b == 0xBA
        return Gloom
    elseif b == 0xBB
        return Vileplume
    elseif b == 0xBC
        return Bellsprout
    elseif b == 0xBD
        return Weepinbell
    elseif b == 0xBE
        return Victreebel
    else
        return Mew
    end
end

@exportinstances Pkmn
export memory_to_species
