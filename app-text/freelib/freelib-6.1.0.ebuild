# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# original is placed on https://bugs.gentoo.org/297197
# by  Dmitry S. Kulyabov 

EAPI=8

inherit cmake

CMAKE_MAKEFILE_GENERATOR=emake

DESCRIPTION="Freelib is book library manager"
HOMEPAGE="https://github.com/petrovvlad/freeLib"
SRC_URI="https://github.com/petrovvlad/freeLib/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"
S=${WORKDIR}/freeLib-${PV}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	dev-qt/qtbase:6
	dev-qt/qtsvg:6
	dev-qt/qthttpserver:6
	dev-qt/qt5compat:6
	dev-qt/qtwebsockets:6
	dev-qt/qtsmtpclient
	dev-libs/quazip[qt6]
	"

DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DFREELIB_QT_MAJOR_VERSION=6
		-DCMAKE_BUILD_TYPE=Release
	)

	# cmake_src_configure
	mkdir -p ${S}_build
	cd ${S}_build
	cmake ${S} ${mycmakeargs} -DCMAKE_INSTALL_PREFIX=/usr
}

