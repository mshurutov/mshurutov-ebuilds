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
IUSE="+djvu dvi +epub +introspection +pdf rar t1lib tiff xps"

DEPEND="
	>=app-arch/libarchive-3.6.0
	>=app-crypt/libsecret-0.5
	app-text/yelp-tools
	>=dev-libs/glib-2.36.0
	>=dev-libs/libxml2-2.5.0
	dev-libs/libxslt
	dev-libs/mathjax
	dev-util/intltool
	mate-base/mate-common
	sys-apps/lsb-release
	sys-libs/zlib
	>=x11-libs/gtk+-3.14.0:3[cups]
	x11-libs/libSM
	x11-libs/libX11
	>=x11-libs/xapp-2.5.0
	djvu? ( >=app-text/djvu-3.5.17 )
	dvi? (
		>=app-text/libspectre-0.2.0
		dev-libs/kpathsea
	)
	epub? ( >=net-libs/webkit-gtk-2.4.3 )
	introspection? ( dev-libs/gobject-introspection )
	pdf? (
		>=x11-libs/cairo-1.14.0
		app-text/poppler[cairo]
	)
	rar? ( app-arch/unrar )
	t1lib? ( media-libs/t1lib )
	tiff? ( media-libs/tiff )
	xps? ( >=app-text/libgxps-0.2.1 )
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
			-Dpixbuf=true
			-Dcomics=true
			$(meson_use djvu)
			$(meson_use dvi)
			$(meson_use epub)
			$(meson_use introspection)
			$(meson_use pdf)
			$(meson_use rar)
			$(meson_use t1lib)
			$(meson_use tiff)
			$(meson_use xps)
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
