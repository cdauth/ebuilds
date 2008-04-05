# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="OMR key file decoder"
HOMEPAGE="http://www.onlinemusicrecorder.com/"
SRC_URI="http://www.onlinemusicrecorder.com/downloads/omrdecoder-bin-linux-Ubuntu_gutsy_%28development_branch%29-v${PV}.tar.bz2"

LICENSE=""
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

MY_WORKDIR="${WORKDIR}/omrdecoder-bin-linux-Ubuntu_gutsy_(development_branch)-v${PV}"

src_install() {
	dodoc "${MY_WORKDIR}/README.OMR"
	insinto "${DESTTREE}/share/${PN}"
	doins "${MY_WORKDIR}"/{decoder.glade,omrdecoder,omrdecoder-gui}
	dosym "${INSDESTTREE}"/omrdecoder "${DESTTREE}"/bin/
	dosym "${INSDESTTREE}"/omrdecoder-gui "${DESTTREE}"/bin/
}
