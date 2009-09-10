#!/usr/bin/perl
use Coro;

my $cb = Coro::rouse_cb;
async { print "pong\n"; $cb->("foo") };

print "ping\n";
my $result = Coro::rouse_wait($cb);
print "got $result\n";

# always prints out ping, pong, got foo
