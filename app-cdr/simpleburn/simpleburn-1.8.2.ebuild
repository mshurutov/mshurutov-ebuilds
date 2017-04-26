# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="SimpleBurn is a minimalistic application for burning and extracting CDs and DVDs."
HOMEPAGE="http://simpleburn.tuxfamily.org/-Home-"
SRC_URI="http://simpleburn.tuxfamily.org/IMG/gz/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk2 gtk3"
REQUIRED_USE="^^ ( gtk2 gtk3 )"

DEPEND="
gtk2? ( x11-libs/gtk+:2 )
gtk3? ( x11-libs/gtk+:3 )
virtual/cdrtools
media-video/mplayer[dvd,xvid,cdio,mp3]
dev-libs/libcdio[cddb]
|| ( media-libs/audiofile[flac] media-libs/libsndfile[-minimal] )
media-sound/vorbis-tools
media-video/smplayer
"

RDEPEND="${DEPEND}"
