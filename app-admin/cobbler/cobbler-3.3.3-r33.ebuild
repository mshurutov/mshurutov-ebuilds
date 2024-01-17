# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit autotools multilib git-r3 systemd python-any-r1

DESCRIPTION="Cobbler is a versatile Linux deployment server."
HOMEPAGE="https://cobbler.github.io/"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
if [ "${PR}" = "r0" ]; then
	EGIT_COMMIT="v${PV}"
	PATCHES=(
		"${FILESDIR}/00_${PN}-remove-setup_command.patch"
	)
else
	EGIT_BRANCH="${PR/r/release}"
fi
#SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"


DEPEND="
	|| (
		www-servers/nginx
		www-servers/apache
		www-servers/lighttpd
	)
	|| ( net-misc/curl net-misc/wget )
	app-arch/createrepo_c
	dev-libs/libisoburn
	www-servers/gunicorn
	dev-python/cheetah3
	dev-python/dnspython
	dev-python/requests
	dev-python/distro
	dev-python/netaddr
	dev-python/librepo
	dev-python/schema
	dev-python/pyyaml
	sys-cluster/fence-agents
	net-misc/rsync
	sys-boot/syslinux
	|| ( net-ftp/atftp net-ftp/tftp-hpa )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-vcs/git
	sys-devel/make
	dev-python/sphinx
	dev-python/coverage
	dev-libs/openssl
"
src_install() {

	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi
	einstalldocs

	systemd_dounit config/service/cobblerd.service
	systemd_dounit ${FILESDIR}/cobblerd-gunicorn.service
}
