#!/usr/bin/perl -CS
use strict;
use warnings;
use utf8;
use HTTP::Tiny;
use JSON::PP;
use KHJConfig;

sub fetch_temp {
  my $response=HTTP::Tiny->new->get($KHJConfig::livedoorWeatherURL.$KHJConfig::locationParam);
  die "Accessing weather information failed.\n" unless $response->{success};
  die "Response length is 0.\n" if !length $response->{content};
  my $weather=decode_json($response->{content});
  my $forecasts=${$weather}{forecasts};
  my $maxC=undef;
  foreach(@$forecasts) {
    if(${$_}{dateLabel} eq $KHJConfig::targetDateLabel) {
      my $temps=${$_}{temperature};
      my $maxtemps=${$temps}{max};
      if(defined($maxtemps)) {
	$maxC=${$maxtemps}{celsius};
      }
    }
  }
  if(defined($maxC)) {
    my %result;
    $result{temperature}=$maxC;
    $result{link}=${$weather}{link};
    return \%result;
  } else {
    die "Max temperature not in the forecast -- maybe you need to run this program earlier in the morning.\n";
  }
}

sub msgForTemp {
  my $temp=shift;
  foreach (@KHJConfig::hotjavaMessages) {
    if($temp >= ${$_}{'thresh'}) {
      return ${$_}{msg};
    }
  }
  return undef;
}

sub run_tempHotJava {
  my $temp=fetch_temp();
  #print STDERR ${$temp}{temperature}." C\n";
  my $msg=msgForTemp(int(${$temp}{temperature}));
  if(defined($msg)) {
    # Do the HotJava thing!
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
    $mon++;
    my $message=$msg.${$temp}{link}." ".$mon."/".$mday."\n";
    system($KHJConfig::tCommand,"update",$message);
    #print $message;
  }
}

run_tempHotJava();

