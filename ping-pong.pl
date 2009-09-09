#!/usr/bin/perl
use Coro;
my $rounds = 4;

sub go ($) {
    while ($rounds--) { # check before decrement
        print "$rounds : $_[0]\n";
        sleep 1;
        Coro::cede;
    }
    print "done ($_[0] wins)\n";
}

async { go "pong" };
sleep 2;
go "ping";

# Output will always be the following:
#
#     3 : ping
#     2 : pong
#     1 : ping
#     0 : pong
#     done (ping wins)
#
# Note the 2 second delay before "3 : ping" and the 1 second delay after each
# message.
#
# Unlike pre-emptive threading, Coro threading has deterministic transfer
# points.  The "pong" thread won't run until the main "ping" thread cedes
# control and so on.
