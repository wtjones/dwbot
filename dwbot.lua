
require("dwbot_globals")
require("dwbot_emuhelpers")
require("dwbot_hero")
require("dwbot_shops")
require("dwbot_movement")
require("dwbot_menu")
require("dwbot_battle")
require("dwbot_chapter0")
	

-- main ------------------------------------------------------


sav = savestate.object(9)

savestate.save(sav)
savestate.persist(sav)
print("copy \".\\fcs\\Dragon Warrior (U) (PRG0).fc9\" .\fcs\dwbot_ch0.fc9")
os.execute("copy \".\\fcs\\Dragon Warrior (U) (PRG0).fc9\" .\\fcs\\dwbot_ch0.fc9")
--emu.frameadvance()
--savestate.load(sav)


Chapter0()

