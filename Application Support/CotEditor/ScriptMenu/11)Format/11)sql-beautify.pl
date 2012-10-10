#!/usr/bin/env perl
# %%%{CotEditorXInput=Selection}%%%
# %%%{CotEditorXOutput=ReplaceSelection}%%%

BEGIN {
	use FindBin;
	push(@INC, $FindBin::Bin . '/-/lib/perl5/');
}

use warnings;
use strict;
use SQL::Beautify;
local $/;
my $sql = SQL::Beautify->new(
	query => <STDIN>,
	spaces => 4,
	break => "\n",
	uc_keyword => 1
);
print $sql->beautify;

