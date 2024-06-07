# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )

inherit autotools multilib git-r3 systemd python-any-r1

DESCRIPTION="Koan stands for kickstart-over-a-network"
HOMEPAGE="https://github.com/cobbler/koan"
EGIT_REPO_URI="https://github.com/cobbler/${PN}.git"
EGIT_COMMIT="v${PV}"
#SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/distro
	dev-python/netifaces
	dev-python/libvirt-python
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-python/sphinx
"
