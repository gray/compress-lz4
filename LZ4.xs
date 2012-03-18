#define PERL_NO_GET_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define NEED_sv_2pvbyte
#include "ppport.h"

#include "src/lz4.h"

MODULE = Compress::LZ4    PACKAGE = Compress::LZ4

PROTOTYPES: ENABLE

SV *
compress (sv)
    SV *sv
PREINIT:
    char *src, *dest;
    STRLEN src_len, dest_len;
CODE:
    if (SvROK(sv))
        sv = SvRV(sv);
    if (! SvOK(sv))
        XSRETURN_NO;
    src = SvPVbyte(sv, src_len);
    if (! src_len)
        XSRETURN_NO;
    dest_len = sizeof(int) + LZ4_compressBound(src_len);
    RETVAL = newSV(dest_len);
    dest = SvPVX(RETVAL);
    if (! dest)
        XSRETURN_UNDEF;
    *((int *)dest) = src_len;
    dest_len = LZ4_compress(src, dest + sizeof(int), src_len);
    SvCUR_set(RETVAL, sizeof(int) + dest_len);
    SvPOK_on(RETVAL);
OUTPUT:
    RETVAL

SV *
decompress (sv)
    SV *sv
ALIAS:
    uncompress = 1
PREINIT:
    char *src, *dest;
    STRLEN src_len, dest_len;
CODE:
    PERL_UNUSED_VAR(ix);  /* -W */
    if (SvROK(sv))
        sv = SvRV(sv);
    if (! SvOK(sv))
        XSRETURN_NO;
    src = SvPVbyte(sv, src_len);
    if (! src_len)
        XSRETURN_NO;
    dest_len = *(int *)src;
    RETVAL = newSV(dest_len);
    dest = SvPVX(RETVAL);
    if (! dest)
        XSRETURN_UNDEF;
    if (0 > LZ4_uncompress(src + sizeof(int), dest, dest_len))
        XSRETURN_UNDEF;
    SvCUR_set(RETVAL, dest_len);
    SvPOK_on(RETVAL);
OUTPUT:
    RETVAL
