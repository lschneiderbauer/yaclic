# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git-2

DESCRIPTION="A simple and intuitive cli-calculator"
HOMEPAGE="https://github.com/vootey/yac"
SRC_URI=""

EGIT_REPO_URI="git://github.com/vootey/yac.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND="dev-lang/ruby:1.8"
DEPEND="dev-vcs/git"

src_install() {
	dobin ${S}/bin/yac || die "Files not found"
	dolib ${S}/lib/* || die "Files not found"
}
