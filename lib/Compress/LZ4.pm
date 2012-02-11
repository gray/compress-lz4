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
    Compress::LZ4::compress     193029/s  1885 MiB/s
    Compress::Snappy::compress  118154/s  1154 MiB/s
    Compress::LZF::compress      41354/s   404 MiB/s
    Compress::Bzip2::compress     4901/s    48 MiB/s
    Compress::Zlib::compress      3040/s    30 MiB/s

    Compressible data (10 KiB) - decompression
    ------------------------------------------
    Compress::Snappy::decompress  126030/s  1231 MiB/s
    Compress::LZ4::decompress      99211/s   969 MiB/s
    Compress::LZF::decompress      36885/s   360 MiB/s
    Compress::Bzip2::decompress    17568/s   172 MiB/s
    Compress::Zlib::uncompress      5024/s    49 MiB/s

    Uncompressible data (10 KiB) - compression
    ------------------------------------------
    Compress::LZ4::compress     722823/s  7059 MiB/s
    Compress::Snappy::compress  527301/s  5149 MiB/s
    Compress::LZF::compress     505717/s  4939 MiB/s
    Compress::Bzip2::compress    14053/s   137 MiB/s
    Compress::Zlib::compress      4267/s    42 MiB/s

    Uncompressible data (10 KiB) - decompression
    --------------------------------------------
    Compress::LZF::decompress     2481460/s  24233 MiB/s
    Compress::LZ4::decompress     2434193/s  23771 MiB/s
    Compress::Snappy::decompress  2066450/s  20180 MiB/s
    Compress::Bzip2::decompress     46242/s    452 MiB/s
    Compress::Zlib::uncompress       6164/s     60 MiB/s

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
