# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils linux-info user

DESCRIPTION="MediaTomb is an open source UPnP MediaServer"
HOMEPAGE="http://www.mediatomb.cc/"

SRC_URI="https://github.com/gerbera/gerbera/archive/mediatomb-0.12.2_pre20160522.tar.gz -> mediatomb_0.12.2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc x86"

IUSE="curl debug +exif +ffmpeg id3tag +inotify +javascript lastfm
		libextractor +magic +mp4 mysql +sqlite +taglib thumbnail"
REQUIRED_USE="
	|| ( mysql sqlite )
	taglib? ( !id3tag )
	id3tag? ( !taglib )
	thumbnail? ( ffmpeg !libextractor )
	ffmpeg? ( !libextractor )
	libextractor? ( !ffmpeg !thumbnail )
"

DEPEND="mysql? ( virtual/mysql )
	dev-libs/expat
	id3tag? ( media-libs/id3lib )
	javascript? ( >=dev-lang/spidermonkey-1.8.5:0 )
	taglib? ( media-libs/taglib )
	sqlite? ( >=dev-db/sqlite-3 )
	lastfm? ( >=media-libs/lastfmlib-0.4 )
	exif? ( media-libs/libexif )
	libextractor? ( media-libs/libextractor )
	mp4? ( >=media-libs/libmp4v2-1.9.1_p479:0 )
	ffmpeg? ( media-video/ffmpeg )
	thumbnail? ( media-video/ffmpegthumbnailer[jpeg] )
	curl? ( net-misc/curl net-misc/youtube-dl )
	magic? ( sys-apps/file )
	sys-apps/util-linux
	sys-libs/zlib
	virtual/libiconv
"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~INOTIFY_USER"

S="${WORKDIR}/gerbera-${P}_pre20160522"

pkg_setup() {
	enewgroup mediatomb
	enewuser mediatomb -1 -1 /dev/null mediatomb
}

src_prepare() {
	eapply "${FILESDIR}"/${PN}-0.12.1-threadpool.patch
	eapply "${FILESDIR}"/${PN}-0.12.1-fix_includes.patch

	eapply_user

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable curl) \
		$(use_enable curl youtube) \
		$(use_enable debug tombdebug) \
		$(use_enable exif libexif) \
		$(use_enable ffmpeg) \
		$(use_enable id3tag id3lib) \
		$(use_enable inotify) \
		$(use_enable javascript libjs) \
		$(use_enable lastfm) \
		$(use_enable magic libmagic) \
		$(use_enable mp4 libmp4v2) \
		$(use_enable mysql) \
		$(use_enable sqlite sqlite3) \
		$(use_enable taglib) \
		$(use_enable thumbnail ffmpegthumbnailer) \
		--disable-flac \
		--enable-external-transcoding \
		--enable-protocolinfo-extension
}

src_install() {
	default

	newinitd "${FILESDIR}"/${PN}-0.12.1.initd ${PN}
	use mysql || sed -i -e "/use mysql/d" "${ED}"/etc/init.d/${PN}
	newconfd "${FILESDIR}"/${PN}-0.12.0.confd ${PN}

	insinto /etc/mediatomb
	newins "${FILESDIR}/${PN}-0.12.0.config" config.xml
	fperms 0600 /etc/mediatomb/config.xml
	fowners mediatomb:mediatomb /etc/mediatomb/config.xml

	keepdir /var/lib/mediatomb
	fowners mediatomb:mediatomb /var/lib/mediatomb
}

pkg_postinst() {
	if use mysql ; then
		elog "MediaTomb has been built with MySQL support and needs"
		elog "to be configured before being started."
		elog "For more information, please consult the MediaTomb"
		elog "documentation: http://mediatomb.cc/pages/documentation"
		elog
	fi

	elog "To configure MediaTomb edit:"
	elog "/etc/mediatomb/config.xml"
	elog
	elog "The MediaTomb web interface can be reached at (after the service is started):"
	elog "http://localhost:49152/"
}
