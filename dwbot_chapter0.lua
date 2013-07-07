-- Chapter 0 - Main menu and start game

function Chapter0()
	emu.softreset()
	--emu.speedmode("turbo")
	--SleepFrames(1000)
	print "tap"
	
	TapAndWait(joyStart, 100)
	TapAndWait(joyStart, 100)
	TapAndWait(joyStart, 100)
	
	TapAndWait(joyA,20)
	TapAndWait(joyA,60)
	
	ChooseMenu(1,0)
	SleepFrames(20)
	TapAndWait(joyA,20)

	ChooseMenu(3,4)
	SleepFrames(20)
	TapAndWait(joyA,20)

	
	ChooseMenu(8,4)
	SleepFrames(20)
	TapAndWait(joyA,20)
	
	ChooseMenu(9,5)
	SleepFrames(20)
	TapAndWait(joyA,20)
	
	ChooseMenu(0,0)
	SleepFrames(20)
	TapAndWait(joyA,20)


end