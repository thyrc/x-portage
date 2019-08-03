# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson xdg-utils

EGIT_REPO_URI="https://git.enlightenment.org/core/${PN}.git"
EGIT_BRANCH="efl-1.22"
EGIT_COMMIT="0e7a833fc3077c782c0a8a4e264790ed1aea5ee1"

DESCRIPTION="Enlightenment Foundation Libraries all-in-one package"
HOMEPAGE="https://www.enlightenment.org"
SRC_URI="https://download.enlightenment.org/rel/libs/${PN}/${P}.tar.xz"

LICENSE="BSD-2 GPL-2 LGPL-2.1 ZLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="+bmp dds connman debug drm +eet elogind examples fbcon +fontconfig fribidi gif gles2 glib gnutls gstreamer harfbuzz hyphen +ico ibus jpeg2k libressl libuv luajit nls opengl ssl pdf physics postscript +ppm +psd pulseaudio raw scim sdl sound static-libs svg +system-lz4 systemd tga tiff tslib unwind v4l vlc vnc wayland webp X xcf xim xine xpm xpresent zeroconf"

REQUIRED_USE="
	?? ( elogind systemd )
	?? ( gles2 opengl )
	fbcon? ( !tslib )
	gles2? (
		|| ( wayland X )
		!sdl
	)
	ibus? ( glib )
	opengl? ( X )
	pulseaudio? ( sound )
	sdl? ( opengl )
	vnc? ( fbcon X )
	wayland? ( gles2 !opengl )
	xim? ( X )
	xpresent? ( X )
"

RDEPEND="
	net-misc/curl
	media-libs/libpng:0=
	sys-apps/dbus
	sys-apps/util-linux
	virtual/jpeg:0=
	connman? ( net-misc/connman )
	drm? (
		dev-libs/libinput
		media-libs/mesa[gbm]
		x11-libs/libdrm
		x11-libs/libxkbcommon
	)
	elogind? ( sys-auth/elogind )
	fontconfig? ( media-libs/fontconfig )
	fribidi? ( dev-libs/fribidi )
	gif? ( media-libs/giflib:= )
	gles2? ( media-libs/mesa[egl,gles2] )
	glib? ( dev-libs/glib:2 )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
	)
	harfbuzz? ( media-libs/harfbuzz )
	hyphen? ( dev-libs/hyphen )
	ibus? ( app-i18n/ibus )
	jpeg2k? ( media-libs/openjpeg:= )
	libuv? ( dev-libs/libuv )
	luajit? ( dev-lang/luajit:= )
	!luajit? ( dev-lang/lua:* )
	nls? ( sys-devel/gettext )
	pdf? ( app-text/poppler:=[cxx] )
	physics? ( sci-physics/bullet:= )
	postscript? ( app-text/libspectre )
	pulseaudio? ( media-sound/pulseaudio )
	raw? ( media-libs/libraw:= )
	scim? ( app-i18n/scim )
	sdl? (
		media-libs/libsdl2
		virtual/opengl
	)
	sound? ( media-libs/libsndfile )
	ssl? (
		gnutls? ( net-libs/gnutls:= )
		!gnutls? (
			!libressl? ( dev-libs/openssl:0= )
			libressl? ( dev-libs/libressl:= )
		)
	)
	svg? (
		gnome-base/librsvg
		x11-libs/cairo
	)
	system-lz4? ( app-arch/lz4 )
	systemd? ( sys-apps/systemd:= )
	tiff? ( media-libs/tiff:0= )
	tslib? ( x11-libs/tslib:= )
	unwind? ( sys-libs/libunwind )
	vlc? ( media-video/vlc )
	vnc? ( net-libs/libvncserver )
	wayland? (
		dev-libs/wayland
		media-libs/mesa[gles2,wayland]
		x11-libs/libxkbcommon
	)
	webp? ( media-libs/libwebp:= )
	X? (
		media-libs/freetype
		x11-libs/libXcursor
		x11-libs/libX11
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXtst
		x11-libs/libXScrnSaver
		gles2? (
			x11-libs/libX11
			x11-libs/libXrender
			virtual/opengl
		)
		opengl? (
			x11-libs/libX11
			x11-libs/libXrender
			virtual/opengl
		)
	)
	xine? ( media-libs/xine-lib )
	xpm? ( x11-libs/libXpm )
	xpresent? ( x11-libs/libXpresent )
	zeroconf? ( net-dns/avahi )
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
        "${FILESDIR}/${P}-fix_missing_header.patch"
        "${FILESDIR}/${P}-fix_wayland_include.patch"
        "${FILESDIR}/${P}-update_meson_dependency.patch"
)

src_prepare() {
	default
}

src_configure() {
	local emesonargs=(
		-Deeze=true
		-Dlibmount=true
		-Dxinput22=true

		-Dbuild-tests=false
		-Dcocoa=false
		-Deina-magic-debug=false
		-Dgstreamer=false
		-Dpixman=false
		-Dxgesture=false

		$(meson_use drm)
		$(meson_use elogind)
		$(meson_use examples build-examples)
		$(meson_use fbcon fb)
		$(meson_use fontconfig)
		$(meson_use fribidi)
		$(meson_use glib)
		$(meson_use gstreamer)
		$(meson_use harfbuzz)
		$(meson_use hyphen)
		$(meson_use nls)
		$(meson_use physics)
		$(meson_use pulseaudio)
		$(meson_use sdl)
		$(meson_use sound audio)
		$(meson_use !system-lz4 embedded-lz4)
		$(meson_use systemd)
		$(meson_use tslib)
		$(meson_use v4l v4l2)
		$(meson_use vnc vnc-server)
		$(meson_use wayland wl)
		$(meson_use X x11)
		$(meson_use xpresent)
		$(meson_use zeroconf avahi)

		-Dcrypto=$(usex gnutls gnutls $(usex ssl openssl none))
		-Dnetwork-backend=$(usex connman connman none)
		-Dlua-interpreter=$(usex luajit luajit lua)
	)

	if use opengl ; then
		emesonargs+=( -Dopengl=full )
	elif use gles2 ; then
		emesonargs+=( -Dopengl=es-egl )
	elif use drm && use wayland ; then
		emesonargs+=( -Dopengl=es-egl )
	else
		emesonargs+=( -Dopengl=none )
	fi

	local imf_list
	for imf in xim ibus scim ; do
		if ! use ${imf} ; then
			[[ -n "${imf_list}" ]] && imf_list="${imf_list},"
			imf_list="${imf_list}${imf}"
		fi
	done
	emesonargs+=( -Decore-imf-loaders-disabler=${imf_list} )

	local evas_loader_list
	for evas_loader in pdf raw svg xcf bmp dds eet gif ico jpeg2k webp postscript ppm psd tga tiff xpm; do
		if ! use ${evas_loader} ; then
			[[ -n "${evas_loader_list}" ]] && evas_loader_list="${evas_loader_list},"
			evas_loader_list="${evas_loader_list}${evas_loader}"
		fi
	done
	evas_loader_list="${evas_loader_list//postscript/ps}"
	evas_loader_list="${evas_loader_list//jpeg2k/jp2k}"
	evas_loader_list="${evas_loader_list//ppm/pmaps}"
	emesonargs+=( -Devas-loaders-disabler=${evas_loader_list} )

	local emotion_loader_list
	for emotion_loader in gstreamer vlc xine ; do
		if ! use ${emotion_loader} ; then
			[[ -n "${emotion_loader_list}" ]] && emotion_loader_list="${emotion_loader_list},"
			emotion_loader_list="${emotion_loader_list}${emotion_loader}"
		fi
	done
	emotion_loader_list="${emotion_loader_list//vlc/libvlc}"
	emotion_loader_list="${emotion_loader_list//gstreamer/gstreamer1}"
	[[ -n "${emotion_loader_list}" ]] && emotion_loader_list="${emotion_loader_list},"
	emotion_loader_list="${emotion_loader_list}gstreamer"
	emesonargs+=( -Demotion-loaders-disabler=${emotion_loader_list} )

	# 	--with-js=none

	# 	$(use_enable static-libs static)

	# 	$(use_enable libuv)
	# 	$(use_enable neon)

	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
	einstalldocs

	if ! use static-libs ; then
		find "${D}" -name '*.la' -delete || die
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
