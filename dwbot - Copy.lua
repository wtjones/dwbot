joyStill ={up=false,down=false,left=false,right=false,a=false,b=false}
joyLeft ={up=false,down=false,left=true,right=false,a=false,b=false}
joyRight ={up=false,down=false,left=false,right=true,a=false,b=false}
joyUp ={up=true,down=false,left=false,right=false,a=false,b=false}
joyA ={A=true}
joyB ={B=true}
joyDown ={up=false,down=true,left=false,right=false,a=false,b=false}


function GetPos()
	return {x = memory.readbyte(0x188E), y = memory.readbyte(0x008F)}
end
	

function GetPosPreMove()
	return {x = memory.readbyte(0x103A), y = memory.readbyte(0x103B)}
end
function InBattle() return memory.readbyte(0x150A) ~= 255 end
--function GetPosX() return memory.readbyte(0x188E) end
--function GetPosY() return memory.readbyte(0x008F) end
function GetEnemyHP() return memory.readbytesigned(0x10E2) end
function GetHeroHP() return memory.readbytesigned(0x10C5) end
function GetHeroMaxHP() return memory.readbytesigned(0x10CA) end
function GetDirection()
	dir = memory.readbytesigned(0x602F)
	if dir == 0 then return "n"
	elseif dir == 1 then return "e"
	elseif dir == 2 then return "s"
	else return "w"
	end
end

function SleepFrames(numFrames)
	numFrames = numFrames or 1 
	for i=1,numFrames,1 do emu.frameadvance() end
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

function MoveDown()
	local startPos = GetPos()

	
	while GetPos().y == startPos.y do		
		joypad.set(1,joyDown)
		emu.frameadvance()
	end
end


function MoveUp()
	local startPos = GetPos()

	--while GetPos().y ~= GetPosPreMove().y do
	--	print "MoveDown error: already moving"
	--	emu.frameadvance()
	--end
	
	while GetPos().y == startPos.y do		
		joypad.set(1,joyUp)
		emu.frameadvance()
	end
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


function Travel(path)
	local startPos = GetPos()

	while GetPos().x ~= GetPosPreMove().x do
		print "Travel error: already moving"
		emu.frameadvance()
	end
	
	for i, move in ipairs(path) do
		--if move[1] == "w" then MoveLeft()
		if move[1] == "e" then
		print "going right"
			startPos = GetPos()
			while GetPos().x ~= startPos.x + move[2] do
				MoveRight()
			end
		end
		if move[1] == "s" then
			startPos = GetPos()
			while GetPos().y ~= startPos.y + move[2] do
				MoveDown()
			end
		end
		if move[1] == "w" then
			startPos = GetPos()
			while GetPos().x ~= startPos.x - move[2] do
				MoveLeft()
			end
		end
		if move[1] == "n" then
			print "going up"
			startPos = GetPos()
			while GetPos().y ~= startPos.y - move[2] do
				MoveUp()
			end
		end
	end
	joypad.set(1,joyStill)
			
end


function WaitForMenu() 
	print "WaitForMenu()"
	joypad.set(1,joyA)
	while memory.readbyte(0x6507) ~= 128 do 
		emu.frameadvance()
		if joypad.get(1).A == true then 
			joypad.set(1,joyStill) 
		else joypad.set(1,joyA)
		end
		if (InBattle() == false) then
			print 'battle must have ended' 
			return false
		end
	end
	while memory.readbyte(0x6507) ~= 0 do emu.frameadvance() end
	joypad.set(1,joyStill)
	return true
end


function Battle()
	gui.text(4,4 ,"battle start")
	print "battle start"
	--enemyDead = false
	joypad.set(1,joyStill)
	--WaitForMenu()
	SleepFrames()
	--for i=1,120,1 do	emu.frameadvance(); end
	--if (WaitForMenu()) then
		
		while  true do
			if (WaitForMenu() == false) then break end
			joypad.set(1,joyA)
			print "choose fight.."
			gui.text(4,4 ,"choose fight")
			SleepFrames(2);
			joypad.set(1,joyStill)
			SleepFrames(160)
			
			if GetEnemyHP() <= 0 then 
				--enemyDead = true
				print "enemy dead.." 
				break
			--else WaitForMenu()
			end
			
		end
	--else
	
		while memory.readbyte(0x150A) ~= 255 do
			joypad.set(1,joyA)
			gui.text(4,4 ,"waiting for battle to end")
			emu.frameadvance()
			joypad.set(1,joyStill)
			emu.frameadvance()
		end
	--end
	joypad.set(1,joyStill)

end

function Grind(endPos)
	gui.text(4,4 ,"grinding")
	print "grinding"
	local startPos = GetPos()

	--while (true) do
		while GetPos().y  ~= endPos.y do
			if GetPos().y  > endPos.y then
				joypad.set(1,joyUp)
			else
				joypad.set(1,joyDown)
			end
			--gui.text(4,4,"Boo\nBoo\nBoooooooooooo: " .. tostring(GetPosX()));

			emu.frameadvance();
			if InBattle() then Battle() end
		end

		while GetPos().y  ~= startPos.y do
			
			if GetPos().y  > startPos.y then
				joypad.set(1,joyUp)
			else
				joypad.set(1,joyDown)
			end
			
			emu.frameadvance();
			if InBattle() then Battle() end
	--	end
	end
	joypad.set(1,joyStill)
end

function RentRoom()
	-- bring up menu
	print 'bring up menu'
	joypad.set(1,joyA)
	SleepFrames(1)
	joypad.set(1,joyStill)
	SleepFrames(60)
	
	-- talk
	print ("talk")
	joypad.set(1,joyA)
	SleepFrames(1)
	joypad.set(1,joyStill)
	SleepFrames(250)
	
	-- choose yes
	print ("choose yes")
	joypad.set(1,joyA)
	SleepFrames(1)
	joypad.set(1,joyStill)
	SleepFrames(400)
	
	-- clear dialog
	print ("clear dialog")
	joypad.set(1,joyA)
	SleepFrames(1)
	joypad.set(1,joyStill)
	SleepFrames(240)
	
	-- clear dialog
	print ("clear dialog")
	joypad.set(1,joyA)
	SleepFrames(1)
	joypad.set(1,joyStill)
	SleepFrames(240)
	
end
	

-- main ------------------------------------------------------

joypad.set(1,joyStill)

while (GetHeroHP()/GetHeroMaxHP() > .4) do 

	gui.text(4,40,"health: " .. tostring(GetHeroHP()/GetHeroMaxHP()))
	Grind({x=48, y=35}) 
end
MoveDown()
SleepFrames(120)
Travel({{"e",8},{"s",6}})
Face("e")
RentRoom()
Travel({{"n",6},{"w",9}})
SleepFrames(120)
MoveUp()

