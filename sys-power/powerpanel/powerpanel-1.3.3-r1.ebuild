# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

ZIPPV=${PV//./}
MY_PN="PPL"
DESCRIPTION="Software for CyberPower Systems UPS devices"
HOMEPAGE="https://www.cyberpowersystems.com/products/software/pppe-linux-software"
SRC_URI="x86? ( https://dl4jz3rbrsfum.cloudfront.net/software/${MY_PN}-${PV}-32bit.tar.gz )
		amd64? ( https://dl4jz3rbrsfum.cloudfront.net/software/${MY_PN}-${PV}-64bit.tar.gz )"

LICENSE="PowerPanel"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND=""
RDEPEND="virtual/libusb:0"

src_install() {
	dosbin bin/pwrstat{,d}
	doman doc/pwrstat{,d}.8
	dodoc doc/{README,LICENSE,install-guide,user-manual,deploy-guide}

	insinto /etc
	doins conf/pwrstatd.conf

	exeinto /etc
	doexe script/{pwrstatd-{email,powerfail,lowbatt},shutdown,hibernate}.sh

	newinitd script/default_pwrstatd pwrstatd

	fowners root:root /usr/sbin/pwrstat{,d}
	fowners root:root /etc/{shutdown,hibernate,pwrstatd-{powerfail,lowbatt,email}}.sh
	fowners root:root /etc/init.d/pwrstatd
	fowners root:root /etc/pwrstatd.conf

	fperms 700 /usr/sbin/pwrstat{,d}
	fperms 700 /etc/{shutdown,hibernate,pwrstatd-{powerfail,lowbatt,email}}.sh
	fperms 700 /etc/init.d/pwrstatd
	fperms 700 /etc/pwrstatd.conf

	if use systemd; then
		insinto /lib/systemd/system/
		doins ${FILESDIR}/powerpanel.service
	fi
}

pkg_postinst()
{
	if use systemd; then
		systemctl daemon-reload
	fi
}
