/*                               -*- Mode: C -*- 
 * Mathematica.xs -- 
 * ITIID           : $ITI$ $Header $__Header$
 * Author          : Ulrich Pfeifer
 * Created On      : Thu Nov 23 09:32:00 1995
 * Last Modified By: Ulrich Pfeifer
 * Last Modified On: Fri Nov 24 10:24:14 1995
 * Language        : C
 * Update Count    : 45
 * Status          : Unknown, Use with caution!
 * 
 * (C) Copyright 1995, Universität Dortmund, all rights reserved.
 * 
 * $Locker: pfeifer $
 * $Log: Mathematica.xs,v $
# Revision 1.0.1.3  1995/11/24  10:26:32  pfeifer
# patch4: Bugfixes ;-)
#
# Revision 1.0.1.2  1995/11/23  15:20:41  pfeifer
# patch3: Removed all Functions. Added some by hand with more perlish
# patch3: interface.
#
 */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <mathlink.h>
#ifdef VERSION
#undef VERSION
#endif
#include "patchlevel.h"

static int
not_here(s)
char *s;
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

void
init_Math ()
{
  char            buf[80];
  SV             *version = perl_get_sv ("Math::Mathematica::version", TRUE);
  sv_setpv  (version, sprintf (buf, "%3.1f%d", VERSION, PATCHLEVEL));
}

static double
constant(name, arg)
char *name;
int arg;
{
    errno = 0;
    switch (*name) {
    case 'A':
	if (strEQ(name, "ADSP_CCBREFNUM"))
#ifdef ADSP_CCBREFNUM
	    return ADSP_CCBREFNUM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ADSP_IOCREFNUM"))
#ifdef ADSP_IOCREFNUM
	    return ADSP_IOCREFNUM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ADSP_TYPE"))
#ifdef ADSP_TYPE
	    return ADSP_TYPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "APIENTRY"))
#ifdef APIENTRY
	    return APIENTRY;
#else
	    goto not_there;
#endif
	break;
    case 'B':
	if (strEQ(name, "BEGINDLGPKT"))
#ifdef BEGINDLGPKT
	    return BEGINDLGPKT;
#else
	    goto not_there;
#endif
	break;
    case 'C':
	if (strEQ(name, "CALLPKT"))
#ifdef CALLPKT
	    return CALLPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CB"))
#ifdef CB
	    return CB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "COMMTB_CONNHANDLE"))
#ifdef COMMTB_CONNHANDLE
	    return COMMTB_CONNHANDLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "COMMTB_TYPE"))
#ifdef COMMTB_TYPE
	    return COMMTB_TYPE;
#else
	    goto not_there;
#endif
	break;
    case 'D':
	if (strEQ(name, "DEVICE_NAME"))
#ifdef DEVICE_NAME
	    return DEVICE_NAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DEVICE_TYPE"))
#ifdef DEVICE_TYPE
	    return DEVICE_TYPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DISPLAYENDPKT"))
#ifdef DISPLAYENDPKT
	    return DISPLAYENDPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DISPLAYPKT"))
#ifdef DISPLAYPKT
	    return DISPLAYPKT;
#else
	    goto not_there;
#endif
	break;
    case 'E':
	if (strEQ(name, "ENDDLGPKT"))
#ifdef ENDDLGPKT
	    return ENDDLGPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ENTEREXPRPKT"))
#ifdef ENTEREXPRPKT
	    return ENTEREXPRPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ENTERTEXTPKT"))
#ifdef ENTERTEXTPKT
	    return ENTERTEXTPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVALUATEPKT"))
#ifdef EVALUATEPKT
	    return EVALUATEPKT;
#else
	    goto not_there;
#endif
	break;
    case 'F':
	if (strEQ(name, "FIRSTUSERPKT"))
#ifdef FIRSTUSERPKT
	    return FIRSTUSERPKT;
#else
	    goto not_there;
#endif
	break;
    case 'G':
	break;
    case 'H':
	break;
    case 'I':
	if (strEQ(name, "ILLEGALPKT"))
#ifdef ILLEGALPKT
	    return ILLEGALPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "INPUTNAMEPKT"))
#ifdef INPUTNAMEPKT
	    return INPUTNAMEPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "INPUTPKT"))
#ifdef INPUTPKT
	    return INPUTPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "INPUTSTRPKT"))
#ifdef INPUTSTRPKT
	    return INPUTSTRPKT;
#else
	    goto not_there;
#endif
	break;
    case 'J':
	break;
    case 'K':
	break;
    case 'L':
	if (strEQ(name, "LASTUSERPKT"))
#ifdef LASTUSERPKT
	    return LASTUSERPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LOCAL_TYPE"))
#ifdef LOCAL_TYPE
	    return LOCAL_TYPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LOOPBACK_TYPE"))
#ifdef LOOPBACK_TYPE
	    return LOOPBACK_TYPE;
#else
	    goto not_there;
#endif
	break;
    case 'M':
	if (strEQ(name, "MACINTOSH"))
#ifdef MACINTOSH
	    return MACINTOSH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MACTCP_IPDRIVER"))
#ifdef MACTCP_IPDRIVER
	    return MACTCP_IPDRIVER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MACTCP_PARTNER_ADDR"))
#ifdef MACTCP_PARTNER_ADDR
	    return MACTCP_PARTNER_ADDR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MACTCP_PARTNER_PORT"))
#ifdef MACTCP_PARTNER_PORT
	    return MACTCP_PARTNER_PORT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MACTCP_STREAM"))
#ifdef MACTCP_STREAM
	    return MACTCP_STREAM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MACTCP_TYPE"))
#ifdef MACTCP_TYPE
	    return MACTCP_TYPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MENUPKT"))
#ifdef MENUPKT
	    return MENUPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MESSAGEPKT"))
#ifdef MESSAGEPKT
	    return MESSAGEPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLAPI"))
#ifdef MLAPI
	    return MLAPI;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLBlocking"))
#ifdef MLBlocking
	    return MLBlocking;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLBrowse"))
#ifdef MLBrowse
	    return MLBrowse;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLBrowseMask"))
#ifdef MLBrowseMask
	    return MLBrowseMask;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLDefaultOptions"))
#ifdef MLDefaultOptions
	    return MLDefaultOptions;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLDontBrowse"))
#ifdef MLDontBrowse
	    return MLDontBrowse;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLDontInteract"))
#ifdef MLDontInteract
	    return MLDontInteract;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEABORT"))
#ifdef MLEABORT
	    return MLEABORT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEACCEPT"))
#ifdef MLEACCEPT
	    return MLEACCEPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEARGV"))
#ifdef MLEARGV
	    return MLEARGV;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEBADHOST"))
#ifdef MLEBADHOST
	    return MLEBADHOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEBADNAME"))
#ifdef MLEBADNAME
	    return MLEBADNAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLECLOSED"))
#ifdef MLECLOSED
	    return MLECLOSED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLECONNECT"))
#ifdef MLECONNECT
	    return MLECONNECT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEDEAD"))
#ifdef MLEDEAD
	    return MLEDEAD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEGBAD"))
#ifdef MLEGBAD
	    return MLEGBAD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEGETENDPACKET"))
#ifdef MLEGETENDPACKET
	    return MLEGETENDPACKET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEGSEQ"))
#ifdef MLEGSEQ
	    return MLEGSEQ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEINIT"))
#ifdef MLEINIT
	    return MLEINIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLELAUNCH"))
#ifdef MLELAUNCH
	    return MLELAUNCH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLELAUNCHAGAIN"))
#ifdef MLELAUNCHAGAIN
	    return MLELAUNCHAGAIN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLELAUNCHSPACE"))
#ifdef MLELAUNCHSPACE
	    return MLELAUNCHSPACE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEMEM"))
#ifdef MLEMEM
	    return MLEMEM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEMODE"))
#ifdef MLEMODE
	    return MLEMODE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLENAMETAKEN"))
#ifdef MLENAMETAKEN
	    return MLENAMETAKEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLENEXTPACKET"))
#ifdef MLENEXTPACKET
	    return MLENEXTPACKET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLENOLISTEN"))
#ifdef MLENOLISTEN
	    return MLENOLISTEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLENOPARENT"))
#ifdef MLENOPARENT
	    return MLENOPARENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEOK"))
#ifdef MLEOK
	    return MLEOK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEOVFL"))
#ifdef MLEOVFL
	    return MLEOVFL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEPBIG"))
#ifdef MLEPBIG
	    return MLEPBIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEPBTK"))
#ifdef MLEPBTK
	    return MLEPBTK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEPROTOCOL"))
#ifdef MLEPROTOCOL
	    return MLEPROTOCOL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEPSEQ"))
#ifdef MLEPSEQ
	    return MLEPSEQ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEPUTENDPACKET"))
#ifdef MLEPUTENDPACKET
	    return MLEPUTENDPACKET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEUNKNOWN"))
#ifdef MLEUNKNOWN
	    return MLEUNKNOWN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEUNKNOWNPACKET"))
#ifdef MLEUNKNOWNPACKET
	    return MLEUNKNOWNPACKET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEUSER"))
#ifdef MLEUSER
	    return MLEUSER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLEchoExpression"))
#ifdef MLEchoExpression
	    return MLEchoExpression;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLInteract"))
#ifdef MLInteract
	    return MLInteract;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLInteractMask"))
#ifdef MLInteractMask
	    return MLInteractMask;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLInternetVisible"))
#ifdef MLInternetVisible
	    return MLInternetVisible;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLLocallyVisible"))
#ifdef MLLocallyVisible
	    return MLLocallyVisible;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLNetworkVisible"))
#ifdef MLNetworkVisible
	    return MLNetworkVisible;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLNetworkVisibleMask"))
#ifdef MLNetworkVisibleMask
	    return MLNetworkVisibleMask;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLNonBlocking"))
#ifdef MLNonBlocking
	    return MLNonBlocking;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLNonBlockingMask"))
#ifdef MLNonBlockingMask
	    return MLNonBlockingMask;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKAEND"))
#ifdef MLTKAEND
	    return MLTKAEND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKELEN"))
#ifdef MLTKELEN
	    return MLTKELEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKEND"))
#ifdef MLTKEND
	    return MLTKEND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKERROR"))
#ifdef MLTKERROR
	    return MLTKERROR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKFUNC"))
#ifdef MLTKFUNC
	    return MLTKFUNC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKINIT"))
#ifdef MLTKINIT
	    return MLTKINIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKINT"))
#ifdef MLTKINT
	    return MLTKINT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKPCTEND"))
#ifdef MLTKPCTEND
	    return MLTKPCTEND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKREAL"))
#ifdef MLTKREAL
	    return MLTKREAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKSTR"))
#ifdef MLTKSTR
	    return MLTKSTR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLTKSYM"))
#ifdef MLTKSYM
	    return MLTKSYM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MLVersionMask"))
#ifdef MLVersionMask
	    return MLVersionMask;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ML_DEFAULT_DIALOG"))
#ifdef ML_DEFAULT_DIALOG
	    return (long) ML_DEFAULT_DIALOG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ML_EXTENDED_IS_DOUBLE"))
#ifdef ML_EXTENDED_IS_DOUBLE
	    return ML_EXTENDED_IS_DOUBLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ML_IGNORE_DIALOG"))
#ifdef ML_IGNORE_DIALOG
	    return (long) ML_IGNORE_DIALOG;
#else
	    goto not_there;
#endif
	break;
    case 'N':
	if (strEQ(name, "NULL"))
#ifdef NULL
	    return NULL;
#else
	    goto not_there;
#endif
	break;
    case 'O':
	if (strEQ(name, "OUTPUTNAMEPKT"))
#ifdef OUTPUTNAMEPKT
	    return OUTPUTNAMEPKT;
#else
	    goto not_there;
#endif
	break;
    case 'P':
	if (strEQ(name, "PIPE_CHILD_PID"))
#ifdef PIPE_CHILD_PID
	    return PIPE_CHILD_PID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PIPE_FD"))
#ifdef PIPE_FD
	    return PIPE_FD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PPC_PARTNER_LOCATION"))
#ifdef PPC_PARTNER_LOCATION
	    return PPC_PARTNER_LOCATION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PPC_PARTNER_PORT"))
#ifdef PPC_PARTNER_PORT
	    return PPC_PARTNER_PORT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PPC_PARTNER_PSN"))
#ifdef PPC_PARTNER_PSN
	    return PPC_PARTNER_PSN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PPC_SESS_REF_NUM"))
#ifdef PPC_SESS_REF_NUM
	    return PPC_SESS_REF_NUM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PPC_TYPE"))
#ifdef PPC_TYPE
	    return PPC_TYPE;
#else
	    goto not_there;
#endif
	break;
    case 'Q':
	break;
    case 'R':
	if (strEQ(name, "RESUMEPKT"))
#ifdef RESUMEPKT
	    return RESUMEPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RETURNEXPRPKT"))
#ifdef RETURNEXPRPKT
	    return RETURNEXPRPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RETURNPKT"))
#ifdef RETURNPKT
	    return RETURNPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RETURNTEXTPKT"))
#ifdef RETURNTEXTPKT
	    return RETURNTEXTPKT;
#else
	    goto not_there;
#endif
	break;
    case 'S':
	if (strEQ(name, "SOCKET_FD"))
#ifdef SOCKET_FD
	    return SOCKET_FD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SOCKET_PARTNER_ADDR"))
#ifdef SOCKET_PARTNER_ADDR
	    return SOCKET_PARTNER_ADDR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SOCKET_PARTNER_PORT"))
#ifdef SOCKET_PARTNER_PORT
	    return SOCKET_PARTNER_PORT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSPENDPKT"))
#ifdef SUSPENDPKT
	    return SUSPENDPKT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SYNTAXPKT"))
#ifdef SYNTAXPKT
	    return SYNTAXPKT;
#else
	    goto not_there;
#endif
	break;
    case 'T':
	if (strEQ(name, "TEXTPKT"))
#ifdef TEXTPKT
	    return TEXTPKT;
#else
	    goto not_there;
#endif
	break;
    case 'U':
	if (strEQ(name, "UNIX"))
#ifdef UNIX
	    return UNIX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "UNIXPIPE_TYPE"))
#ifdef UNIXPIPE_TYPE
	    return UNIXPIPE_TYPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "UNIXSOCKET_TYPE"))
#ifdef UNIXSOCKET_TYPE
	    return UNIXSOCKET_TYPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "UNREGISTERED_TYPE"))
#ifdef UNREGISTERED_TYPE
	    return UNREGISTERED_TYPE;
#else
	    goto not_there;
#endif
	break;
    case 'V':
	break;
    case 'W':
	if (strEQ(name, "WINLOCAL_TYPE"))
#ifdef WINLOCAL_TYPE
	    return WINLOCAL_TYPE;
#else
	    goto not_there;
#endif
	break;
    case 'X':
	break;
    case 'Y':
	break;
    case 'Z':
	break;
    case 'a':
	break;
    case 'b':
	break;
    case 'c':
	break;
    case 'd':
	break;
    case 'e':
	break;
    case 'f':
	break;
    case 'g':
	break;
    case 'h':
	break;
    case 'i':
	break;
    case 'j':
	break;
    case 'k':
	break;
    case 'l':
	break;
    case 'm':
	break;
    case 'n':
	break;
    case 'o':
	break;
    case 'p':
	break;
    case 'q':
	break;
    case 'r':
	break;
    case 's':
	break;
    case 't':
	break;
    case 'u':
	break;
    case 'v':
	break;
    case 'w':
	break;
    case 'x':
	break;
    case 'y':
	break;
    case 'z':
	break;
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}


MODULE = Math::Mathematica PACKAGE = Math::Mathematica PREFIX = ML
BOOT:
init_Math();


double
constant(name,arg)
	char *		name
	int		arg

MLINK
MLOpen(...)
CODE:
{
    char **args = NULL;
    
    if (items) {
        int i;
                                /* MathLink reads beyond the array! */
        args = (char **)malloc((items+1) * sizeof(char *));
        for (i=0;i<items;i++) {
            args[i] = (char *)SvPV(ST(i), na);
        }
        args[items]=NULL;
    }
    RETVAL = MLOpen(items, args);
    if (args) free(args);
    ST(0) = sv_newmortal();
    if (RETVAL) sv_setref_pv(ST(0), "Math::Mathematica", (void*)RETVAL);
}

void
MLClose(mlink)
	MLINK	mlink
CODE:
    if (mlink != (MLINK) 0xDeadBeef) {  /* sv_setref_pv cannot use NULL */
        MLClose(mlink);
        mlink=(MLINK) 0xDeadBeef;
    }
OUTPUT:
    mlink

int
MLPutSymbol(mlink, string)
	MLINK	mlink
	char*	string

int
MLEndPacket(mlink)
	MLINK	mlink

int
MLNextPacket(mlink)
	MLINK	mlink

int
MLNewPacket(mlink)
	MLINK	mlink

int
MLGetType(mlink)
	MLINK	mlink

char *
MLGetString(mlink)
	MLINK	mlink
CODE:
{
    char *string;
    MLGetString(mlink,&string);
    ST(0) = sv_newmortal();
    if (string) {
        sv_setpv((SV*)ST(0), string);
        MLDisownString(mlink, string);
    }
}

char *
MLGetSymbol(mlink)
	MLINK	mlink
CODE:
{
    char *string;
    MLGetSymbol(mlink,&string);
    ST(0) = sv_newmortal();
    if (string) {
        sv_setpv((SV*)ST(0), string);
        MLDisownSymbol(mlink, string);
    }
}

int
MLGetInteger(mlink)
	MLINK	mlink
CODE:
{
    int result;
    
    ST(0) = sv_newmortal();
    if(MLGetInteger(mlink,&result)) {
        sv_setiv((SV*)ST(0), result);
    }
}

float
MLGetFloat(mlink)
	MLINK	mlink
CODE:
{
    float result;
    
    ST(0) = sv_newmortal();
    if(MLGetFloat(mlink,&result)) {
        sv_setnv((SV*)ST(0), result);
    }
}

double
MLGetDouble(mlink)
	MLINK	mlink
CODE:
{
    double result;
    
    ST(0) = sv_newmortal();
    if(MLGetDouble(mlink,&result)) {
        sv_setnv((SV*)ST(0), result);
    }
}
           
double
MLGetReal(mlink)
	MLINK	mlink
CODE:
{
    double result;
    
    ST(0) = sv_newmortal();
    if(MLGetReal(mlink,&result)) {
        sv_setnv((SV*)ST(0), result);
    }
}
           
int
MLPutFunction(mlink, name, argc)
	MLINK	mlink
	char*	name
	long	argc

int
MLBytesToGet(mlink)
	MLINK	mlink
CODE:
{
    long	count;

    ST(0) = sv_newmortal();
    if (MLBytesToGet(mlink, &count)) {
        sv_setiv(ST(0), (IV)count);
    }
}

int
MLBytesToPut(mlink)
	MLINK	mlink
CODE:
{
    long	count;

    ST(0) = sv_newmortal();
    if (MLBytesToPut(mlink, &count)) {
        sv_setiv(ST(0), (IV)count);
    }
}

int
MLCheckFunction(mlink, func)
	MLINK	mlink
	char*	func
CODE:
{
    long argc;

    ST(0) = sv_newmortal();
    if (MLCheckFunction(mlink, func, &argc)) {
        sv_setiv(ST(0), (IV)argc);
    }
}

int
MLError(mlink)
	MLINK	mlink

int
MLClearError(mlink)
	MLINK	mlink

int
MLSetError(mlink, errno)
	MLINK	mlink
	int	errno

char*
MLErrorMessage(mlink)
	MLINK	mlink

char*
MLGetData(mlink, max)
	MLINK	mlink
	long	max
CODE:
{
    char*       buf = (char *) malloc(max);
    long	count;

    ST(0) = sv_newmortal();
    if(MLGetData(mlink, buf,max,&count)) {
        sv_setpvn((SV*)ST(0), buf, count);
    }
}
        

int
MLPutNext(mlink, integer1)
	MLINK	mlink
	int	integer1

int
MLPutSize(mlink, long1)
	MLINK	mlink
	long	long1

int
MLPutData(mlink, string)
	MLINK	mlink
	char *	string
CODE:
{
    long length;
    string = SvPV((SV*)ST(1),length);

    fprintf(stderr, "MLPutData %ld\n", length);
    RETVAL = MLPutData(mlink, string, length);
    ST(0) = sv_newmortal();
    sv_setiv(ST(0), (IV)RETVAL);
}

int
MLPutArgCount(mlink, long1)
	MLINK	mlink
	long	long1

int
MLPutShortInteger(mlink, integer1)
	MLINK	mlink
	int	integer1

int
MLPutInteger(mlink, integer1)
	MLINK	mlink
	int	integer1

int
MLPutLongInteger(mlink, long1)
	MLINK	mlink
	long	long1

int
MLPutFloat(mlink, number1)
	MLINK	mlink
	double	number1

int
MLPutReal(mlink, number1)
	MLINK	mlink
	double	number1

int
MLPutDouble(mlink, number1)
	MLINK	mlink
	double	number1

int
MLPutString(mlink, string1)
	MLINK	mlink
	char*	string1

int
MLPutMessage(mlink, long1)
	MLINK	mlink
	unsigned long	long1
