# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit vim-plugin

DESCRIPTION="vim plugin: automatically align SQL code"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=492"
LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

MY_PV="${PV/\./}0"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=19113 -> ${PN}_${MY_PV}.zip"

S=${WORKDIR}

RDEPEND="
	app-vim/autoalign
	"

VIM_PLUGIN_HELPFILES="autoalign"
VIM_PLUGIN_MESSAGES="filetype"

#src_prepare() {
	# Don't use the cecutil.vim included in the tarball, use the one
	# provided by app-vim/cecutil instead.
#	rm plugin/cecutil.vim || die
#}
