#!/usr/bin/perl -w

use strict;
use Test::More tests => 45;

use Build::Rpm;

my @tests = (
  '4*1024'			=> '4096',
  '5 < 1'			=> '0',
  '(4 + 5) * 2 == 18'		=> '1',
  '5 || 0'			=> '5',
  '5 && 0'			=> '0',
  '! ""'			=> '1',
  '! "foo"'			=> '0',
  '0 || 3'			=> '3',
  '2 || 3'			=> '2',
  '0 || 0'			=> '0',
  '2 || 0'			=> '2',
  '"" || "foo"'			=> '"foo',
  '"bar" || "foo"'		=> '"bar',
  '0 && 3'			=> '0',
  '2 && 3'			=> '3',
  '0 && 0'			=> '0',
  '2 && 0'			=> '0',
  '"" && "foo"'			=> '"',
  '"bar" && "foo"'		=> '"foo',
  '0 ? 2 : 3'			=> '3',
  '1 ? 2 : 3'			=> '2',
  '0 ? 0 ? 3 : 4 : 0 ? 6 : 7'	=> '7',
  '0 ? 0 ? 3 : 4 : 5 ? 6 : 7'	=> '6',
  '0 ? 2 ? 3 : 4 : 0 ? 6 : 7'	=> '7',
  '0 ? 2 ? 3 : 4 : 5 ? 6 : 7'	=> '6',
  '1 ? 0 ? 3 : 4 : 0 ? 6 : 7'	=> '4',
  '1 ? 0 ? 3 : 4 : 5 ? 6 : 7'	=> '4',
  '1 ? 2 ? 3 : 4 : 0 ? 6 : 7'	=> '3',
  '1 ? 2 ? 3 : 4 : 5 ? 6 : 7'	=> '3',
  '1 || 2 && 0'			=> '0',
  '1 - 1 - 1'			=> '-1',
  '1 + 2 * 3'			=> '7',
  '2 * -2'			=> '-4',
  '7 == 1 + 2 * 3'		=> '1',
  '5 || 2 ? 3 : 4'		=> '3',
  '"foo" + "bar"'		=> '"foobar',
  'v"1.2" > v"1"'               => '1',
  'v"1.2" < v"1"'               => '0',
  'v"1.2" > v"1.2"'             => '0',
  'v"1.2" < v"1.2"'             => '0',
  'v"1.2" >= v"1.2"'            => '1',
  'v"1.2" <= v"1.2"'            => '1',
  'v"1.2" == v"1.2"'            => '1',
  'v"1.2" != v"1.2"'            => '0',
  'v"1.2" != v"1"'              => '1',
);

while (@tests) {
  my ($ex, $expected) = splice(@tests, 0, 2);
  my ($actual, $rem) = Build::Rpm::expr($ex);
  is($actual, $expected, $ex);
}

