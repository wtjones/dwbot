require("dwbot_globals")
require("dwbot_emuhelpers")

function GetMenuX() return memory.readbytesigned(0x00D8) end
function GetMenuY() return memory.readbytesigned(0x00D9) end

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


function ChooseMenu(x, y)
	while GetMenuX() < x   do
		joypad.set(1, joyRight)
		emu.frameadvance()
	end
	
	while GetMenuX() > x   do
		joypad.set(1, joyLeft)
		emu.frameadvance()
	end
	
	while GetMenuY() < y   do
		joypad.set(1, joyDown)
		emu.frameadvance()
	end
	
	while GetMenuY() > y   do
		joypad.set(1, joyUp)
		emu.frameadvance()
	end
end