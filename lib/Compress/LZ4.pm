package Compress::LZ4;

use strict;
use warnings;
use parent qw(Exporter);

use XSLoader;

our $VERSION    = '0.01';
our $XS_VERSION = $VERSION;
$VERSION = eval $VERSION;

XSLoader::load(__PACKAGE__, $XS_VERSION);

our @EXPORT = qw(compress decompress uncompress);


1;

__END__

=head1 NAME

Compress::LZ4 - Perl interface to the LZ4 (de)compressor

=head1 SYNOPSIS

    use Compress::LZ4;

    my $dest = compress($source);
    my $dest = decompress($source);

=head1 DESCRIPTION

The C<Compress::LZ4> module provides an interface to the LZ4 (de)compressor.

=head1 FUNCTIONS

=head2 compress

    $string = compress($buffer)

Compresses the given buffer and returns the resulting string. The input
buffer can be either a scalar or a scalar reference.

=head2 decompress

=head2 uncompress

    $string = decompress($buffer)

Decompresses the given buffer and returns the resulting string. The input
buffer can be either a scalar or a scalar reference.

On error (in case of corrupted data) undef is returned.

=head1 PERFORMANCE

This distribution contains a benchmarking script which compares serveral
compression modules available on CPAN.  These are the results on a MacBook
2GHz Core 2 Duo (64-bit) with Perl 5.14.2:

    Compressible data (10 KiB) - compression
    ----------------------------------------
    Compress::LZ4::compress     172031/s  1680 MiB/s  1.152%
    Compress::Snappy::compress  112439/s  1098 MiB/s  5.332%
    Compress::LZF::compress      40959/s   400 MiB/s  1.865%
    Compress::Zlib::compress      2694/s    26 MiB/s  1.201%
    Compress::Bzip2::compress       83/s  0.81 MiB/s  2.070%

    Compressible data (10 KiB) - decompression
    ------------------------------------------
    Compress::LZ4::decompress     521308/s  5091 MiB/s
    Compress::Snappy::decompress  177535/s  1734 MiB/s
    Compress::LZF::decompress     129153/s  1261 MiB/s
    Compress::Bzip2::decompress     5430/s    53 MiB/s
    Compress::Zlib::uncompress      5288/s    52 MiB/s

    Uncompressible data (10 KiB) - compression
    ------------------------------------------
    Compress::LZ4::compress     619098/s  6046 MiB/s  109.231%
    Compress::Snappy::compress  533431/s  5209 MiB/s  104.615%
    Compress::LZF::compress     527300/s  5149 MiB/s  101.538%
    Compress::Bzip2::compress    13471/s   132 MiB/s  204.615%
    Compress::Zlib::compress      4094/s    40 MiB/s  112.308%

    Uncompressible data (10 KiB) - decompression
    --------------------------------------------
    Compress::LZF::decompress     2411229/s  23547 MiB/s
    Compress::LZ4::decompress     2184532/s  21333 MiB/s
    Compress::Snappy::decompress  1943864/s  18983 MiB/s
    Compress::Bzip2::decompress     45175/s    441 MiB/s
    Compress::Zlib::uncompress       5973/s     58 MiB/s

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

Copyright (C) 2012 gray <gray at cpan.org>, all rights reserved.

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=head1 AUTHOR

gray, <gray at cpan.org>

=cut
