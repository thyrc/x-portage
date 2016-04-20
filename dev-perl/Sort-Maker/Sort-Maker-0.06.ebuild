# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=URI
MODULE_VERSION=0.06

inherit perl-module

DESCRIPTION="A simple way to make efficient sort subs"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"

IUSE="test"
SRC_TEST=do

DEPEND="test? ( virtual/perl-Test-Simple )"
