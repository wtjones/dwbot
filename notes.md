## Notes on observed game behavior

### Combat

right before a command screen, 6507 goes from 1 to 128 to 0

when needing to clear a prompt, 0094 and 0095 count like crazy

to convert when using save state hacking guide, add 0xFAC (4012d)

150A is 255 when not in battle

10E0 - enemy type
	0 blue slime
	1 red slime
	2 drakee
	3 ghost


max hp is 10CA and maybe 00CA 08CA 18CA

Direction
	0 up
	1 left
	2 down
	3 right


### Maps

wall	4
sand	1
pave	6
tree	8
grass	0
water	2
door    11
bridge  14

Brecconary
w: 30, h: 30
726 to

#### Doors

Brec: Can change 600C from 00 to 15 and 600D to 06 and it lets you walk through door.
Castle: Can change 600C from 00 to 04 and 600D to 0D and it lets you walk through door.


### Screen

Get player coordinate X in pixels: memory.readbyte(0x5) + (memory.readbyte(0x6) * 256)
For Y, low byte is probably 0x7.Not sure on high byte but could be 0x3FF, 0x7F9, or 0x7FA-D
Actually it is 0x92 and 0x93



