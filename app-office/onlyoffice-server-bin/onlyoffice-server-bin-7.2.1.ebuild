# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

MY_P="ONLYOFFICE-DesktopEditors-"${PV}""

DESCRIPTION="Onlyoffice is an office productivity suite (binary version)"
HOMEPAGE="https://www.onlyoffice.com/"
SRC_URI="
	amd64? (
		https://github.com/ONLYOFFICE/DesktopEditors/releases/download/v"${PV}"/onlyoffice-desktopeditors_amd64.deb -> "${P}"_amd64.deb
	)
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip test"

RDEPEND="
	!app-office/onlyoffice
	app-admin/logrotate
	app-admin/pwgen
	app-admin/supervisor
	app-misc/ca-certificates
	|| (
		dev-db/mysql
		dev-db/postgresql
		dev-db/mariadb
	)
	dev-libs/libxml2
	gnome-base/gconf
	net-misc/curl
	media-fonts/corefonts
	media-libs/alsa-lib
	sys-apps/coreutils
	sys-libs/zlib
	www-servers/nginx
	x11-base/xorg-server[xvfb]
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
"

S="${WORKDIR}"

src_install() {
	for size in {16,24,32,48,64,128,256}; do
		newicon -s "${size}" opt/onlyoffice/desktopeditors/asc-de-"${size}".png onlyoffice-desktopeditors.png
	done

	dobin usr/bin/desktopeditors usr/bin/onlyoffice-desktopeditors
	doins -r opt
	fperms +x /opt/onlyoffice/desktopeditors/{DesktopEditors,editors_helper,converter/x2t}
}

