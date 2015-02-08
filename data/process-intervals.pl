#!/usr/bin/env perl

use File::Slurp::Tiny qw(read_file);
use JSON;
use v5.14;

my $file_name = shift || "log";

my $log_json = read_file( $file_name ) || die "Can't read file $file_name\n";

my $log = decode_json $log_json;

my %times;
for my $l (@$log ) {
    my $IP = $l->{'IP'};
    if ( $l->{'put'} ) {
	push @{$times{$IP}}, $l->{'put'}[0];
    };
}

for my $ip ( keys %times ) {
  if ( @{$times{$ip}} > 1 ) {
    my $time = shift @{$times{$ip}};
    for my $t (  @{$times{$ip}} ) {
      say "$ip;", $t-$time;
      $time = $t;
    }
  }
}

