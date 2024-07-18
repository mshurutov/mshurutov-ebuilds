# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Xreader is a document viewer for Linux Mint"
HOMEPAGE="https://github.com/linuxmint/xreader"
EGIT_REPO_URI="https://github.com/linuxmint/${PN}.git"
EGIT_COMMIT=${PV}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+djvu +dvi +introspection rar +t1lib"

DEPEND="
	introspection? ( dev-libs/gobject-introspection )
	dev-util/intltool
	app-arch/libarchive
	djvu? (
		app-text/djvu
	)
	x11-libs/gtk+:3
	dev-libs/glib
	app-text/libgxps
	dvi? (
		app-text/libspectre
		dev-libs/kpathsea
	)
	app-text/poppler[cairo]
	app-crypt/libsecret
	x11-libs/libSM
	media-libs/tiff
	net-libs/webkit-gtk
	x11-libs/xapp
	x11-libs/libX11
	dev-libs/libxml2
	sys-apps/lsb-release
	mate-base/mate-common
	dev-libs/libxslt
	app-text/yelp-tools
	sys-libs/zlib
	media-libs/t1lib
	x11-libs/gdk-pixbuf
	rar? ( app-arch/unrar )
"
RDEPEND="${DEPEND}
	gnome-base/gvfs
"
BDEPEND="
	dev-build/meson
"

src_configure() {
	local emesonargs=(
		$(
			$(meson_feature djvu)
			$(meson_feature dvi)
			$(meson_feature t1lib)
			-Dpixbuf=enabled
			-Dcomics=enabled
			$(meson_use introspection)
		)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
