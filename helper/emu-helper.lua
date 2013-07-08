M = {}

function M.SleepFrames(numFrames)
    numFrames = numFrames or 1
    --joy = joypad.get(1)
    for i=1,numFrames,1 do
        --joypad.set(1,joy)
        emu.frameadvance()
    end
end

return M