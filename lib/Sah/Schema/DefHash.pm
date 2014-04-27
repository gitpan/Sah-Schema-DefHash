package Sah::Schema::DefHash;

use 5.010001;
use strict;
use warnings;

our $VERSION = '0.02'; # VERSION
our $DATE = '2014-04-27'; # DATE

our %SCHEMAS;

$SCHEMAS{defhash} = [
    'hash',
    keys => {

        v         => ['float*', default=>1],

        defhash_v => ['int*', default=>1],

        name      => [
            'str*',
            'clset&' => [
                {
                    match             => qr/\A\w+\z/,
                    'match.err_level' => 'warn',
                    'match.err_msg'   => 'should be a word',
                },
                {
                    max_len             => 32,
                    'max_len.err_level' => 'warn',
                    'max_len.err_msg'   => 'should be short',
                },
            ],
        ],

        summary   => [
            'str',
            'clset&' => [
                {
                    max_len             => 72,
                    'max_len.err_level' => 'warn',
                    'max_len.err_msg'   => 'should be short',
                },
                {
                    'match'           => qr/\n/,
                    'match.op'        => 'not',
                    'match.err_level' => 'warn',
                    'match.err_msg'   => 'should only be a single-line text',
                },
            ],
        ],

        description => [
            'str',
        ],

        tags => [
            'array',
            of => [
                'any*',
                of => [
                    'str*',
                    'hash*', # XXX defhash, but this is circular
                ],
            ],
        ],

        default_lang => [
            'str*', # XXX check format, e.g. 'en' or 'en_US'
        ],

        x => [
            'any',
        ],
    },
    'keys.restrict' => 0,
    'allowed_keys_re' => qr/\A\w+(\.\w+)*\z/,
];

$SCHEMAS{defhash_v1} = [
    'defhash',
    keys => {
        defhash_v => ['int*', is=>1],
    },
];

# XXX check known attributes (.alt, etc)
# XXX check alt.XXX format (e.g. must be alt\.(lang\.\w+|env_lang\.\w+)
# XXX *.alt.*.X should also be of the same type (e.g. description.alt.lang.foo

1;
# ABSTRACT: Sah schemas to validate DefHash

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::DefHash - Sah schemas to validate DefHash

=head1 VERSION

version 0.02

=head1 SYNOPSIS

 # schemas are put in the %SCHEMAS package variable

=head1 DESCRIPTION

This module contains L<Sah> schemas to validate L<DefHash>.

=head1 SCHEMAS

=over

=item * defhash

=item * defhash_v1

=back

=head1 SEE ALSO

L<Sah>, L<Data::Sah>

L<DefHash>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
