require("dwbot_globals")
require("dwbot_emuhelpers")
local bit = require("bit")
local Osd = require("display")
--local Grid = require("Jumper.jumper.grid")
--local Pathfinder = require ("Jumper.jumper.pathfinder")
local map = require("map")
local Npc = require("npc")
local PrintHelper = require("print-helper")
local Hero = require("hero")
local Path = require("path")
local Buttons = require("buttons")

--local grid = Grid(map.data[8].collisionMap)
--local finder = Pathfinder(grid, 'JPS', 0)
--print_r(collisionMap)

local heroX = 4--rom.readbyte(0x3A)
local heroY = 14--rom.readbyte(0x3B)


local n = Npc.GetNpcs()

--PrintHelper.PrintArray(n)
local tileSize = 16
local tileHeight = 16
local screenOffset = {x = 8, y = 8}
local playerTile = {x = 128, y = 112}
while 1==1 do
    local npcX = bit.band(memory.readbyte(0x51), 0x1F)
    local npcY = bit.band(memory.readbyte(0x52), 0x1F)
    --print(npcX * tileSize .. " " .. npcY * tileSize )
    gui.drawtext(50, 60, npcX * tileSize .. " " .. npcY * tileSize )

    gui.box(playerTile.x, playerTile.y , playerTile.x + tileSize - 1, playerTile.y + tileSize - 1)

    -- tile precision
    local sx = playerTile.x - (memory.readbyte(0x3A) * tileSize)
    local sy = playerTile.y - ((memory.readbyte(0x3B) - 4) * tileSize)
    gui.box(sx, sy, sx + tileSize, sy + tileSize)

    --print(memory.readbyte(0x5) + (memory.readbyte(0x6) * 256))
    local px = memory.readbyte(0x5) + (memory.readbyte(0x6) * 256)
    local py = memory.readbyte(0x92) + (memory.readbyte(0x93) * 256)

    -- local sx = px - (0 * tileSize)
    -- local sy = py - (0 * tileSize)
    local sx = playerTile.x - px
    local sy = playerTile.y - py
    gui.drawtext(50, 50, px .. ' ' .. py)
    gui.box(sx, sy, sx + tileSize, sy + tileSize)

    --local sx = playerTile.x - ((memory.readbyte(0x3A) - npcX ) * tileSize)
    --local sy = playerTile.y - ((memory.readbyte(0x3B) - npcY) * tileSize)
    --gui.box(sx, sy, sx + tileSize, sy + tileSize)

    map.DrawCollisionMap()

    Osd.DrawTileBox({x = npcX, y = npcY})
    Osd.DrawNpcs()

    -- local heroPos = Hero.GetTilePos()
    local targetPos = {x = 10, y = 10}
    -- Osd.DrawTileBox(targetPos, "blue")
    -- local path = finder:getPath(heroPos.x,heroPos.y, targetPos.x, targetPos.y)

    -- if path then
    --   gui.drawtext(50, 70, ('Path found! Length: %.2f'):format(path:getLength()))
    --     for node, count in path:nodes() do
    --       --print(('Step: %d - x: %d - y: %d'):format(count, node:getX(), node:getY()))
    --       Osd.DrawTileBox({x = node:getX(), y = node:getY()})
    --     end
    -- end
    Osd.DrawTileBox(targetPos, "blue")
    Path.DrawPath(Path.GetPath(targetPos))
gui.drawtext(20, 20, ('hero: %d, %d'):format(Hero.GetPos().x, Hero.GetPos().y))

    --local node = n[1]
    --print node:getX()

    --for node, count in path:nodes() do
        --print(('Step: %d - x: %d - y: %d'):format(count, node:getX(), node:getY()))
    --       Osd.DrawTileBox({x = node:getX(), y = node:getY()})
    --end

    --PrintHelper.PrintArray(path:nodes()[1])
    local nodePos = nil
    while Hero.GetTilePos().x ~= targetPos.x or Hero.GetTilePos().y ~= targetPos.y do
        Osd.DrawTileBox(targetPos, "blue")
        gui.drawtext(20, 10, 'pathing...')

        gui.drawtext(20, 20, ('hero: %d, %d'):format(Hero.GetPos().x, Hero.GetPos().y))

        if Hero.IsTileAligned() then
            print("tile aligned")
            local path = Path.GetPath(targetPos)
            if path then
                Path.DrawPath(Path.GetPath(targetPos))

                local i = 0
                nodePos = {}
                for node, count in path:nodes() do
                    print(('Step: %d - x: %d - y: %d'):format(count, node:getX(), node:getY()))
                    nodePos.x = node:getX()
                    nodePos.y = node:getY()
                    i = i + 1
                    if i == 2 then break end
                end
                PrintHelper.PrintArray(nodePos)
            end
        end

        if nodePos then
                if Hero.GetNextTilePos().x < nodePos.x then
                     gui.drawtext(20, 40, 'keydown')
                    joypad.set(1, Buttons.RIGHT)
                elseif Hero.GetNextTilePos().x > nodePos.x then
                    joypad.set(1, Buttons.LEFT)
                    gui.drawtext(20, 40, 'keydown')
                elseif Hero.GetNextTilePos().y < nodePos.y then
                    joypad.set(1, Buttons.DOWN)
                elseif Hero.GetNextTilePos().y > nodePos.y then
                    joypad.set(1, Buttons.UP)
                end
        end
    --     local nodes = path:nodes()
        --PrintHelper.PrintArray(nodePos)
    --     node = nodes[0]
        map.DrawCollisionMap()
        Osd.DrawTileBox(targetPos, "blue")
        emu.frameadvance()
        joypad.set(1, Buttons.STILL)
     end


     emu.frameadvance()
end