local Grid = require("lib.Jumper.jumper.grid")
local Pathfinder = require ("lib.Jumper.jumper.pathfinder")
local Map = require("map")
local Osd = require("display")
local Hero = require("hero")

local grid = Grid(Map.data[8].collisionMap)
local finder = Pathfinder(grid, 'JPS', 0)

local M = {}

-- Calculate a path relative to hero
function M.GetPath(targetPos)
    local heroPos = Hero.GetTilePos()
    local path = finder:getPath(heroPos.x,heroPos.y, targetPos.x, targetPos.y)
    return path
end



function M.DrawPath(path)
    --local heroPos = Hero.GetTilePos()

    --Osd.DrawTileBox(targetPos, "blue")

    if path then
        --print (table.getn(path))
        --local lastNode = path[table.getn(path) - 1]
        --local targetPos = {x = lastNode.x, y = lastNode.y}
        --Osd.DrawTileBox(targetPos, "blue")

      gui.drawtext(50, 70, ('Path found! Length: %.2f'):format(path:getLength()))
        for node, count in path:nodes() do
          --print(('Step: %d - x: %d - y: %d'):format(count, node:getX(), node:getY()))
          Osd.DrawTileBox({x = node:getX(), y = node:getY()})
        end
    end
end

return M