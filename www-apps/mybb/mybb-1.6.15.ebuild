# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpBB/phpBB-3.0.12.ebuild,v 1.1 2013/12/02 21:10:31 radhermit Exp $

EAPI=5

inherit webapp

DESCRIPTION="MyBB is an open-source bulletin board package"
HOMEPAGE="http://www.mybb.com/"
SRC_URI="http://resources.mybb.com/downloads/${PN}_${PV//\./}.zip"

LICENSE="GPL-3"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="postgres mysql sqlite"
REQUIRED_USE="
        || ( mysql postgres sqlite )
"

RDEPEND="virtual/httpd-php
	dev-lang/php[simplexml,unicode,gd]
	postgres? ( dev-lang/php[postgres] )
	mysql? ( dev-lang/php[mysql] )
	sqlite? ( dev-lang/php[sqlite] )"

need_httpd_cgi

S=${WORKDIR}/Upload

src_install() {
	webapp_src_preinst

	cp "${S}"/inc/config.default.php "${S}"/inc/config.php
	insinto "${MY_HTDOCSDIR}"
	doins -r .

	fperms 777 "${MY_HTDOCSDIR}"/cache/
	fperms 777 "${MY_HTDOCSDIR}"/cache/themes/
	fperms 777 "${MY_HTDOCSDIR}"/uploads/
	fperms 777 "${MY_HTDOCSDIR}"/uploads/avatars/
	fperms 777 "${MY_HTDOCSDIR}"/admin/backups/
	fperms 666 "${MY_HTDOCSDIR}"/inc/config.php
	fperms 666 "${MY_HTDOCSDIR}"/inc/settings.php
	pushd "${MY_HTDOCSDIR}"/inc/languages/english/
	for file in *.php ; do
		fperms 666 ${file}
	done
	popd
	pushd "${MY_HTDOCSDIR}"/inc/languages/english/admin/
	for file in *.php ; do
		fperms 666 ${file}
	done
	popd

	webapp_serverowned "${MY_HTDOCSDIR}"/cache/
	webapp_serverowned "${MY_HTDOCSDIR}"/cache/themes/
	webapp_serverowned "${MY_HTDOCSDIR}"/uploads/
	webapp_serverowned "${MY_HTDOCSDIR}"/uploads/avatars/
	webapp_serverowned "${MY_HTDOCSDIR}"/admin/backups/
	webapp_serverowned "${MY_HTDOCSDIR}"/inc/config.php
	webapp_serverowned "${MY_HTDOCSDIR}"/inc/settings.php
	webapp_configfile  "${MY_HTDOCSDIR}"/inc/config.php

	webapp_src_install
}
