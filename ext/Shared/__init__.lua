local config = require('__shared/config')

Events:Subscribe('Player:UpdateInput', function(player, deltaTime)

	-- check if player is null, if it is: dont continue
	if player == nil then
		return
	end

	local entryInput = player.input

	-- check entryinput if its null, if it is: dont continue
	if entryInput == nil then
		return
	end

	-- check if player has jump(Spacebar) pressed, if not: dont continue
	if entryInput:GetLevel(EntryInputActionEnum.EIAJump) ~= 1.0 then
		return
	end

	-- check if our player has a soldier, if not dont continue
	if player.soldier == nil then
		return
	end

	-- if max height is -1, then do it anyway. if it is not then check if player is over the height
	if config.maxHeight ~= -1 and player.soldier.transform.trans.y > config.maxHeight then
		return
	end

	-- Get physics on this soldier
	local soldierPhysics = player.soldier.physicsEntityBase

	-- check if we have physics on this soldier, if not dont continue
	if soldierPhysics == nil then
		return
	end

	-- this is same as on both client and server

	-- calculate new velocity based on current soldier velocity
	-- alot of this is simple kinematics
	-- (1-(deltaTime*config.velocityDampingFactor)) is to dampen existing velocity, otherwise we would not lose speed. Newtons 1. law
	-- (config.acceleration*delta) is to slowly add the accelleration to our velocity
	local newVelocity = soldierPhysics.linearVelocity*(1-(deltaTime*config.velocityDampingFactor)) + (config.acceleration*deltaTime)

	-- clamp y velocity if we are going too fast upwards. This is also changable
	if config.maxYVelocity ~= -1 and newVelocity.y > config.maxYVelocity then
		newVelocity.y = config.maxYVelocity
	end

	-- Add velocity on the server as well, so other players can see it
	soldierPhysics.linearVelocity = newVelocity
end)