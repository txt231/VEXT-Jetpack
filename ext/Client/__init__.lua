local config = require('__shared/config')

-- add an event that gets called on UpdateInput
Events:Subscribe('Player:UpdateInput', function(player, deltaTime)

	if player == nil then
		return
	end

	local entryInput = player.input

	if entryInput == nil then
		return
	end

	if entryInput:GetLevel(EntryInputActionEnum.EIAJump) ~= 1.0 then
		return
	end

	-- check if soldier is valid, if not dont continue
	if player.soldier == nil then
		return
	end

	if config.maxHeight ~= -1 and player.soldier.transform.trans.y > config.maxHeight then
		return
	end

	-- check if soldier has a physics entity, if not dont continue
	local soldierPhysics = player.soldier.physicsEntityBase
	if soldierPhysics == nil then
		return
	end

	-- calculate new velocity based on current soldier velocity
	-- alot of this is simple kinematics
	-- (1-delta) is to dampen existing velocity, otherwise we would not lose speed. Newtons 1. law
	-- (config.acceleration*delta) is to slowly add the accelleration to our velocity
	local newVelocity = soldierPhysics.linearVelocity*(1-(deltaTime*config.velocityDampingFactor)) + (config.acceleration*deltaTime)

	-- clamp y velocity if we are going too fast upwards. This is also changable
	if newVelocity.y > config.maxYVelocity then
		newVelocity.y = config.maxYVelocity
	end

	-- client prediction, sets velocity on client before on server. If this isnt here, then you would start rubberbanding
	soldierPhysics.linearVelocity = newVelocity
end)

