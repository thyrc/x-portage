# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

DIST_AUTHOR=SALVA
DIST_VERSION=0.14
inherit perl-module

DESCRIPTION="Run SSH jobs in parallel"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"

RDEPEND="
	dev-perl/Net-OpenSSH
"
DEPEND="${RDEPEND}"
