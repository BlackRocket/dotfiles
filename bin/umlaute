#!/usr/bin/perl
###############################################################################
#
# Umlaute Korrektur
#
# Umlaute in Filenamen korrigieren, wenn Dateien von Systemen kommen die
# nicht in UTF-8 kodiert sind
#
# Program to correct vowel mutations, that occur when files are coming
# from systems other than coded in UTF-8
#
# ATTENTION: This script is encoded in UTF-8 and should run on an UTF-8 system
#
#
# V 1.0 vom 23.11.2012
#
# Author: Karsten Malcher
#
###############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# A full copy of the GNU Public License may be found at: 
#
# http://www.gnu.org/copyleft/gpl.html
#
###############################################################################
# Declarations
###############################################################################

my $DLevel = 1;		# Debug Level, 0 = no output, 1 = normal output, 2-3 enhanced
require 5.006;

use strict;
use File::Find;
 
my $File = "test";

my $CountFile = 0;
my $CountFileCorr = 0;
my $CountUmlaut = 0;
my $CountCorr = 0;
my $CountSpace = 0;
my $CountByte = 0;
my $CorrectDate = 0;

my $FindDir = "";
my $FilePath = "";
my $FileName = "";
my $FileDate = "";
my $FileSize = 0;
my %Umlaute = ();

# Programmoptionen
my $option;
my $opt_test = 0;
my $opt_write = 0;
my $opt_all = 0;
my $opt_space = 0;


###############################################################################
# Check commandline paramters
###############################################################################

if (@ARGV == 0) {		# Kein Paramter -> Beschreibung
	print "\n";
	print "umlaute.pl [option] [path]\n";
	print "           -t only test and show filenames\n";
	print "           -w write conversions to filenames\n";
	print "           -a list all files\n";
	print "           -u convert spaces to underlines\n";
	print "\n";

	exit;
}

OPTION: 	
while ( defined( $option = shift(@ARGV) )) {
	$_ = $option;
	/^-t$/ && do { $opt_test = 1; next OPTION; };
	/^-w$/ && do { $opt_write = 1; next OPTION; };
	/^-a$/ && do { $opt_all = 1; next OPTION; };
	/^-u$/ && do { $opt_space = 1; next OPTION; };
	/^-.*/ && die "Illegale Option: '$option' !\n";
	$FindDir = $_;
}


if ($opt_test == 0 and $opt_write == 0) { die "Parameter -t oder -w muss gegeben sein!\n"; }

if ($FindDir eq ".") {
	$FindDir = `pwd`;	# Absoluter Pfad erforderlich!
	chomp $FindDir;
}
if (not -d $FindDir) { die "Path '$FindDir' does not exist!\n" }


###############################################################################
# Main
###############################################################################

Init();

print "\nSearching files in '$FindDir' ...\n\n";

# Issue the find command passing two arguments
# The first argument is the subroutine that will be called for each file in the path.
# The second argument is the directory to start your search in.
find(\&FindFile, $FindDir);

print "\n==========================\n";
print "$CountFile files found.\n";
print "$CountFileCorr files renamed.\n";
print "$CountUmlaut Umlaute found..\n";
print "$CountCorr Umlaute corrected.\n";
print "$CountSpace spaces translated.\n\n";

exit;




###############################################################################
# Subroutine that determines whether we matched the file extensions.
###############################################################################

sub FindFile {

# 	my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size, $atime, $mtime, $ctime, $blksize, $blocks) = stat($_)
# 		or die "Unable to stat $_\n";
# 	$FileDate = DatumZeit($mtime);	# Actual File-Date
# 	$FileSize = $size;
# 	$CountByte += $size;

	$FilePath = $File::Find::dir;
	$FileName = $_;
	$CountFile ++;

	my $FilenNameLength = length($_);
	my $NameExplain = "";
	my $NameCorr = "";
	my $FlagUTF8 = 0;
	my $FlagDiff = 0;
	for (my $Count=0; $Count < $FilenNameLength; $Count++) {
		my $CurChar = substr($_, $Count, 1);
		my $ASCII = ord($CurChar);
 		if ($ASCII >= 32 and $ASCII <= 126) {		# Normales ASCII-Zeichen
			if ($ASCII == 32 and $opt_space) {
				$CurChar = "_";
				$CountSpace ++;
				$FlagDiff = 1;
			}
			$NameExplain .= $CurChar;
			$NameCorr .= $CurChar;
		} elsif ($ASCII == 195) {				# Beginn für UTF8-Sonderzeichen
			$FlagUTF8 = 1;
		} elsif ($FlagUTF8 == 1) {				# UTF8 Sonderzeichen auswerten
			$FlagUTF8 = 0;
			my $SearchUTF8 = 195000 + $ASCII;
			$NameExplain .= $Umlaute{$SearchUTF8};
			$NameCorr .= $Umlaute{$SearchUTF8};
			$CountUmlaut ++;
		} else {								# Falscher Umlaut
			$FlagDiff = 1;
			$NameExplain .= "<" . $ASCII . ">";
			$NameCorr .= $Umlaute{$ASCII};
			$CountUmlaut ++;
			$CountCorr ++;
		}
		$DLevel > 2 && print "$Count: " . $CurChar . " = " . $ASCII . "\n";
	}
	if ($DLevel > 0 and ($FlagDiff or $opt_all)) {
		print "Path: " . $File::Find::dir . "  \|  " . $_ . "  \|  " . $FilenNameLength . " chars\n";
	}
	if ($DLevel > 0 and $opt_test and $FlagDiff) {
		print "Check    : " . $NameExplain . "\n";
	}
	if ($DLevel > 0 and $FlagDiff) {
		print "Corrected: " . $NameCorr . "\n";
	}

	if ($opt_write and $FlagDiff) {
		my $FileFrom = $FilePath . "/" . $_;
		my $FileTo = $FilePath . "/" . $NameCorr;
		$DLevel > 1 && print "From: >$FileFrom<\nTo  : >$FileTo<\n";
		rename $FileFrom , $FileTo;
		print "FILE RENAMED!\n";
		$CountFileCorr ++;
	}
	if ($DLevel > 0 and ($FlagDiff or $opt_all)) {
		print "\n";
	}

}


###############################################################################
# Unterprogramm initialisiert Umsetzungstabelle
###############################################################################

sub Init {

	%Umlaute	= 	(
				195164	=> "ä",	# UTF8-characters
				195132 	=> "Ä",
				195182 	=> "ö",
				195150 	=> "Ö",
				195188 	=> "ü",
				195156 	=> "Ü",
				195159 	=> "ß",
				132 		=> "ä",	# Umsetzungstabelle JDownloader
				142 		=> "Ä",
				148 		=> "ö",
				153 		=> "Ö",
				129 		=> "ü",
				154 		=> "Ü",
				225 		=> "ß",
				228 		=> "ä",	# Umsetzungstabelle FTP von Windows
				196 		=> "Ä",
				246 		=> "ö",
				214 		=> "Ö",
				252 		=> "ü",
				220 		=> "Ü",
				223 		=> "ß",
				)

}

