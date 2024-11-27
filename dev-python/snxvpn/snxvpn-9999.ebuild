# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1 git-r3

DESCRIPTION=""
EGIT_REPO_URI="
	https://github.com/slacr44/snxvpn
"


LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/beautifulsoup4
	dev-python/pycryptodome
	dev-python/lxml
	dev-python/rsa
"
BDEPEND="
	$RDEPEND
"

distutils_enable_tests pytest
