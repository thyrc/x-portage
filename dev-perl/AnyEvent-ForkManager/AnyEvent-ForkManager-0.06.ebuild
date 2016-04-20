# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=KARUPA
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="A simple parallel processing fork manager with AnyEvent"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-perl/AnyEvent-5.330.0
"
DEPEND="
    ${RDEPEND}
	dev-perl/Module-Build
	dev-perl/Class-Accessor-Lite
"

#SRC_TEST="do"
