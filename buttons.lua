local M = {}

M.STILL ={up=false,down=false,left=false,right=false,a=false,b=false}
M.LEFT ={up=false,down=false,left=true,right=false,a=false,b=false}
M.RIGHT ={up=false,down=false,left=false,right=true,a=false,b=false}
M.UP ={up=true,down=false,left=false,right=false,a=false,b=false}
M.A ={A=true}
M.B ={B=true}
M.START = {start=true}
M.DOWN ={up=false,down=true,left=false,right=false,a=false,b=false}


function M.TapAndWait(joy, numFrames)
    joypad.set(1,joy)
    SleepFrames(1)
    joypad.set(1,joyStill)
    SleepFrames(numFrames - 1)
end

return M
