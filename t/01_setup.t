use strict;
use warnings;
use Nephia::Setup;
use Test::More;
use Capture::Tiny 'capture';
use Cwd;
use File::Temp 'tempdir';
use Guard;

my $pwd = getcwd;
my $temp_dir = tempdir(CLEANUP => 1);
chdir $temp_dir;
my $guard = guard { chdir $pwd };

my $setup = Nephia::Setup->new(
    appname => 'Verdure::Memory',
    plugins => ['Minimal', 'Bootstrap'],
);

isa_ok $setup, 'Nephia::Setup';

SKIP: {
    skip 'Create test is skipped in Windows', if $^O eq 'MSWin32';

    my($out, $err, @res) = capture {
        $setup->do_task;
    };

    my $expect = join('',(<DATA>));
    like $err, qr/$expect/, 'setup step';
}

undef($guard);

done_testing;

__DATA__
    Create directory Verdure-Memory/root
    Create directory Verdure-Memory/root/static
    Create directory Verdure-Memory/root/static/bootstrap
    Create directory Verdure-Memory/root/static/bootstrap/css
    Create directory Verdure-Memory/root/static/bootstrap/js
    Create directory Verdure-Memory/root/static/bootstrap/fonts
    Create directory Verdure-Memory/root/static/js
    Create file Verdure-Memory/root/static/bootstrap/css/bootstrap-theme.css
    Create file Verdure-Memory/root/static/bootstrap/css/bootstrap-theme.min.css
    Create file Verdure-Memory/root/static/bootstrap/css/bootstrap.css
    Create file Verdure-Memory/root/static/bootstrap/css/bootstrap.min.css
    Create file Verdure-Memory/root/static/bootstrap/fonts/glyphicons-halflings-regular.eot
    Create file Verdure-Memory/root/static/bootstrap/fonts/glyphicons-halflings-regular.svg
    Create file Verdure-Memory/root/static/bootstrap/fonts/glyphicons-halflings-regular.ttf
    Create file Verdure-Memory/root/static/bootstrap/fonts/glyphicons-halflings-regular.woff
    Create file Verdure-Memory/root/static/bootstrap/js/bootstrap.js
    Create file Verdure-Memory/root/static/bootstrap/js/bootstrap.min.js
    Create file Verdure-Memory/root/static/js/jquery-1.10.0.min.js
  Done.
