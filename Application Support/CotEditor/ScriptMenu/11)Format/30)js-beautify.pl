#!/usr/bin/env perl
# %%%{CotEditorXInput=Selection}%%%
# %%%{CotEditorXOutput=ReplaceSelection}%%%

BEGIN {
	use FindBin;
	push(@INC, $FindBin::Bin . '/-/lib/perl5/');
}
use warnings;
use strict;
use JavaScript::Beautifier qw/js_beautify/;

local $/;
my $js_source_code = <STDIN>;
my $pretty_js = js_beautify( $js_source_code, {
	indent_size => 2,
	indent_character => " ",
});
print $pretty_js;
