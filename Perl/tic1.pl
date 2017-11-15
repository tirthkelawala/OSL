#!/usr/bin/perl

use strict;
use warnings;
 
my $board = "123456789";
my @wins = qw/ 123 456 789 147 258 369 159 357 /;
 
sub board {
 print "\n$_" for ($board =~ /(...)/g);
 if ($_ = shift) { print; exit; }
}
 
sub move { # Returns 0 for invalid move or piece, 1 for valid
 my $piece = shift; # X or O
 my $move  = shift; # 1 through 9
 return 0 if $piece !~ /^[XO]$/ or $move !~ /^[1-9]$/;
 return 0 unless $board =~ s/$move/$piece/;
 for (0..7) {
  board ("\n$piece wins!\n") if $wins[$_] =~ s/$move/$piece/ && $wins[$_] eq $piece x 3;
 }
 board ("\nTie!\n") if $board !~ /\d/;
 return 1;
}
 
sub check {
 my $piece = shift; # X or O
 my $move  = shift; # 1 through 9
 return 0 if $piece !~ /^[XO]$/ or $move !~ /^[1-9]$/;
 return grep { /$piece/ && /$move/ && /\d${piece}?\d/ } @wins;
}
 
sub player {
 my $retval = 0;
 my $move;
 until ( $retval ) {
  print "\nMove : ";
  chomp ($move = <>);
  $retval = move('X', $move);
 }
}
 
sub bot {
 return if move('O', 5);
 my $move;
 my @open = ($board =~ /(\d)/g);
 for $move (@open) { return move('O',$move) if grep {/$move/ && /O\d?O/} @wins; }
 for $move (@open) { return move('O',$move) if grep {/$move/ && /X\d?X/} @wins; }
 for (@open) { return move('O',$_) if ( check('O', $_) > 1 ); }
 for $move (@open) {
  if ( my @seq = check('O', $move) ) {
   my ($opposite) = $seq[0] =~ /([^O$move])/;
   return move('O', $move) if ( check('X', $opposite) < 2 );
  }
 }
 move ('O', $open[0]);
}
 
while (1) {
 board;
 player;
 bot;
}