local M = {}


function M.GetHP() return memory.readbytesigned(0x10C5) end
function M.GetMaxHP() return memory.readbytesigned(0x10CA) end
function M.GetLevel() return memory.readbytesigned(0x10C7) end

-- Are we moving between tiles?
function M.IsTileAligned()
    local pos = M.GetPos()
    return pos.x % 16 == 0 and pos.y % 16 == 0
end

-- Get hero's current tile coordinates
function M.GetTilePos()
    return {x = memory.readbyte(0x3A), y = memory.readbyte(0x3B)}
end


function M.GetNextTilePos()
    return {x = memory.readbyte(0x008E), y = memory.readbyte(0x008F)}
end

-- 16 bit relative to map.
function M.GetPos()
    local px = memory.readbyte(0x5) + (memory.readbyte(0x6) * 256)
    local py = memory.readbyte(0x92) + (memory.readbyte(0x93) * 256)
    return {x = px, y = py}
end



function GetDirection()
    dir = memory.readbytesigned(0x602F)
    if dir == 0 then return "n"
    elseif dir == 1 then return "e"
    elseif dir == 2 then return "s"
    else return "w"
    end
end


return M