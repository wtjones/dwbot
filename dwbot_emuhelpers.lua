
require("dwbot_globals")


function SleepFrames(numFrames)
	numFrames = numFrames or 1 
	--joy = joypad.get(1)
	for i=1,numFrames,1 do 
		--joypad.set(1,joy)
		emu.frameadvance() 
	end
end

function TapAndWait(joy, numFrames)
	joypad.set(1,joy)
	SleepFrames(1)
	joypad.set(1,joyStill)
	SleepFrames(numFrames - 1)
end