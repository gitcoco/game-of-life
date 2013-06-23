#!/usr/bin/env perl

use 5.014;

my @map = ();
my $w = 30;
my $prob = 0.5;

sub init {
    for my $i (0..$w-1) {
        for my $j (0 .. $w-1) {
            push @map, (int rand(100) < $prob * 100);
        }
    }
}

sub get { $map[ $_[0]*$w + $_[1] ] }

sub print_ {
    for my $i (0..$w-1) {
        for my $j (0..$w-1) {
            print substr("  X ", get($i, $j), 2);
        }
        say "";
    }
}

sub neighbors {
    my ($x, $y) = @_;
    my @dirs = ([-1, -1], [0, -1], [1, -1],
                [-1,  0],          [1,  0],
                [-1,  1], [0,  1], [1,  1]);
    my $cnt = 0;
    for my $d (@dirs) {
        $cnt += ($x+$d->[0] >= 0 and $y+$d->[1] >= 0 and
                 $x+$d->[0] < $w and $y+$d->[1] < $w and
                 get($x+$d->[0], $y+$d->[1]));

    }
    return $cnt;
}

sub next_state {
    my @ns = ();
    for my $i (0..$w-1) {
        for my $j (0..$w-1) {
            my $nc = neighbors($i, $j);
            push @ns, (get($i, $j) ? ($nc == 2 or $nc == 3) : ($nc == 3));
        }
    }
    @map = @ns;
}

# main
init();
print_();
while (1) {
    next_state();
    print_();
    say "="x60;
    select undef, undef, undef, 0.1;
}
