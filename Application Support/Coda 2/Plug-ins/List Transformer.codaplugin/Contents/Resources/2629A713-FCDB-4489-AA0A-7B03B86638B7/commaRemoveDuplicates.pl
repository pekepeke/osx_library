#!/usr/bin/perl

my $n = $ENV{CODA_LINE_ENDING};
my $source = ",";
my $hash;

# Read lists
my @list;
if ($source eq $n) {
	while (<>) {
		chomp;
		s/(?:^\s+|\s+$)//g;
		unless ($hash->{$_}) {
			push(@list,$_);
			$hash->{$_} = 1;
		}
	}
} else {
	while (<>) {
		chomp;
		my @temp = split(/\s*$source\s*/);
		foreach my $item (@temp) {
			unless ($hash->{$item}) {
				push(@list,$item);
				$hash->{$item} = 1;
			}
		}
	}
}

my $list = join($source, @list);
print "$list";
