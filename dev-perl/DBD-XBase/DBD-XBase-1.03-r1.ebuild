# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

MODULE_AUTHOR=JANPAZ

inherit perl-module

DESCRIPTION="DBI driver for XBase compatible database files"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-perl/Module-Build
	test? ( virtual/perl-Test-Simple )
"
RDEPEND=""

SRC_TEST="do"
