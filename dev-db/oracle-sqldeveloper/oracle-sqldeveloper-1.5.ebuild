# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PA="${PN/oracle-/}-5440-no-jre"
MY_P="${P/oracle-/}"
MY_PN="${PN/oracle-/}"

S=${WORKDIR}
DESCRIPTION="Oracle SQL Developer"
HOMEPAGE="http://www.oracle.com/technology/products/database/sql_developer/index.html"
SRC_URI="${MY_PA}.zip"

LICENSE="OTN"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="virtual/jre"

my_arch() {
		export MY_PA=${!MY_PA}
}

pkg_setup() {
		#my_arch
		elog ${MY_PA}
}

pkg_nofetch() {
		my_arch
		"Please go to:"
		eerror "  ${HOMEPAGE}"
		eerror "Download the Oracle SQL Developer for other platforms"
		eerror "  ${MY_PA}.zip"
		eerror "Then after downloading put them in:"
		eerror "  ${DISTDIR}"
}

src_unpack() {
		unzip "${DISTDIR}"/${MY_PA}.zip || die "unsuccesful unzip ${MY_P}.zip"
}

src_install() {
		mkdir -p ${D}/usr/{lib/${MY_P},bin}
		chmod +x ${S}/sqldeveloper/sqldeveloper.sh
		echo '#!/bin/bash' > ${D}/usr/bin/sqldeveloper
		echo "" >> ${D}/usr/bin/sqldeveloper
		echo 'OLD=$PWD' >> ${D}/usr/bin/sqldeveloper
		echo "" >> ${D}/usr/bin/sqldeveloper
		echo "cd /usr/lib/${MY_P}" >> ${D}/usr/bin/sqldeveloper
		echo 'if [ -x sqldeveloper.sh ]; then' >> ${D}/usr/bin/sqldeveloper
		echo '    ./sqldeveloper.sh &' >> ${D}/usr/bin/sqldeveloper
		echo "    exit 0" >> ${D}/usr/bin/sqldeveloper
		echo "fi" >> ${D}/usr/bin/sqldeveloper
		echo "" >> ${D}/usr/bin/sqldeveloper
		echo 'cd $OLD' >> ${D}/usr/bin/sqldeveloper
		echo "" >> ${D}/usr/bin/sqldeveloper
		chmod +x ${D}/usr/bin/sqldeveloper
		mv ${S}/sqldeveloper/* ${D}/usr/lib/${MY_P}/
		dosym /usr/lib/${MY_P} /usr/lib/${MY_PN}
#		dosym /usr/lib/${MY_PN}/sqldeveloper.sh /usr/bin/sqldeveloper
}

pkg_postinst() {
		elog "The Oracle SQL Developer 1.5 has been installed."
}
