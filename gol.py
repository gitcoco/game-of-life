#!/usr/bin/env python

import random
import time

class gol:
    def __init__(self):
        self._w = 30          # map width
        self._prob = 0.5      # probability
        self._map = []
        for i in range(self._w):
            for j in range(self._w):
                self._map.append(random.randint(0, 100) < self._prob*100)

    def get(self, x, y):
        return self._map[x*self._w + y]

    def print_(self):
        for i in range(self._w):
            for j in range(self._w):
                print ' X'[self.get(i, j)],
            print ""

    def neighbors(self, x, y):
        dirs = [(-1, -1), (0, -1), (1, -1),
                (-1,  0),          (1,  0),
                (-1,  1), (0,  1), (1,  1)]

        cnt = 0
        for d in dirs:
            cnt += (x+d[0] >= 0 and y+d[1] >= 0 and\
                    x+d[0] < self._w and y+d[1] < self._w and\
                    self.get(x+d[0], y+d[1]))

        return cnt

    def next_state(self):
        ns = []
        for i in range(self._w):
            for j in range(self._w):
                nc = self.neighbors(i, j)
                ns.append((nc in [2, 3]) if self.get(i, j) else (nc == 3))

        self._map = ns


game = gol()
game.print_()

try:
    while 1:
        game.next_state()
        game.print_()
        print "="*60
        time.sleep(0.1)

except KeyboardInterrupt:
    print "bye"

