#!/usr/bin/env perl6
use lib 'lib';
use Shakti::Script;

my @peeps = (if (cmd <cowsay -l>).out ~~ m/ \n\s*[ (\S+)\s+ ]+ / {$0}); 

sub getCow($i) {
    my @lines = (shl <fortune | cowsay -f>, $i).out.lines;
    my $max = @lines.map({.chars}).max;
    @lines.map( {$_~(' ' x ($max-.chars))});
}

sub infix:<_~_>(@l, @r ) {
    my $diff = @r.elems - @l.elems;
    my @mod := ($diff > 0) ?? @l !! @r;
    my $len = @mod[0].chars;
    for 1..$diff.abs {@mod.unshift: (' ' x $len);}
    (@l >>~<< ('  ' <<~<< @r)).join("\n");
}

my @cow1 = getCow(@peeps.pick);
my @cow2 = getCow(@peeps.pick);

say (@cow1 _~_ @cow2);
