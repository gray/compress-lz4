use strict;
use warnings;
use Test::More;
use Compress::LZ4;

for (qw(compress decompress uncompress)) {
    ok eval "defined &$_", "$_() is exported";
}

{
    no warnings 'uninitialized';
    my $compressed = compress(undef);
    my $decompressed = decompress($compressed);
    is $decompressed, '', 'undef';
}

for my $len (0 .. 1_024) {
    my $in = '0' x $len;
    my $compressed = compress($in);
    my $decompressed = decompress($compressed);
    is $decompressed, $in, "length: $len";
}

my $scalar = '0' x 1_024;
ok compress($scalar) eq compress(\$scalar), 'scalar ref';

# https://rt.cpan.org/Public/Bug/Display.html?id=75624
{
    # Remove the length header.
    my $data = unpack "x4 a*", compress('0' x 14);
    ok $data eq "\0240\001\0P00000", 'AMD64 bug';
}

done_testing;
