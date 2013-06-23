# awk -f gol.awk

BEGIN {
    w = 30
    prob = 0.5
    init()
    print_()

    while (1) {
        next_state()
        print_()
        for (i = 0; i < 1000000; i++)      # sleep
    }
}

function init() {
    srand
    for (i = 0; i < w; i++)
        for (j = 0; j < w; j++)
            map[i, j] = (rand < prob) ? 1 : 0;
}


function print_() {
    for (i = 0; i < w; i++) {
        for (j = 0; j < w; j++) {
            # awk's string index start from 1
            printf substr(" X", map[i, j]+1, 1) " " 
        }
        print
    }

    for (i = 0; i < 60; i++)
        printf "="
    print
}


function neighbors(x, y) {
    dirs[0, 0] = -1; dirs[0, 1] = -1
    dirs[1, 0] =  0; dirs[1, 1] = -1
    dirs[2, 0] =  1; dirs[2, 1] = -1
    dirs[3, 0] = -1; dirs[3, 1] =  0
    dirs[4, 0] =  1; dirs[4, 1] =  0
    dirs[5, 0] = -1; dirs[5, 1] =  1
    dirs[6, 0] =  0; dirs[6, 1] =  1
    dirs[7, 0] =  1; dirs[7, 1] =  1

    # in awk, all variables are global, except function parameters
    cnt = 0
    for (_i = 0; _i < 8; _i++)
        cnt += (x+dirs[_i, 0] >= 0 && y+dirs[_i, 1] >= 0 &&
                x+dirs[_i, 0] <  w && y+dirs[_i, 1] <  w &&
                map[ x+dirs[_i, 0], y+dirs[_i, 1] ])

    return cnt
}


function next_state() {
    for (i = 0; i < w; i++) {
        for (j = 0; j < w; j++) {
            nc = neighbors(i, j)
            ns[i, j] = (map[i, j] ? (nc ~ /[23]/) : (nc == 3))
        }
    }

    for (i = 0; i < w; i++)
        for (j = 0; j < w; j++)
            map[i, j] = ns[i, j]
}
