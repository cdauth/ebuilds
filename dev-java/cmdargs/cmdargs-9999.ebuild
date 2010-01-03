EAPI=2

DESCRIPTION="A Java library to parse command-line arguments."
HOMEPAGE="http://gitorious.org/cdauth/cmdargs/"

EGIT_REPO_URI="http://git.gitorious.org/cdauth/cmdargs.git"
inherit git

LICENSE="LGPL-3"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-java/ant sys-devel/gcc[gcj]"
RDEPEND="sys-devel/gcc[gcj]"

src_prepare() {
	ant distclean
}

src_compile() {
	ant jar gcj-shared gcj-static
}

src_install() {
	dolib.a "${S}/dist/libcmdargs.a"
	dolib.so "${S}/dist/libcmdargs.so.0"
	
	insinto "${DESTTREE}/share/${PN}"
	newins "${S}/dist/cmdargs.jar" "lib/cmdargs.jar"
}
