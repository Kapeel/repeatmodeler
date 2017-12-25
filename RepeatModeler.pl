#!/usr/bin/perl -w
use strict;
use File::Basename;
use Data::Dumper;
use Getopt::Long qw(:config no_ignore_case no_auto_abbrev pass_through);

#my (@file_query, $database_path, $user_database_path, $annotation_path, 
#$user_annotation_path, $file_names, $root_names, @file_query2, $lib_type, $file_type, $n_cores);

my $user_database_path;
my $database_path;

GetOptions( "user_database=s"   => \$user_database_path
          );

if (!($user_database_path)) {
    die "No genome fasta was supplied\n";
}

# Allow over-ride of system-level database path with user
if ($user_database_path) {
  $database_path = $user_database_path;
  unless (`grep \\> $database_path`) {
      die "Error: $database_path  the user supplied file is not a FASTA file";
  }
}
  my $name = basename($database_path, qw/.fa .fas .fasta .fna/);
  print STDERR "RepeatMedoler building database using ncbi blast $name\n";
#BuildDatabase -name sorg -engine ncbi sorg.fasta  
  my $build_database = "BuildDatabase";
  system $build_database . " -name $name -engine ncbi $database_path";
  my $app  = "RepeatModeler";

    	my $align_command = "$app -engine ncbi -pa 4 -database $name";
    	#report("Executing: $align_command\n");
    	system $align_command;
