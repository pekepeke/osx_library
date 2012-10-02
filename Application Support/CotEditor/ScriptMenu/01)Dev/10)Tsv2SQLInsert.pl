#!/usr/bin/env perl

# %%%{CotEditorXInput=AllText}%%%
# %%%{CotEditorXOutput=ReplaceAllText}%%%
use strict;
use warnings;

my (@head, $val);
while (<>) {
    chomp;
    unless (@head) {
        @head = split(/\t/, $_);
    } else {
        my @values = map { 
            if (/^null$/i || !$_) {
                $val = "NULL";
            } elsif (/^[0-9]+$/) {
                $val = $_;
            } else {
                s/'/''/g;
                $val = "'" . $_ . "'";
            }
        } split(/\t/, $_);
        for my $i (($#values+1)..$#head) { push(@values, "NULL"); }
        printf("INSERT INTO xxx_table (%s) VALUES (%s);\n", join(",", @head), join(',', @values));
    }
}
