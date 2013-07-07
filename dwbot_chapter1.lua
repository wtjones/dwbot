
beh = FightToDeathBehavior
joypad.set(1,joyStill)
print ("bb: " .. bb())
while (GetHeroLevel() < 3) do
	while (GetHeroHP()/GetHeroMaxHP() > .5) do 
		print ("grinding...")
		gui.text(4,40,"health: " .. tostring(GetHeroHP()/GetHeroMaxHP()))
		--Grind({x=48, y=35}) 
		Travel({{"n",2},{"w",2}}, beh)
		Travel({{"e",2},{"s",2}}, beh)
		
	end
	MoveSouth()
	
	--MoveDown()
	SleepFrames(120)
	Travel({{"e",8},{"s",6}},beh)
	Face("e")
	RentRoom()
	Travel({{"n",6},{"w",8}})
	MoveWest()
	SleepFrames(120)
	MoveNorth()
end