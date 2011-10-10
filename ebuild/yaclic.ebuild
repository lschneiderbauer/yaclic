# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="A simple and intuitive cli calculator"
HOMEPAGE="http://vootey.github.com/yaclic/"

GITHUB_USER="vootey"
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/tarball/r${PV} -> ${P}.tgz"
RUBY_S="${GITHUB_USER}-${PN}-*"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="${IUSE} gnuplot"

RDEPEND="${RDEPEND} gnuplot? ( >=dev-ruby/gnuplot-2.2 )"

all_ruby_install() {
	doman "./man/yaclic.1"

	ruby_fakegem_binwrapper yaclic || die
}
