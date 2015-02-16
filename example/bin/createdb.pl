#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use gplustest::DB;

my $db = gplustest::DB->do_connect;

$db->deploy();
