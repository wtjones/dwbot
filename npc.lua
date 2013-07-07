local Bit = require("bit")
local M = {}

M.NPC_ADDRESS = 0x51

function M.GetNpcs()
    local npcs = {}
    for i = 0, 19 do
        local offset = M.NPC_ADDRESS + (i * 3)
        local nx = Bit.band(memory.readbyte(offset), 0x1F)
        local ny = Bit.band(memory.readbyte(offset + 1), 0x1F)
        npcs[i] = {x = nx, y = ny}
    end
    return npcs
end

return M
