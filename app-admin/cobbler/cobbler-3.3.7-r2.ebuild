# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )

inherit autotools multilib git-r3 systemd python-any-r1

DESCRIPTION="Cobbler is a versatile Linux deployment server."
HOMEPAGE="https://cobbler.github.io/"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
EGIT_COMMIT="v${PV}"
#SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="apache lighttpd +nginx"
REQUIRED_USE="^^ ( apache lighttpd nginx )"

DEPEND="
	apache? ( www-servers/apache )
	lighttpd? ( www-servers/lighttpd )
	nginx? ( www-servers/nginx )
	|| ( net-misc/curl net-misc/wget )
	|| ( net-ftp/atftp net-ftp/tftp-hpa )
	app-arch/createrepo_c
	app-admin/koan
	dev-libs/libisoburn
	dev-python/cheetah3
	dev-python/distro
	dev-python/dnspython
	dev-python/librepo
	dev-python/python-magic
	dev-python/netaddr
	dev-python/pyyaml
	dev-python/requests
	dev-python/schema
	net-misc/rsync
	sys-boot/syslinux
	sys-cluster/fence-agents
	www-servers/gunicorn
"

RDEPEND="${DEPEND}"
BDEPEND="
	dev-vcs/git
	dev-build/make
	dev-python/sphinx
	dev-python/coverage
	dev-libs/openssl
"
PATCHES=(
	# Return valid distro name and distro version
	"${FILESDIR}/${PV}/${P}-00-set-os_release.patch"
)

src_prepare() {
	if use nginx; then
		sed -ie 's/@@httpd_service@@/nginx.service/' config/service/cobblerd.service
	fi
	if use apache; then
		sed -ie 's/@@httpd_service@@/apache2.service' config/service/cobblerd.service
	fi
	if use lighttpd; then
		sed -ie 's/@@httpd_service@@/lighttpd.service' config/service/cobblerd.service
	fi
	default
}
src_install() {

	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi
	einstalldocs
	keepdir /var/log/cobbler/

	if use nginx; then
		insinto /etc/nginx/conf.d
		doins ${FILESDIR}/nginx/cobbler.conf
	fi

	systemd_dounit config/service/cobblerd.service
	systemd_dounit config/service/cobblerd-gunicorn.service
}
