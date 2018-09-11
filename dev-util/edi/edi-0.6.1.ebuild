# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="An EFL based / focussed IDE for Linux"
HOMEPAGE="https://www.enlightenment.org/about-edi"
SRC_URI="https://github.com/Enlightenment/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+clang"

RDEPEND=">=dev-libs/efl-1.18.0[eet,X]"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	dev-libs/check
	clang? ( sys-devel/clang )
"

src_configure() {
	local emesonargs=()
	if use clang; then
		emesonargs=(
			-D libclang-headerdir=$(llvm-config --includedir)
			-D libclang-libdir=$(llvm-config --libdir)
		)
	else
		emesonargs=(
			-D libclang=false
		)
	fi

	meson_src_configure
}

