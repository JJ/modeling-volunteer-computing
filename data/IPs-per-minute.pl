#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use File::Slurp::Tiny qw(read_lines);

my @lines = read_lines("rastrigin-IPs.csv");

my %IPs_minute;
for my $l (@lines[1..$#lines]) {
  my ($IP, $time ) = split(/,\s+/,$l);
  my ($minute) = ($time =~ /(\d+-\d+-\d+ \d+:\d+)/ );
  $IPs_minute{$minute}{$IP}++;
}

for my $t ( sort { $a cmp $b } keys %IPs_minute ) {
  say "$t, ", scalar keys %{$IPs_minute{$t}};
}

  
