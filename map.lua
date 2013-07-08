local bh = require("helper.bit-helper")
local Osd = require("display")

local PrintHelper = require("helper.print-helper")
local Npc = require("npc")
local TableHelper = require("helper.table-helper")
Map = {}

function Map:new()
    local object = {data = {
                    [8] = {
                        ["name"] = "breconnary",
                        ["location"] = 0x726,
                        ["width"] = 30,
                        ["height"] = 30,
                        ["numNpcs"] = 20,
                        ["collisionMap"] = {},
                        ["currentCollisionMap"] = {}
                    }
                }
            }
    self.__index = self
    setmetatable(object, self)
    object:LoadCollisionMap()
    return object
end


function Map:LoadCollisionMap()
    for key, map in pairs(self.data) do
        local collisionMap = {}
        for y = 0, map["height"] - 1 do
            local row = {}
            for x = 0, map["width"] - 1 do
                local offset = (y * map.height / 2) + math.floor(x / 2)
                local byte = rom.readbyte(map.location + offset)
                local tile;
                if x % 2 == 0 then
                    tile = bh.HighNibble(byte)
                else
                    tile = bh.LowNibble(byte)
                end
                if tile == 1 or tile == 0 or tile == 8 or tile == 6 or tile == 11 or tile == 14 then
                    -- passable
                    row[x] = 0
                else
                    row[x] = 1
                end
                --print(x .." is: ".. math.floor(x / 2) .. " and "..x % 2 .. " byte: " .. byte .." tile: " .. tile)
            end
            --print_r(row)
            collisionMap[y] = row
        end
        self.data[key].collisionMap = collisionMap
    end
end

function Map:GetMap()
    return self.data[self.GetMapId()]
end

function Map:GetMapId()
    return memory.readbyte(0x45)
end

function Map:GetCollisionMap()
    return self.data[self.GetMapId()].currentCollisionMap
end

function Map:UpdateCollisionMap()
    local npcs = Npc.GetNpcs()
    local cmap = TableHelper.DeepCopy(self.data[self.GetMapId()].collisionMap)

    for key, npc in pairs(npcs) do
        local row = cmap[npc.y]
        row[npc.x] = 1
    end
    print("update collisions")
    self.data[self.GetMapId()].currentCollisionMap = cmap
end

function Map:DrawCollisionMap()
    local cmap = self.data[self.GetMapId()].currentCollisionMap
    for y = 0, 29 do
        local row = cmap[y]
        for x = 0, 29 do
            if row[x] == 0 then
                Osd.DrawTileBox({x = x, y = y}, "orange", .3)
            else
                Osd.DrawTileBox({x = x, y = y}, "green", .3)
            end
        end
    end
end


return Map