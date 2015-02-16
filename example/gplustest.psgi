use strict;
use warnings;

use gplustest;

my $app = gplustest->apply_default_middlewares(gplustest->psgi_app);
$app;

