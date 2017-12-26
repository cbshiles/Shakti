unit module StringNest:ver<0.0.0>:auth<Carl Shiles (carl.shiles@gmail.com)>;

sub wrap($t, $s) is export {$s~$t~$s;}
sub qu ($t) is export {wrap $t, '\'';}
sub dqu($t) is export {wrap $t, '"';}
