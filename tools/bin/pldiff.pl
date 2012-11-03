#!/usr/bin/perl

################################################################################
# Copyright (c) 2011 University of Utah Student Computing Labs.
# All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright notice appears in all copies and
# that both that copyright notice and this permission notice appear
# in supporting documentation, and that the name of The University
# of Utah not be used in advertising or publicity pertaining to
# distribution of the software without specific, written prior
# permission. This software is supplied as is without expressed or
# implied warranties of any kind.
################################################################################

use Foundation;
use FindBin;
# use lib "/usr/local/lib/";
use lib $FindBin::Bin;
require "perlplist.pl";

use Getopt::Std;

####################################
# Get ARGs
#
getopts("d:o:",\%options);

usage() if ! defined $ARGV[1];

my $diff_options = { 'output'=>'print' };
$$diff_options{'max_depth'} = $options{'d'} if defined $options{'d'};

if ( defined $options{'o'} ) {
  $options{'o'} =~ s/-/</;
  $options{'o'} =~ s/\+/>/;
  $$diff_options{'output_types'} = $options{'o'};
}

if ( -e $ARGV[0] and -e $ARGV[1] ) {
  my $dict1 = loadDefaults($ARGV[0]);
  my $dict2 = loadDefaults($ARGV[1]);
  if ( ! $dict1 ) {
    die "Could not load $ARGV[0] (try plutil -lint)\n";
  } elsif ( ! $dict2 ) {
    die "Could not load $ARGV[1] (try plutil -lint)\n";
  } else {
		plistDiff ( $dict1, $dict2, $diff_options );
  }
} else {
  print "Could not find $ARGV[0] or $ARGV[1]";
  usage();
}

sub usage {
  print <<EOF;
Usage $0 [-d max depth] [-o -|<|=|>|+] file1 file2\n";
	-d max depth = number of levels to decend
	-o		Control which lines to show (default is "<>!?").
			< or - shows values that are unique to the first file.
			> or + shows values that are unique to the second file.
			= shows values that are the same in both files.
			! shows values that are the different.
			? shows containers that are not compared because the max depth was reached.
EOF
  exit;
}
