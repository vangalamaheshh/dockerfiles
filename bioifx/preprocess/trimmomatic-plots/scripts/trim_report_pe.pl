#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use File::Basename;

my $options = parse_options();
my ($trim_info, $samples) = get_trim_info($$options{ 'trim_log_file' });
print_trim_info($trim_info, $samples);
exit $?;

sub parse_options {
    my $options = {};
    GetOptions($options, 'trim_log_file|l=s@', 'help|h');
    unless($$options{'trim_log_file'}) {
        print STDERR "Usage: $0 <--trim_log_file|-l> [--trim_log_file|-l]\n";
        exit 1;
    }
    return $options;
}

sub get_trim_info {
    my $trim_info = {};
    my( $file_list ) = @_;
    my $samples = [];
    foreach my $trim_file( @$file_list ) {
        my( $sample ) = basename($trim_file);
	$sample =~ s/^\d+\-//;
	$sample =~ s/\..+$//;
	push @$samples, $sample;
        open( FH, "<$trim_file" ) or die "Error in opening the file, $trim_file, $!\n";
        while( my $line = <FH> ) {
            chomp $line;
            if( $line =~ /^Input Read Pairs:/ ) {
                my( $total_reads, $both_surviving, $left_only, $right_only, $dropped ) = ( $line =~ /.+?\s(\d+)\s.+?\s(\d+)\s.+?\s(\d+)\s.+?\s(\d+)\s.+?\s(\d+)\s/ );
                $$trim_info{ $sample } = [ $total_reads, $both_surviving, $left_only, $right_only, $dropped ];
            }
        }
        close FH or die "Error in closing the file, $trim_file, $!\n";
    }
    return $trim_info, $samples;
}

sub print_trim_info {
    my($trim_info, $samples) = @_;
    print STDOUT join( ",", qw(SampleName TotalReads BothSurviving LeftMateOnly RightMateOnly Dropped) ), "\n";
    foreach my $sample(@$samples) {
        print STDOUT join( ",", ( $sample, @{ $$trim_info{ $sample } } ) ), "\n";              
    }
}
