# -*- encoding:utf-8 -*-
use strict;
use warnings;
use utf8;
package KHJConfig;

# Set location ID. http://weather.livedoor.com/forecast/rss/primary_area.xml
# 130010 for Tokyo, 140020 for Odawara, 220030 for Mishima
our $locationParam="?city=130010";

# Say HotJava if temp is equal to or greater than ...
our $HJthresh=28; # degrees celsius

# The path to twitter client `t': see https://github.com/sferik/t
our $tCommand="t";

# Constant
our $livedoorWeatherURL="http://weather.livedoor.com/forecast/webservice/json/v1";
our $targetDateLabel="今日";
#our $targetDateLabel="明日";
our $hotjavaMessage="今日も気温がHotJava "; # Weather URL is appended to this string

1;
