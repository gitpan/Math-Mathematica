#!/usr/local/ls6/perl/bin/perl
#                              -*- Mode: Perl -*- 
# basic.t -- 
# ITIID           : $ITI$ $Header $__Header$
# Author          : Ulrich Pfeifer
# Created On      : Thu Nov 23 20:00:48 1995
# Last Modified By: Ulrich Pfeifer
# Last Modified On: Fri Nov 24 15:42:30 1995
# Language        : Perl
# Update Count    : 35
# Status          : Unknown, Use with caution!
# 
# (C) Copyright 1995, Universität Dortmund, all rights reserved.
# 
# $Locker: pfeifer $
# $Log: basic.t,v $
# Revision 1.0.1.2  1995/11/24  16:18:33  pfeifer
# patch5: Now passes strings quoted.
#
# Revision 1.0.1.1  1995/11/24  10:26:57  pfeifer
# patch4: Former test.pl using convenience functions.
#
# 

use Math::Mathematica;

$MATHHOST = $MATHPORT = $MATHPROGRAM = '';

open(MF, "Makefile.PL") || die "could not open Makefile.PL: $!";
while (<MF>) {
    if (/^\$MATH(PROGRAM|HOST|PORT)\s*=/) {
        print;
        eval $_;
    }
}
close(MF);

print "1..7\n";

$launch = !($MATHHOST || $MATHPORT);
$mathp  = $MATHPROGRAM || 'math';
print "launch:$launch\n";
if ($launch) {
    for (split /:/, $ENV{'PATH'}) {
        if (-x "$_/$mathp") {
            $math = "$_/$mathp -mathlink";
            print "Will launch $math\n";
        }
    }

    die "Could not find $math in \$PATH" unless $math;
    $link = new Math::Mathematica('-linkname', $math, 
                                  '-linkmode', 'launch');
} else {
    $link = new Math::Mathematica('-linkname', '3000', 
                                  '-linkmode', 'Connect',
                                  '-linkhost', 'schroeder',
                                  '-linkprotocol', 'TCP',
                                  );
}

print "Open\n";
print (($link)?"ok 1\n":"not ok 1\n");

print "Let's get the version\n";
$link->PutSymbol('$Version');
$link->EndPacket();
$version = $link->Result();
print (($version)?"ok 2\n":"not ok 2\n");

print "Lets's see what exp(1) is\n";
$e = $link->Call('Exp',1);
print "$e\n";
print (($e == 2.71828182845905)?"ok 3\n":"not ok 3\n");

print "Lets's see what exp(1) rounded to 4 digits is\n";
$e = $link->Call('N', ['Exp',1],4);
print "$e\n";
print (($e == 2.71828182845905)?"ok 4\n":"not ok 4\n");

print "Lets's load a Package\n";
$e = $link->Call('Needs', '"Statistics`ContinuousDistributions`"'); 
print "$e\n";
print (($e eq 'Null')?"ok 5\n":"not ok 5\n");

print "Lets's compute the Normal Distribution at 1.5\n";
$e = $link->Call('CDF', ['NormalDistribution', 0, 1], 1.5);
print "$e\n";
print (($e == 0.933192798731142)?"ok 6\n":"not ok 6\n");

print "Bye\n";
$link->PutFunction('Exit', 0);
$link->EndPacket();
print "ok 6\n";

$link->Close();
print "ok 7\n";


