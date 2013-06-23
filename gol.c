#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#define w 30

int map[w][w];
int  ns[w][w];

double prob = 0.5;

void init(void) {
    srand(time(NULL)); 
    for (int i = 0; i < w; i++)
        for (int j = 0; j < w; j++)
            map[i][j] = (rand() % 100 < prob * 100);
}

void print_(void) {
    for (int i = 0; i < w; i++) {
        for (int j = 0; j < w; j++)
            printf("%c ", " X"[map[i][j]]);
        puts("");
    }
}

int neighbors (int x, int y) {
    int dir[8][2] = {{-1, -1}, {-1, 0}, {-1, 1},
                     { 0, -1},          { 0, 1},
                     { 1, -1}, { 1, 0}, { 1, 1}};

    int cnt = 0;
    for (int i = 0; i < 8; i++)
        cnt += (x+dir[i][0] >= 0 && y+dir[i][1] >= 0 &&
                x+dir[i][0] <  w && y+dir[i][1] <  w &&
                map[ x+dir[i][0] ][ y+dir[i][1] ]);
    return cnt;
}

void next_state(void) {
    for (int i = 0; i < w; i++)
        for (int j = 0; j < w; j++) {
            int nc = neighbors(i, j);
            ns[i][j] = map[i][j] ? (nc == 2 || nc == 3) : (nc == 3);
        }

    for (int i = 0; i < w; i++)
        for (int j = 0; j < w; j++)
            map[i][j] = ns[i][j];
}

void line (int n) {
    for (int i = 0; i < n; i++)
        putchar('=');
    puts("");
}

int main (void) {
    init();
    print_();
    while (1) {
        next_state();
        print_();
        line(60);
        usleep(100000);
    }
    return 0;
}
