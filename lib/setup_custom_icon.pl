#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Carp;
use Data::Dumper;
use Getopt::Long;
use Pod::Usage;
use FindBin;
use File::Copy qw(copy);

my %FILES = (
    "Sublime\ Text\ 2.icns" => "/Applications/Sublime Text 2.app/Contents/Resources/",
    "muCommander.icns" => "/Applications/muCommander.app/Contents/Resources/icon.icns",
    "VimIcon.icns" => "/Applications/Vim.app/Contents/Resources/app.icns",
    "kdiff3.icns" => "/Applications/kdiff3.app/Contents/Resources/kdiff3.icns",
    "MacVim.icns" => "/Applications/MacVim.app/Contents/Resources/",
);

sub usage {
    pod2usage(-verbose => 2);
    exit 1;
}

my $opt_help;
Getopt::Long::Configure("bundling");
GetOptions(
    'h|help' => \$opt_help,
) or usage;
usage if $opt_help;

for my $name (keys %FILES) {
    my $fpath = $FILES{$name};
    for my $dest ("$ENV{HOME}/$fpath", $fpath) {
        next unless ( -e $dest);
        print "copy $name -> $dest\n";
        copy($FindBin::Bin . "/../tools/ApplicationIcons/" . $name, $dest) or warn "cannot copy file : $name - $dest : $!";
    }
}

__END__

=head1 NAME

    set_icon.pl - update application icon script

=head1 SYNOPSIS


=head1 OPTIONS


=head1 AUTHOR

