package Nephia::Setup::Plugin::Bootstrap;
use 5.008005;
use strict;
use warnings;
use parent 'Nephia::Setup::Plugin';
use Nephia::Setup::Plugin::Bootstrap::TwitterBootstrap;
use Nephia::Setup::Plugin::Bootstrap::jQuery;

our $VERSION = "0.01";

sub fix_setup {
    my $self = shift;
    $self->SUPER::fix_setup;
    my $setup = $self->setup;
    my $chain = $setup->action_chain;
    $chain->append(Bootstrap => \&install_bootstrap);
}

sub install_bootstrap {
    my $setup = shift;
    
    my $bootstrap_files = Nephia::Setup::Plugin::Bootstrap::TwitterBootstrap::files;
    my $jquery_files    = Nephia::Setup::Plugin::Bootstrap::jQuery::files;

    map {
        my @path = split '/', $_;
        $setup->makepath(qw/root static/, @path);
    } qw( bootstrap bootstrap/css bootstrap/js bootstrap/fonts js );

    for (sort keys %{$bootstrap_files}) {
        $setup->spew(qw/ root static /, (split /\//, $_), $bootstrap_files->{$_});
    }

    for (sort keys %{$jquery_files}) {
        $setup->spew(qw/ root static /, (split /\//, $_), $jquery_files->{$_});
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Nephia::Setup::Plugin::Bootstrap - Template for Nephia

=head1 SYNOPSIS

    % nephia-setup MyApp --plugins=Minimal,Bootstrap

=head1 DESCRIPTION

Nephia::Setup::Plugin::Bootstrap is a adding flavor for Nephia.
This flavor prepares the Twitter Bootstrap and jQuery.
This module is developed in reference to Amon2::Setup::Basic.

=head1 LICENSE

Copyright (C) papix.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

papix E<lt>mail@papix.netE<gt>

=cut
