# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby18"
EGIT_REPO_URI="git://github.com/vootey/yac.git"

[[ ${PV} == "9999" ]] && GIT_ECLASS="git-2"

inherit ruby-ng ${GIT_ECLASS}

DESCRIPTION="A simple and intuitive cli calculator"
HOMEPAGE="https://github.com/vootey/yac"
#[[ ${PV} == "9999" ]] || SRC_URI="http://${PN}.org/files/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
if [[ ${PV} == "9999" ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi

IUSE=""

src_install() {
	cd "./"
	dobin yac || die

	cd "../lib/"
	dolib *.rb || die

	cd "../man/"
	doman "*.1" || die
}
