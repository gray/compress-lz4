use strict;
use warnings;
use ExtUtils::MakeMaker;
use Data::Dump;

WriteMakefile(
    NAME      => 'src',
    OBJECT    => '$(O_FILES)',
    NO_MYMETA => 1,
);
