#!/usr/local/ls6/perl/bin/perl
#                              -*- Mode: Perl -*- 
# compl.t -- 
# ITIID           : $ITI$ $Header $__Header$
# Author          : Ulrich Pfeifer
# Created On      : Fri Nov 24 13:20:40 1995
# Last Modified By: Ulrich Pfeifer
# Last Modified On: Fri Nov 24 17:15:00 1995
# Language        : Perl
# Update Count    : 84
# Status          : Unknown, Use with caution!
# 
# (C) Copyright 1995, Universität Dortmund, all rights reserved.
# 
# $Locker: pfeifer $
# $Log: compl.t,v $
# Revision 1.1  1995/11/24  14:01:03  pfeifer
# Initial revision
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

$launch = !($MATHHOST || $MATHPORT);
$mathp  = $MATHPROGRAM || 'math';
sleep(10) unless $launch;
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

print "1..4\n";

@a = $link->Call('Table', ['Sin', 'i'], ['List', 'i', 0, 1, 0.1]);
$link->PutCall('Table', ['Sin', 'i'], ['List', 'i', 0, 1, 0.1]);
$link->EndPacket;
$link->ResultGet;
$type = $link->GetType();
@b = $link->GetRealList();

print (($a[3] == $b[3])?"ok 1\n":"not ok 1\n");

$e = $link->Call('Needs', '"Statistics`ContinuousDistributions`"'); 
print (($e eq 'Null')?"ok 2\n":"not ok 2\n");

@c = $link->Call('Table', 
                 ['CDF', ['NormalDistribution', 0, 1], 'i'],
                 ['List', 'i', 0, 1, 0.1]);

# print (join ', ', @c), "\n";
print (($c[0] == 0.5)?"ok 3\n":"not ok 3\n");

$link->PutCall('Table', 
               ['N', ['CDF', ['NormalDistribution', 0, 1], 'i']],
               ['List', 'i', 0, 1, 0.1]);
# $Math::Mathematica::debug=1;
$link->EndPacket();
$link->ResultGet;
$type = $link->GetType();
@d = $link->GetRealList();
# print 'd:', (join ', ', @d), "\n";
#for ($i=0;$i<=1;$i+=0.1) {
#    printf "%5.3f %f\n", $i, shift @c;
#}
print (($d[0] == 0.5)?"ok 4\n":"not ok 4\n");
