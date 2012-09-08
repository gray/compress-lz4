#define PERL_NO_GET_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define NEED_sv_2pvbyte
#include "ppport.h"

#include "lz4.h"
#include "lz4hc.h"

MODULE = Compress::LZ4    PACKAGE = Compress::LZ4

PROTOTYPES: ENABLE

SV *
compress (sv)
    SV *sv
ALIAS:
    compress_hc = 1
PREINIT:
    char *src, *dest;
    STRLEN src_len, dest_len;
CODE:
    if (SvROK(sv) && ! SvAMAGIC(sv))
        sv = SvRV(sv);
    if (! SvOK(sv))
        XSRETURN_NO;
    src = SvPVbyte(sv, src_len);
    if (! src_len)
        XSRETURN_NO;
    dest_len = 4 + LZ4_compressBound(src_len);
    RETVAL = newSV(dest_len);
    dest = SvPVX(RETVAL);
    if (! dest)
        XSRETURN_UNDEF;

    /* Add the length header as 4 bytes in little endian. */
    dest[0] = src_len       & 0xff;
    dest[1] = (src_len>> 8) & 0xff;
    dest[2] = (src_len>>16) & 0xff;
    dest[3] = (src_len>>24) & 0xff;

    dest_len = ix ? LZ4_compressHC(src, dest + 4, src_len)
                  : LZ4_compress(src, dest + 4, src_len);

    SvCUR_set(RETVAL, 4 + dest_len);
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
    if (! src_len || src_len < 5)
        XSRETURN_NO;

    /* Decode the length header. */
    dest_len = (src[0] & 0xff) | (src[1] & 0xff) << 8 | (src[2] & 0xff) << 16
                               | (src[3] & 0xff) << 24;

    RETVAL = newSV(dest_len);
    dest = SvPVX(RETVAL);
    if (! dest)
        XSRETURN_UNDEF;
    if (0 > LZ4_uncompress(src + 4, dest, dest_len)) {
        SvREFCNT_dec(RETVAL);
        XSRETURN_UNDEF;
    }
    SvCUR_set(RETVAL, dest_len);
    SvPOK_on(RETVAL);
OUTPUT:
    RETVAL
