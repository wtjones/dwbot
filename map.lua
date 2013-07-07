local bh = require("bit-helper")
local Osd = require("display")
local M = {}


M.data = {
    [8] = {
        ["name"] = "breconnary",
        ["location"] = 0x726,
        ["width"] = 30,
        ["height"] = 30,
        ["numNpcs"] = 0,
        ["collisionMap"] = {}
    }
}





for key, map in pairs(M.data) do
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
    M.data[key].collisionMap = collisionMap
end


function M.GetMapId()
    return memory.readbyte(0x45)
end


function M.DrawCollisionMap()
    local cmap = M.data[M.GetMapId()].collisionMap
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



return M