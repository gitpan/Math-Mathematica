#!/usr/local/ls6/perl/bin/perl
#                              -*- Mode: Perl -*- 
# Mathematica.pm -- 
# ITIID           : $ITI$ $Header $__Header$
# Author          : Ulrich Pfeifer
# Created On      : Thu Nov 23 09:40:46 1995
# Last Modified By: Ulrich Pfeifer
# Last Modified On: Fri Nov 24 17:12:21 1995
# Language        : Perl
# Update Count    : 50
# Status          : Unknown, Use with caution!
# 
# (C) Copyright 1995, Universität Dortmund, all rights reserved.
# 
# $Locker: pfeifer $
# $Log: Mathematica.pm,v $
# Revision 1.0.1.4  1995/11/24  16:17:11  pfeifer
# patch5: PutCall now has a better idea what Strings, Symbols and
# patch5: Numbers are.
#
# Revision 1.0.1.3  1995/11/24  10:26:03  pfeifer
# patch4: Convenience functions.
#
# Revision 1.0.1.2  1995/11/23  15:19:47  pfeifer
# patch3: Made OO-Interface.
#
# 

package Math::Mathematica;
use Carp;
require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(
        ADSP_CCBREFNUM
	ADSP_IOCREFNUM
	ADSP_TYPE
	APIENTRY
	BEGINDLGPKT
	CALLPKT
	CB
	COMMTB_CONNHANDLE
	COMMTB_TYPE
	DEVICE_NAME
	DEVICE_TYPE
	DISPLAYENDPKT
	DISPLAYPKT
	ENDDLGPKT
	ENTEREXPRPKT
	ENTERTEXTPKT
	EVALUATEPKT
	FIRSTUSERPKT
	ILLEGALPKT
	INPUTNAMEPKT
	INPUTPKT
	INPUTSTRPKT
	LASTUSERPKT
	LOCAL_TYPE
	LOOPBACK_TYPE
	MACINTOSH
	MACTCP_IPDRIVER
	MACTCP_PARTNER_ADDR
	MACTCP_PARTNER_PORT
	MACTCP_STREAM
	MACTCP_TYPE
	MENUPKT
	MESSAGEPKT
	MLAPI
	MLBlocking
	MLBrowse
	MLBrowseMask
	MLDefaultOptions
	MLDontBrowse
	MLDontInteract
	MLEABORT
	MLEACCEPT
	MLEARGV
	MLEBADHOST
	MLEBADNAME
	MLECLOSED
	MLECONNECT
	MLEDEAD
	MLEGBAD
	MLEGETENDPACKET
	MLEGSEQ
	MLEINIT
	MLELAUNCH
	MLELAUNCHAGAIN
	MLELAUNCHSPACE
	MLEMEM
	MLEMODE
	MLENAMETAKEN
	MLENEXTPACKET
	MLENOLISTEN
	MLENOPARENT
	MLEOK
	MLEOVFL
	MLEPBIG
	MLEPBTK
	MLEPROTOCOL
	MLEPSEQ
	MLEPUTENDPACKET
	MLEUNKNOWN
	MLEUNKNOWNPACKET
	MLEUSER
	MLEchoExpression
	MLInteract
	MLInteractMask
	MLInternetVisible
	MLLocallyVisible
	MLNetworkVisible
	MLNetworkVisibleMask
	MLNonBlocking
	MLNonBlockingMask
	MLTKAEND
	MLTKELEN
	MLTKEND
	MLTKERROR
	MLTKFUNC
	MLTKINIT
	MLTKINT
	MLTKPCTEND
	MLTKREAL
	MLTKSTR
	MLTKSYM
	MLVersionMask
	ML_DEFAULT_DIALOG
	ML_EXTENDED_IS_DOUBLE
	ML_IGNORE_DIALOG
	NULL
	OUTPUTNAMEPKT
	PIPE_CHILD_PID
	PIPE_FD
	PPC_PARTNER_LOCATION
	PPC_PARTNER_PORT
	PPC_PARTNER_PSN
	PPC_SESS_REF_NUM
	PPC_TYPE
	RESUMEPKT
	RETURNEXPRPKT
	RETURNPKT
	RETURNTEXTPKT
	SOCKET_FD
	SOCKET_PARTNER_ADDR
	SOCKET_PARTNER_PORT
	SUSPENDPKT
	SYNTAXPKT
	TEXTPKT
	UNIX
	UNIXPIPE_TYPE
	UNIXSOCKET_TYPE
	UNREGISTERED_TYPE
	WINLOCAL_TYPE
	ml_extended
);

$version = '';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    local($constname);
    ($constname = $AUTOLOAD) =~ s/.*:://;
    $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
	    ($pack,$file,$line) = caller;
	    die "Your vendor has not defined Math::Mathematica macro $constname, used at $pack $file line $line.
";
	}
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap Math::Mathematica;

# Preloaded methods go here.

sub new {
    my $type = shift;
    my $self = Open(@_);

    bless $self, $type;
}

sub DESTROY {
    Close(@_);
}

    
sub Call {
    my $self = shift;

    $self->PutCall(@_);
    $self->EndPacket();
    return($self->Result);
}

sub PutCall {
    my $link = shift;
    my ($name, @args) = @_;

    $link->PutFunction($name, $#args+1); # must be a string!
    for (@args) {               # this is a hack! Should be in xsub
        if (ref($_)) {
            if (ref($_) eq 'ARRAY') {
                &PutCall($link, @{$_});
            } else {
                croak "Not an array reference $_";
            }
        } elsif (/^([\"\'])(.*)\1$/i) {   # assume string
            print "PutString($2)\n" if $debug;
            $link->PutString($2);
        } elsif (/^[^\d\.+-]/i) {         # assume symbol
            print "PutSymbol($_)\n" if $debug;
            $link->PutSymbol($_);
        } else {
            print "PutDouble($_)\n" if $debug;
            $link->PutDouble($_);         # assume numeric value
        }
    }
}

sub Result {
    my $link = shift;

    $link->ResultGet;              # get the result packet or die
    $link->ResultParse;
}

sub ResultGet {
    my $link = shift;
    my $type;

    while(1) {
        $type = $link->NextPacket();
        print "ResultGet: $type\n" if $debug;
        last if $type == &constant('RETURNPKT',0);
        if ($type == &constant('MLTKERROR',0)) {
            croak sprintf("Got error packet %d %s\n", 
                         $link->Error,
                         $link->ErrorMessage);
        } elsif ($type == &constant('MESSAGEPKT',0)) {
            carp sprintf("Message: %s %s\n", $link->GetSymbol, $link->GetString);
#        } else {
#            croak "Unknown message type: $type\n";
        }
        $link->NewPacket();
    }
}

sub ResultParse {
    my $link = shift;
    my ($type, $result, $name, $args, @result);

    $type = $link->GetType();

    print "Result: $type\n" if $debug;
    if ($type == &constant('MLTKREAL',0)) {
        $result = $link->GetReal();
        print "real=$result\n" if $debug;
    } elsif ($type == &constant('MLTKINT',0)) {
        $result = $link->GetInteger();
        print "int=$result\n" if $debug;
    } elsif ($type == &constant('MLTKSTR',0)) {
        $result = $link->GetString();
        print "string=$result\n" if $debug;
    } elsif ($type == &constant('MLTKSYM',0)) {
        $result = $link->GetSymbol();
        print "symbol=$result\n" if $debug;
    } elsif ($link->GetType() == &constant('MLTKSTR',0)) {
        $result = $link->GetString();
        print "string=$result\n" if $debug;
    } elsif ($link->GetType() == &constant('MLTKFUNC',0)) {
        ($name, $args) = $link->GetFunction();
        print "($name, $args)\n" if $debug;
        for (1 .. $args) {
            push(@result, $link->ResultParse);
        }
        $result = join (',', @result);
        print "function($args)=$name\[$result\]\n" if $debug;
        if ($name eq 'List') {
            return(@result);
        } elsif ($name eq 'Rational') {
            return($result[0]/$result[1]);
        } else {
            return ($name, @result);
        }
    } else {
        carp "Error -- ouput is not a known package type: $type\n";
    }
    $result;
}

# Autoload methods go after __END__, and are processed by the autosplit program.

1;
__END__
