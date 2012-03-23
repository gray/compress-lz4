use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME   => 'src',
    OBJECT => '$(O_FILES)',
);
