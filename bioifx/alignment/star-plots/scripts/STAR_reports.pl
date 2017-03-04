#!/usr/bin/perl
# vim: syntax=perl tabstop=4 expandtab

#-----------------------------------
# @author: Mahesh Vangala
# @email: vangalamaheshh@gmail.com
# @date: Aug, 1, 2015
#-----------------------------------
use strict;
use warnings;
use Getopt::Long;
use File::Basename;

my $options = parse_options();
my ( $matrix, $row_names, $sample_names ) = get_matrix( $$options{ 'star_log' } );
print_matrix( $matrix, $row_names, $sample_names, $$options{'out_file'});
exit $?;

sub parse_options {
	my $options = {};
	GetOptions( $options, 'star_log|l=s@', 'out_file|o=s', 'help|h' );
	unless( $$options{ 'star_log' } or $$options{'out_file'}) {
		my $usage = "$0 <--star_log|-l> <--out_file|-o>";
		print STDERR $usage, "\n";
		exit 1;
	}
	return $options;
}

sub get_matrix {
	my( $log_files ) = @_;
	my $matrix = {};
	my $row_names = [];
	my $sample_names = [];
	foreach my $log_file( @$log_files ) {
		my( $sample_name ) = ( basename( $log_file ) =~ /^\d+\-(.+)\.Log\.final\.out/ ); 
		push @$sample_names, $sample_name;
		open( FH, "<$log_file" ) or die "Error in opening the file, $log_file, $!\n";
		my $flag = 0;
		while( my $line = <FH> ) {
			chomp $line;
			$line =~ s/^\s+//;
			$line =~ s/\s+$//;
			if( $line =~ /^Number/ && ! $flag ) {
				$flag = 1;
			}
			if( $flag ) {
				my( $key, $value ) = split(/\|/, $line );
				if( $value ) {
					$key =~ s/^\s+//;
					$key =~ s/\s+$//;
					$key =~ s/,//g;
					$key =~ s/\s+/_/g;
					$value =~ s/^\s+//;
					$value =~ s/\s+$//;
					push @$row_names, $key unless( exists $$matrix{ $key } );
					$$matrix{ $key }{ $sample_name } = $value;
				}
			}
		}
		close FH or die "Error in closing the file, $log_file, $!\n";
	}
	return ( $matrix, $row_names, $sample_names );
}

sub print_matrix {
	my( $matrix, $row_names, $sample_names, $out_file ) = @_;
  open(OFH, ">$out_file") or die "Error in opening the file, $out_file, $!\n";
	my $header = join( ",", ( undef, @$sample_names ) );
	print OFH $header, "\n";
	foreach my $feature( @$row_names ) {
		my @values = ();
		FOR_LOOP:
		foreach my $sample( @$sample_names ) {
			unless( exists $$matrix{ $feature }{ $sample } ) {
				last FOR_LOOP;
			}
			push @values, $$matrix{ $feature }{ $sample } or undef;
		}
		unless( @values ) {
			print OFH $feature, "\n";
		} else {
			print OFH join( ",", ( $feature, @values ) ), "\n";
		}
	}
  close OFH or die "Error closing the file handle, $out_file, $!\n";
}
