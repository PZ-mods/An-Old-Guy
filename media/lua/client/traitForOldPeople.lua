local function oldTrait()

    TraitFactory.addTrait("oldPerson", "An Old Guy", -18, "You don't have any power to withstand this nightmare", false, false);

end

local function OnNewGame(player, square)
    if player:HasTrait("oldPerson") then
        player:getTraits():add("Out of Shape")
        player:getTraits():add("SundayDriver")
    end
end




Events.OnNewGame.Add(OnNewGame);
Events.OnGameBoot.Add(oldTrait);