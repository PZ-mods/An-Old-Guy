negativeTraitsSet = {"HardOfHearing", "ShortSighted"}


local function mathFunctionToChanceObtainTraits(survivedDays)
    -- chance to get negative traits dependent on survived days
    -- f(x) = log2(x + 1) / 50, where is x equals to survived days
    -- I did function using natural logarithms because Lua doesn't have it o_0.

    -- There are few counted values:
    -- f(0) = 0
    -- f(25) = .0928771
    -- f(50) = .113449
    -- f(100) = .132877
    -- f(1000) = .199316
    local value = (math.log(survivedDays + 1) / math.log(2)) / 50
    return value
end

local function chanceToGetNegative()
    -- You gain a random negative trait from the set.
    if getPlayer():HasTrait("oldPerson") then

        local gameTime = GameTime.new()
        local survivedDays = gameTime:getDaysSurvived()
        if survivedDays % 7 == 0 then
            local getValueFromMathFunc = mathFunctionToChanceObtainTraits(survivedDays)
            local getRandomValue = ZombRandFloat(0.001, 0.21)

            if getValueFromMathFunc >= getRandomValue then
                local getRandomTraitIndex = ZombRandBetween(1, #negativeTraitsSet + 1)
                local randomTrait = negativeTraitsSet[getRandomTraitIndex]
                if randomTrait ~= nil then
                    getPlayer():getTraits():add(randomTrait)
                    table.remove(negativeTraitsSet, getRandomTraitIndex)
                end
            end
        end
    end
    
end


Events.EveryDays.Add(chanceToGetNegative)

