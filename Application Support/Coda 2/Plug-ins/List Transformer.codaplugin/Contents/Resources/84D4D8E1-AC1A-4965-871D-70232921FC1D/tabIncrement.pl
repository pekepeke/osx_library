#!/usr/bin/perl

my $n = $ENV{CODA_LINE_ENDING};
my $source = "\t";
my $digit = "#";

# Read lists
my @list;
if ($source eq $n) {
	while (<>) {
		chomp;
		s/(?:^\s+|\s+$)//g;
		push(@list,$_);
	}
} else {
	while (<>) {
		chomp;
		push(@list,split(/\s*$source\s*/));
	}
}

my $cnt = 1;
foreach my $item (@list) {
	if ($item =~ /\#/) {
		$item =~ s/\#/$cnt/g;
		$cnt++;
	}
}

my $list = join($source, @list);
print "$list";
