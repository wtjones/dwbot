require("dwbot_globals")
require("dwbot_emuhelpers")


function InBattle() return memory.readbyte(0x150A) ~= 255 end
--function GetPosX() return memory.readbyte(0x188E) end
--function GetPosY() return memory.readbyte(0x008F) end
function GetEnemyHP() return memory.readbytesigned(0x10E2) end




function Battle(behavior)
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
			behavior()
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



function FightToDeathBehavior()
	joypad.set(1,joyA)
	print "choose fight.."
	gui.text(4,4 ,"choose fight")
end