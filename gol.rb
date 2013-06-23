#!/usr/bin/env ruby

class Gol
    def initialize(w=30, prob=0.5)
        @w = w
        @prob = prob
        @map = []
        (0...@w).each do |i|
            (0...@w).each do |j|
                @map << (rand(100) < @prob*100 ? 1 : 0)
            end
        end
    end

    def [](x, y)
        @map[x*@w + y] == 1 ? 1 : 0
    end

    def print_
        (0...@w).each do |i|
            (0...@w).each do |j|
                print " X"[self[i, j]].chr + " "
            end
            puts
        end
    end

    def neighbors(x, y)
        dirs = [[-1, -1], [0, -1], [1, -1],
                [-1,  0],          [1,  0],
                [-1,  1], [0,  1], [1,  1]]

        cnt = 0
        dirs.each do |d|
            cnt += ((x+d[0] >= 0 and y+d[1] >= 0 and\
                     x+d[0] < @w and y+d[1] < @w and\
                     self[x+d[0], y+d[1]] == 1) ? 1 : 0)
        end
        cnt
    end

    def next_state
        ns = []
        (0...@w).each do |i|
            (0...@w).each do |j|
                nc = self.neighbors(i, j)
                ns << ((self[i, j] == 1 ? (nc == 2 or nc == 3) : (nc == 3)) ?
                       1 : 0)
            end
        end

        @map = ns
    end
end

game = Gol.new
game.print_
while 1
    game.next_state
    game.print_
    puts "="*60
    sleep 0.1
end
