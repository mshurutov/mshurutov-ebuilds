# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=hatchling
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1 pypi cmake

DESCRIPTION=""
HOMEPAGE="
	https://github.com/rpm-software-management/librepo
"
SRC_URI="
	https://github.com/rpm-software-management/librepo/archive/refs/tags/${PV}.tar.gz
			-> ${P}.tar.gz
"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="selinux test"

RDEPEND="
"
BDEPEND="
	test? (
		dev-python/pyxattr
	)
	dev-libs/check
	dev-util/cmake
	sys-devel/gcc
	selinux? (
		sys-libs/libselinux
	)
	dev-libs/glib
	sys-apps/attr
	net-misc/curl
	dev-libs/openssl
	app-crypt/gpgme[python]
"

distutils_enable_tests pytest

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package selinux libselinux)
	)
	cmake_src_configure
}
