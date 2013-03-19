package Compress::LZ4;

use strict;
use warnings;
use parent qw(Exporter);

use XSLoader;

our $VERSION    = '0.17';
our $XS_VERSION = $VERSION;
$VERSION = eval $VERSION;

XSLoader::load(__PACKAGE__, $XS_VERSION);

our @EXPORT = qw(compress compress_hc decompress uncompress);


1;

__END__

=head1 NAME

Compress::LZ4 - Perl interface to the LZ4 (de)compressor

=head1 SYNOPSIS

    use Compress::LZ4;

    my $compressed = compress($bytes);
    my $decompressed = decompress($compressed);

=head1 DESCRIPTION

The C<Compress::LZ4> module provides an interface to the LZ4 (de)compressor.

=head1 FUNCTIONS

=head2 compress

    $compressed = compress($bytes)

Compresses the given buffer and returns the resulting bytes. The input
buffer can be either a scalar or a scalar reference.

=head2 compress_hc

    $compressed = compress_hc($bytes)

A higher-compression, but slower, version of C<compress>.

=head2 decompress

=head2 uncompress

    $bytes = decompress($compressed)

Decompresses the given buffer and returns the resulting bytes. The input
buffer can be either a scalar or a scalar reference.

On error (in case of corrupted data) undef is returned.

=head1 PERFORMANCE

This distribution contains a benchmarking script which compares serveral
compression modules available on CPAN.  These are the results on a MacBook
2GHz Core 2 Duo (64-bit) with Perl 5.16.0:

    Compressible data (10 KiB) - compression
    ----------------------------------------
    Compress::LZ4::compress     185579/s  1812 MiB/s  1.152%
    Compress::Snappy::compress  119467/s  1167 MiB/s  5.332%
    Compress::LZF::compress      45728/s   447 MiB/s  1.865%
    Compress::LZ4::compress_hc   21082/s   206 MiB/s  1.152%
    Compress::Zlib::compress      6164/s    60 MiB/s  1.201%
    Compress::Bzip2::compress      114/s     1 MiB/s  2.070%

    Compressible data (10 KiB) - decompression
    ------------------------------------------
    Compress::LZ4::decompress     573439/s  5600 MiB/s
    Compress::Snappy::decompress  192752/s  1882 MiB/s
    Compress::LZF::decompress     139184/s  1359 MiB/s
    Compress::Zlib::uncompress     30632/s   299 MiB/s
    Compress::Bzip2::decompress     6347/s    62 MiB/s

    Uncompressible data (10 KiB) - compression
    ------------------------------------------
    Compress::LZ4::compress     827077/s  8077 MiB/s  110.000%
    Compress::Snappy::compress  618951/s  6044 MiB/s  103.333%
    Compress::LZF::compress     608424/s  5942 MiB/s  101.667%
    Compress::LZ4::compress_hc   22974/s   224 MiB/s  110.000%
    Compress::Zlib::compress     22755/s   222 MiB/s  115.000%
    Compress::Bzip2::compress    15358/s   150 MiB/s  215.000%

    Uncompressible data (10 KiB) - decompression
    --------------------------------------------
    Compress::LZF::decompress     2513115/s  24542 MiB/s
    Compress::LZ4::decompress     2502283/s  24436 MiB/s
    Compress::Snappy::decompress  2406041/s  23496 MiB/s
    Compress::Zlib::uncompress      90163/s    880 MiB/s
    Compress::Bzip2::decompress     50124/s    489 MiB/s

=head1 SEE ALSO

L<http://code.google.com/p/lz4/>

=head1 REQUESTS AND BUGS

Please report any bugs or feature requests to
L<http://rt.cpan.org/Public/Bug/Report.html?Queue=Compress-LZ4>.  I will be
notified, and then you'll automatically be notified of progress on your bug as
I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Compress::LZ4

You can also look for information at:

=over

=item * GitHub Source Repository

L<https://github.com/gray/compress-lz4>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Compress-LZ4>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Compress-LZ4>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/Public/Dist/Display.html?Name=Compress-LZ4>

=item * Search CPAN

L<http://search.cpan.org/dist/Compress-LZ4/>

=back

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012-2013 gray <gray at cpan.org>, all rights reserved.

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=head1 AUTHOR

gray, <gray at cpan.org>

=cut
