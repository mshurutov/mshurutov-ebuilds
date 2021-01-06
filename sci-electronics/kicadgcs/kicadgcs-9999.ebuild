# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="KiCAD CGS library based on russian standarts aka GOSTs"
HOMEPAGE="https://sourceforge.net/projects/kicadcgi/"
SRC_URI="mirror://sourceforge/project/kicadcgi/KicadCGS.zip"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sci-electronics/kicad
		app-arch/unzip"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	insinto /usr/share/kicad/library
	doins library/*
}
