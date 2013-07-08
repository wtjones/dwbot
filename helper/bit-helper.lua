local M = {}

function M.LowNibble(value)
    local highValue = math.floor(value / 16)
    highValue = highValue * 16
    local lowValue = value - highValue
    return lowValue
end

function M.HighNibble(value)
    local highValue = math.floor(value / 16)
    return highValue
end

return M