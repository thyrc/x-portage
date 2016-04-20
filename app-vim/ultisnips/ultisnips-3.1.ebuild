# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VIM_PLUGIN_VIM_VERSION="7.0"
inherit git-2 vim-plugin

DESCRIPTION="vim plugin: The Ultimate Snippet Solution for Vim"
HOMEPAGE="https://github.com/sirver/ultisnips"
SRC_URI=""
EGIT_REPO_URI="https://github.com/SirVer/ultisnips.git"
LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-editors/vim[python]"

# VIM_PLUGIN_HELPFILES=""
# VIM_PLUGIN_HELPTEXT=""
# VIM_PLUGIN_HELPURI=""
# VIM_PLUGIN_MESSAGES=""

