#!/usr/bin/env lua

function init()
    math.randomseed( os.time() )
    -- in Lua, indecs start at 1, not 0
    for i = 1, w do
        map[i] = {}
        for j = 1, w do
            map[i][j] = (math.random() < prob and 1) or 0 
        end
    end
end


function print_()
    for i = 1, w do
        for j = 1, w do
            io.write (((map[i][j] == 1 and 'X') or ' ') .. ' ')
        end
        print ()
    end
end


function neighbors(x, y)
    local dirs = { {-1, -1}, {0, -1}, {1, -1},
                   {-1,  0},          {1,  0},
                   {-1,  1}, {0,  1}, {1,  1} }
    local cnt = 0
    for i = 1, 8 do
        if (x+dirs[i][1] > 0 and y+dirs[i][2] > 0 and
            x+dirs[i][1] <=  w and y+dirs[i][2] <=  w and 
            map[ x+dirs[i][1] ][ y+dirs[i][2]] == 1) then
                cnt = cnt + 1
        end
    end
    return cnt
end


function next_state()
    local ns = {}
    for i = 1, w do
        ns[i] = {}
        for j = 1, w do
            local nc = neighbors(i, j)
            ns[i][j] = (((map[i][j] == 1 and (nc == 2 or nc == 3)) or
                         (nc == 3)) and 1) or 0
        end
    end

    for i = 1, w do
        for j = 1, w do
            map[i][j] = ns[i][j]
        end
    end
end

w = 30
prob = 0.5
map = {}
init()
print_()

while 1 do
    next_state()
    print_()
    local time = os.clock()
    while os.clock()-time < 0.1 do end
end
