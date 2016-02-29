#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use File::Slurp::Tiny qw(read_lines);

my $file_name = shift || "rastrigin-IPs.csv";
my @lines = read_lines($file_name);

my %IPs_minute;
my %total_IPs;
for my $l (@lines[1..$#lines]) {
  my ($IP, $time ) = split(/;\s+/,$l);
  my ($minute) = ($time =~ /(\d+-\d+-\d+.\d+:\d+)/ );
  if (!$minute ) {
    die "Wrong format for $time ";
  }
  $total_IPs{$IP}++;
  $IPs_minute{$minute}{$IP}++;
}

say "time,IPs-Total:".scalar keys %total_IPs;
for my $t ( sort { $a cmp $b } keys %IPs_minute ) {
  say "$t, ", scalar keys %{$IPs_minute{$t}};
}

  
