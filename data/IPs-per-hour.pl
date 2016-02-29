#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use File::Slurp::Tiny qw(read_lines);

my $file_name = shift || "rastrigin-IPs.csv";

my @lines = read_lines($file_name);

my %IPs_hour;
for my $l (@lines[1..$#lines]) {
  my ($IP, $time ) = split(/,\s+/,$l);
  my ($hour) = ($time =~ /(\d+-\d+-\d+ \d+)/ );
  $IPs_hour{$hour}{$IP}++;
}

for my $t ( sort { $a cmp $b } keys %IPs_hour ) {
  say "$t:00:00, ", scalar keys %{$IPs_hour{$t}};
}

  
