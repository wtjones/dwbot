local Hero = require("hero")
local Npc = require("npc")
local M = {}

M.TILE_SIZE = 16
M.HERO_SCREEN_POS = {X = 128, Y = 112}  -- top left pixel of player sprite

function M.GetTileScreenPos(tilePos)
    local heroPos = Hero.GetTilePos()
    local sx = M.HERO_SCREEN_POS.X - ((heroPos.x - tilePos.x )* M.TILE_SIZE)
    local sy = M.HERO_SCREEN_POS.Y - ((heroPos.y - tilePos.y) * M.TILE_SIZE)
    return {x = sx, y = sy}
end

function M.DrawTileBox(tilePos, color, opacity)
    color = color or {255,3,3,3}
    opacity = opacity or .7
    --local sx = M.HERO_SCREEN_POS.X - ((memory.readbyte(0x3A) - tilePos.x ) * M.TILE_SIZE)
    --local sy = M.HERO_SCREEN_POS.Y - ((memory.readbyte(0x3B) - tilePos.y) * M.TILE_SIZE)
    local t = M.GetTileScreenPos(tilePos)

    gui.opacity(.5)
    gui.box(t.x, t.y, t.x + M.TILE_SIZE - 1, t.y + M.TILE_SIZE - 1, color)
    gui.opacity(1)
end


function M.DrawNpcs()
    local npcs = Npc.GetNpcs()
    for key, npc in pairs(npcs) do
        M.DrawTileBox(npc)
    end
end

return M