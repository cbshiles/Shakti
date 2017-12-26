unit module Script:ver<0.0.1>:auth<Carl Shiles (carl.shiles@gmail.com)>;

use Shakti::StringNest;

class Cmd {
    has $.out;
    has $.err;
    has $.proc;

    method getCmd() {$.proc.command[];}

    method getErr() {$.err ?? $.err !! 'BLANK ERROR';}
    
    method ok($errMsg?) {
	my $good = $.proc.exitcode == 0;
	if !$good {
	    my $msg = 'ERROR_.:'~(chomp $.getErr)~':._ _.:'~ $.getCmd ~':.';
	    note $errMsg ?? $errMsg~"\n"~$msg !! $msg;
	}
	$good;
    }

    method du() {if $.ok {say $.out;}}
    
    method testPrint() {
	say 'Out-> '~$.out;
	say 'Err-> '~$.err;
	say 'Proc-> '~$.proc.perl;	
    }
}

sub runner($rnr) {
    Cmd.new(proc => $rnr,
	    out => ($rnr.out.slurp: :close), 
	    err => ($rnr.err.slurp: :close));
}

sub cmd is export {runner(run @_, :out, :err);}
sub shl is export {runner(shell @_, :out, :err);}

sub pkill ($iCmd) is export {
    my $ps = cmd <ps -ef>;
    if $ps.ok {
	if $ps.out ~~ m/ (\d+) <-[\n]>+ $iCmd / {
	    my $kill = cmd 'kill', ~$/[0];
	    if $kill.ok('Error killing: '~$/) { 
		say 'Killed: '~$/; 
	    }
	} else {
	    say "'$iCmd' isn't running.";
	}
    }
}

