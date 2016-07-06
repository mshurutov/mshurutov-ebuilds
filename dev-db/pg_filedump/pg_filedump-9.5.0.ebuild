# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-r3 prefix

MY_PV="REL${PV/\./_}"

DESCRIPTION="Display formatted contents of a PostgreSQL heap, index, or control file."
HOMEPAGE="http://pgfoundry.org/projects/pgfiledump"
EGIT_REPO_URI="git://git.postgresql.org/git/pg_filedump.git"

LICENSE="POSTGRESQL GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-db/postgresql[static-libs]"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin/
	dobin pg_filedump

	docinto /usr/share/doc/pg_filedump/
	dodoc README.pg_filedump
}

