# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="OTR key file decoder"
HOMEPAGE="http://www.onlinetvrecorder.com/"
SRC_URI="http://www.onlinetvrecorder.com/downloads/otrdecoder-bin-linux-Ubuntu_hardy_%28development_branch%29-i686-v${PV}.tar.bz2"

LICENSE=""
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

MY_WORKDIR="${WORKDIR}/otrdecoder-bin-linux-Ubuntu_hardy_(development_branch)-i686-v${PV}"

src_install() {
	dodoc "${MY_WORKDIR}/README.OTR"
	insinto "${DESTTREE}/share/${PN}"
	doins "${MY_WORKDIR}"/decoder.glade
	insopts -m0755
	doins "${MY_WORKDIR}"/{otrdecoder,otrdecoder-gui}
	dosym "${INSDESTTREE}"/otrdecoder "${DESTTREE}"/bin/
	dosym "${INSDESTTREE}"/otrdecoder-gui "${DESTTREE}"/bin/
}
