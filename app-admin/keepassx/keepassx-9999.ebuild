# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils xdg git-r3

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://www.keepassx.org/"
EGIT_REPO_URI="git://github.com/keepassx/keepassx.git"
EGIT_BRANCH="master"

LICENSE="|| ( GPL-2 GPL-3 ) BSD GPL-2 LGPL-2.1 LGPL-3+ CC0-1.0 public-domain || ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="
	dev-libs/libgcrypt:0=
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qttest
	dev-qt/qtx11extras
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXtst
"
RDEPEND="${DEPEND}"

DOCS=(CHANGELOG)

src_prepare() {
	xdg_src_prepare
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_TESTS="$(usex test)"
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	xdg_pkg_preinst
}
pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
