# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

USE_RUBY="ruby18"
EGIT_REPO_URI="git://github.com/vootey/yac.git"

inherit ruby-ng

DESCRIPTION="A simple and intuitive cli calculator"
HOMEPAGE="https://github.com/vootey/yac"

GITHUB_USER="vootey"
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/tarball/v${PV} -> ${P}.tgz"
RUBY_S="${GITHUB_USER}-${PN}-*"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

src_install() {
	cd "${RUBY_S}"
	echo `ls`
#	cd "./"
#	dobin yac || die

#	cd "../lib/"
#	dolib *.rb || die
#
#	cd "../man/"
#	doman "*.1" || die
}
