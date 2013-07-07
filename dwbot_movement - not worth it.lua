require("dwbot_globals")
require("dwbot_emuhelpers")




function GetPos()
	--return {x = memory.readbyte(0x188E), y = memory.readbyte(0x008F)}
	return {x = memory.readbyte(0x103A), y = memory.readbyte(0x103B)}
end
	

function GetNextPos()
	--return {x = memory.readbyte(0x103A), y = memory.readbyte(0x103B)}
	return {x = memory.readbyte(0x188E), y = memory.readbyte(0x008F)}
end

function GetDirection()
	dir = memory.readbytesigned(0x602F)
	if dir == 0 then return "n"
	elseif dir == 1 then return "e"
	elseif dir == 2 then return "s"
	else return "w"
	end
end

function Face(direction)
	--print (GetDirection().." " .. direction)
	while GetDirection() ~= direction do		
		if direction == "e" then
			joypad.set(1,joyRight)
		elseif direction == "w" then
			joypad.set(1,joyLeft)
		elseif direction == "n" then
			joypad.set(1,joyUp)
		elseif direction == "s" then
			joypad.set(1,joyDown)
		end
		emu.frameadvance()
	--print (GetDirection().." " ..direction)
	end
	joypad.set(1,joyStill)
end



function Travel(path, battleBehavior)
	-- after this function exits, it takes 17 frames to hero to finish moving to dest cell
	--print("behav: " .. battleBehavior)
	local startPos = GetPos()

	local movedSpaces = 0
	
	while GetPos().y ~= GetNextPos().y do
		print ("Travel error: already moving")
		emu.frameadvance()
	end
	
	
	for i, move in ipairs(path) do
		movedSpaces = 0
		while movedSpaces < move[2] do
		
			
			--startPos = GetPos()
			if move[1] == "e" then
			print "going right"
				--startPos = GetPos()
				while GetNextPos().x ~= startPos.x + move[2] do
				print ("waiting for x: " .. startPos.x + move[2])
					joypad.set(1,joyRight)
					emu.frameadvance()
					if InBattle() then Battle(battleBehavior) end
				end
			end
			
			if move[1] == "s" then
				print "going down"
				
				while GetNextPos().y ~= startPos.y + move[2] do
					print ("waiting for y: " .. startPos.y + move[2])
					joypad.set(1,joyDown)
					emu.frameadvance()
					if InBattle() then Battle(battleBehavior) end
				end
			end
			if move[1] == "w" then
				--startPos = GetPos()
				while GetNextPos().x == GetPos().x do
				--print ("waiting for x: " .. startPos.x - move[2])
					joypad.set(1,joyLeft)
					emu.frameadvance()
					if InBattle() then Battle(battleBehavior) end
				end
			end
			if move[1] == "n" then
				print "going up"
				--startPos = GetPos()
				while GetNextPos().y ~= startPos.y - move[2] do
					print ("waiting for y: " .. startPos.y - move[2])
					joypad.set(1,joyUp)
					emu.frameadvance()
					if InBattle() then Battle(battleBehavior) end
				end
			end
			SleepFrames(1)
			if InBattle() then Battle(battleBehavior) end
		end
	end
	joypad.set(1,joyStill)
	--SleepFrames(17)
			
end




--[[
function MoveDown()
	local startPos = GetPos()

	
	while GetPos().y == startPos.y do		
		joypad.set(1,joyDown)
		emu.frameadvance()
		if InBattle() then return true end
	end
end


function MoveUp()
print "moveup()"
	local startPos = GetPos()

	joypad.set(1,joyUp)
	while GetPos().y == GetPosPreMove().y do
		print "moveup() - wait for pre move"
		joypad.set(1,joyUp)
		emu.frameadvance()
	end
	--joypad.set(1,joyStill)
	print "sleep"
	SleepFrames(16)
	if InBattle() then return true end
	
	-- while GetPos().y == startPos.y do		
		-- joypad.set(1,joyUp)
		-- emu.frameadvance()
		-- if InBattle() then return true end
	-- end
 end


function MoveLeft()
	local startPos = GetPos()

	--while GetPos().x ~= GetPosPreMove().x do
		--print "MoveLeft error: already moving"
	--	emu.frameadvance()
	--end
	
	while GetPos().x == startPos.x do		
		joypad.set(1,joyLeft)
		emu.frameadvance()
	end
end


function MoveRight()
	local startPos = GetPos()

	--while GetPos().x ~= GetPosPreMove().x do
	--	print "MoveRight error: already moving"
--		emu.frameadvance()
	--end
	
	while GetPos().x == startPos.x do		
		joypad.set(1,joyRight)
		emu.frameadvance()
	end
end
--]]