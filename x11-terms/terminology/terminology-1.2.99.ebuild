# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson xdg-utils

DESCRIPTION="Feature rich terminal emulator using the Enlightenment Foundation Libraries"
HOMEPAGE="https://www.enlightenment.org/about-terminology"
EGIT_COMMIT="80e36857a28bb2a0b0fdd58b0cd86b110a180efc"
SRC_URI="https://git.enlightenment.org/apps/terminology.git/snapshot/${PN}-${EGIT_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls"

RDEPEND="
	|| ( dev-libs/efl[egl] dev-libs/efl[opengl] )
	|| ( dev-libs/efl[X] dev-libs/efl[wayland] )
	app-arch/lz4
	>=dev-libs/efl-1.20.0[eet,fontconfig]
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

src_prepare() {
	default
	xdg_environment_reset
}

src_configure() {
	local emesonargs=(
		-D nls=$(usex nls true false)
	)

	meson_src_configure
}
