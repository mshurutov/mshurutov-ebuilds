# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Cobbler is a versatile Linux deployment server."
HOMEPAGE="https://cobbler.github.io/"
SRC_URI="https://github.com/${P}/${P}/archive/refs/tags/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	|| (
		www-servers/apache
		www-servers/lighttpd
		www-servers/nginx
	)
	|| (net-misc/curl net-misc/wget)
	createrepo_c
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

