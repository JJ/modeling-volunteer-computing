#!/usr/bin/env perl

use File::Slurp::Tiny qw(read_file);
use JSON;
use v5.14;

my $file_name = shift || "log";

my $log_json = read_file( $file_name ) || die "Can't read file $file_name\n";

my $log = decode_json $log_json;

my %IPs;

my @times;
for my $l (@$log ) {
  if ( $l->{'put'} ) {
    push @times, $l->{'put'}[0];
  } else {
    push @times, $l->{'get'}[0];
  }
  if ( $l->{'put'} ){
    $IPs{$l->{'IP'}}++
  };
}

my $total_time = $times[$#times]-$times[0];
my $total_ips = keys(%IPs);


say "$total_time;$total_ips";

