# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 python3_13 )

inherit distutils-r1 pypi

DESCRIPTION=""
HOMEPAGE="
	https://github.com/slacr44/snxvpn
"
SRC_URI="
	https://github.com/slacr44/snxvpn/archive/refs/heads/master.zip
"

S="${WORKDIR}/${PN}-master"

LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
"
BDEPEND="$RDEPEND"

distutils_enable_tests pytest
