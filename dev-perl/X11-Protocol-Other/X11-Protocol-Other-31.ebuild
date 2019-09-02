# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=KRYDE
DIST_VERSION=31
DIST_EXAMPLES=("examples/*")
inherit perl-module virtualx

DESCRIPTION="window manager things for client programs"

LICENSE="${LICENSE} MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/X11-Protocol"
DEPEND="${RDEPEND}"

src_test() {
	virtx perl-module_src_test
}
