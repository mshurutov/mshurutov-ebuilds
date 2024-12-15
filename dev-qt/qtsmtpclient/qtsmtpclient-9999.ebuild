# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="SMTP Client for Qt"
HOMEPAGE="https://github.com/petrovvlad/SmtpClient-for-Qt"
EGIT_REPO_URI="https://github.com/petrovvlad/SmtpClient-for-Qt.git"
EGIT_BRANCH="master"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

#S="${WORKDIR}/SmtpClient-for-Qt"

RDEPEND="
	dev-qt/qtbase:6
	dev-qt/qtnetwork:5"

