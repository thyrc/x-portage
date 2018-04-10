# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin

DESCRIPTION="vim plugin: Next generation completion framework after neocomplcache"
HOMEPAGE="https://github.com/Shougo/neocomplete.vim"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-editors/vim[luajit]
	!app-vim/neocomplcache
"

SRC_URI="https://github.com/Shougo/neocomplete.vim/archive/ver.${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}.vim-ver.${PV}"

VIM_PLUGIN_HELPFILES="${PN}.txt"
