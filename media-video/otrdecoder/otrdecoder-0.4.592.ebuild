# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="OTR key file decoder"
HOMEPAGE="http://www.onlinetvrecorder.com/"
SRC_URI="
static? ( http://www.onlinetvrecorder.com/downloads/otrdecoder-bin-i686-pc-linux-gnu-static-${PV}.tar.bz2 )
!static? ( http://www.onlinetvrecorder.com/downloads/otrdecoder-bin-linux-Ubuntu_9.04-i686-${PV}.tar.bz2 )
"

LICENSE=""
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+static +gui"

DEPEND=""
RDEPEND="gui? ( !static? (
dev-lang/python:2
dev-python/pygtk
gnome-base/libglade
) )" # GUI dependencies according to "README.OTR" file
MERGE_TYPE="binary"

if use static; then
	MY_WORKDIR="${WORKDIR}/otrdecoder-bin-i686-pc-linux-gnu-static-${PV}"
else
	MY_WORKDIR="${WORKDIR}/otrdecoder-bin-linux-Ubuntu_9.04-i686-${PV}"
fi

S="${MY_WORKDIR}"

src_install() {

	dodoc "${MY_WORKDIR}/README.OTR"
	insinto "${DESTTREE}/share/${PN}"
	doins "${MY_WORKDIR}"/decoder.glade
	insopts -m0755
	doins "${MY_WORKDIR}"/{otrdecoder,otrdecoder-gui}
	dosym "${INSDESTTREE}"/otrdecoder "${DESTTREE}"/bin/
	dosym "${INSDESTTREE}"/otrdecoder-gui "${DESTTREE}"/bin/
}
