joyStill ={up=false,down=false,left=false,right=false,a=false,b=false}
joyLeft ={up=false,down=false,left=true,right=false,a=false,b=false}
joyRight ={up=false,down=false,left=false,right=true,a=false,b=false}
joyUp ={up=true,down=false,left=false,right=false,a=false,b=false}
joyA ={A=true}
joyB ={B=true}
joyDown ={up=false,down=true,left=false,right=false,a=false,b=false}



function SleepFrames(numFrames)
	numFrames = numFrames or 1 
	for i=1,numFrames,1 do emu.frameadvance() end
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

function GetPos()
	return {x = memory.readbyte(0x188E), y = memory.readbyte(0x008F)}
end
	
function InBattle() return memory.readbyte(0x150A) ~= 255 end
--function GetPosX() return memory.readbyte(0x188E) end
--function GetPosY() return memory.readbyte(0x008F) end
function GetEnemyHP() return memory.readbytesigned(0x10E2) end

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
			
			--gui.text(4,4,"Boo\nBoo\nBoooooooooooo: " .. tostring(GetPosX()));

			emu.frameadvance();
			if InBattle() then Battle() end
	--	end
	end
	joypad.set(1,joyStill)
end


-- main ------------------------------------------------------

joypad.set(1,joyStill)

while (true) do Grind({x=48, y=35}) end

