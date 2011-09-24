# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

USE_RUBY="ruby18 ruby19"
RUBY_FAKEGEM_TASK_TEST="test"

inherit ruby-fakegem

DESCRIPTION="A simple and intuitive cli calculator"
HOMEPAGE="https://github.com/vootey/yaclic"

GITHUB_USER="vootey"
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/tarball/v${PV} -> ${P}.tgz"
RUBY_S="${GITHUB_USER}-${PN}-*"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""


all_ruby_install() {
	doman "./man/yaclic.1" || die

	ruby_fakegem_binwrapper yaclic
}
