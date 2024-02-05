@enum BattleType begin
    NoBattle
    TrainerBattle
    WildBattle
    SafariZoneBattle
end

function BattleType(raw::UInt8)::BattleType
    if raw == 0
        NoBattle
    elseif raw == 1
        WildBattle
    elseif raw == 2
        TrainerBattle
    else
        SafariZoneBattle
    end
end

@exportinstances BattleType
export BattleType
