--require("dwbot_globals")
require("dwbot_emuhelpers")



function RentRoom()
	-- bring up menu
	print 'bring up menu'
	TapAndWait(joyA, 58)
	
	-- talk
	print ("talk")
	TapAndWait(joyA, 248)
	
	-- choose yes
	print ("choose yes")
	TapAndWait(joyA, 390)
	
	-- clear dialog
	print ("clear dialog")
	TapAndWait(joyA, 240)
	
	-- clear dialog
	print ("clear dialog")
	TapAndWait(joyA, 240)	
end