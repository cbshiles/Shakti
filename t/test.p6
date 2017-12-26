#!/usr/bin/env perl6
use Test;
use lib 'lib';
use Shakti::Script;
use Shakti::StringNest;

my @tests;
sub add ($testResult){
    @tests.append: $testResult;
}

my $a = cmd <echo bobs burgers>;
add $a.out ~~ /'bobs burgers'/;

my $b = cmd <fecho burgers>;
add $b.getCmd eq 'fecho burgers';

my $c = cmd <perl --"bubgers">;
add $a.ok && !$b.ok && !$c.ok('with plz cheese');

my $d = wrap('dog', 'hot');
add 'hotdoghot' eq $d;
say $d;

plan @tests.elems;
for @tests {
    ok $_;
}
done-testing;
