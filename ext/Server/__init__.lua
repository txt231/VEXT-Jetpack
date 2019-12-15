
-- disable parachute on player respawn
Events:Subscribe('Player:Respawn', function(player)
    player:EnableInput(EntryInputActionEnum.EIAToggleParachute, false)
end)