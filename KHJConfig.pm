# -*- encoding:utf-8 -*-
use strict;
use warnings;
use utf8;
package KHJConfig;

# Set location ID. http://weather.livedoor.com/forecast/rss/primary_area.xml
# 130010 for Tokyo, 140020 for Odawara, 220030 for Mishima
our $locationParam="?city=130010";

# The path to twitter client `t': see https://github.com/sferik/t
our $tCommand="t";

# Constant
our $livedoorWeatherURL="http://weather.livedoor.com/forecast/webservice/json/v1";
our $targetDateLabel="今日";
#our $targetDateLabel="明日";

our @hotjavaMessages=
  (
   {thresh=>39, msg=>'モットジャバって何だよ… '},
   {thresh=>37, msg=>'今日も気温がモットジャバ '},
   {thresh=>35, msg=>'今日の気温はモットジャバ '},
   {thresh=>28, msg=>'今日も気温がHotJava '},
  );

1;
