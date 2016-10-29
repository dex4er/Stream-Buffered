package Stream::Buffered::File;
use strict;
use warnings;
use base 'Stream::Buffered';

use File::Spec;
use IO::File;

sub new {
    my $class = shift;

    local $ENV{TMPDIR} = File::Spec->tmpdir;
    my $fh = IO::File->new_tmpfile;
    $fh->binmode;

    bless { fh => $fh }, $class;
}

sub print {
    my $self = shift;
    $self->{fh}->print(@_);
}

sub size {
    my $self = shift;
    $self->{fh}->flush;
    -s $self->{fh};
}

sub rewind {
    my $self = shift;
    $self->{fh}->seek(0, 0);
    $self->{fh};
}

1;
