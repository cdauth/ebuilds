# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit distutils cvs

MY_PN=${PN%-cvs}

ECVS_SERVER="cvs.jabberstudio.org:/home/cvs"
ECVS_MODULE=${MY_PN}
ECVS_USER="anonymous"
#ECVS_CVS_OPTIONS="-dP"

DESCRIPTION="JEP 65 Bytestream Proxy Jabber Component"
HOMEPAGE="http://proxy65.jabberstudio.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/${MY_PN}

DEPEND="
	dev-python/twisted-words
	"

CONFDIR="/etc/${MY_PN}"
CONFFILE="${CONFDIR}/${MY_PN}.tap"

src_install() {
	distutils_src_install
	dodir "${CONFDIR}"
	exeinto /etc/init.d
	newexe "${FILESDIR}/proxy65.init-01" proxy65
	sed	-e "s#EBUILDPATH#/var/db/pkg/${CATEGORY}/${PN}-<version>/${PN}-<version>.ebuild#" \
		-i "${D}/etc/init.d/proxy65"
}

pkg_postinst() {
	if [ ! -e "${CONFFILE}" ]; then
		einfo "${MY_PN} is not yet configured."
		einfo "emerge --config =${PF}"
	fi
}

pkg_config() {
	if [ -e "${CONFFILE}" ]; then
		einfo "${MY_PN} already configured at ${CONFFILE}."
		einfo "Remove ${CONFFILE} and try again if you want to reconfigure."
	else
		echo "Gathering info for configuration of ${MY_PN}..."
		cd "${CONFDIR}" || die "Unable to cd to ${CONFDIR}."

		PROXYUID=`id -u nobody` || die "Unable to determine UID of 'nobody'."
		PROXYGID=`id -g nobody` || die "Unable to determine GID of 'nobody'."

		DEFAULT_JID="${MY_PN}.`hostname --domain`"

		read -p "Jabber ID for ${MY_PN} (usually ${MY_PN}.yourjabberrealm.com)? [${DEFAULT_JID}] " JID
		[ -z "${JID}" ] && JID="${DEFAULT_JID}"

		echo "Shared secret for authentication to the Jabber server (you should definitely change"
		read -p "this. You will need to configure it somewhere in your Jabber server, as well.)? [secret] " SECRET
		[ -z "${SECRET}" ] && SECRET="secret"

		read -p "Hostname or IP of the Jabber Server? [localhost] " RHOST
		[ -z "${RHOST}" ] && RHOST="127.0.0.1"

		read -p "Port number of the Jabber router? [5347] " RPORT
		[ -z "${RPORT}" ] && RPORT=5347

		echo "IP Address(es) on which ${MY_PN} should listen"
		read -p "(space-delimited if more than one)? [all] " PROXYIPS
		[ -z "${PROXYIPS}" ] && PROXYIPS="0.0.0.0"

		mktap								\
			--appname="${MY_PN}"			\
			--uid=${PROXYUID}				\
			--gid=${PROXYGID}				\
			"${MY_PN}"						\
				--jid="${JID}"				\
				--secret="${SECRET}"		\
				--rhost="${RHOST}"			\
				--rport="${RPORT}"			\
				--proxyips="${PROXYIPS}"	\
		|| die "mktap failed. Unable to configure."
	fi
}
