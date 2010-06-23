# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

unset CHROMEOS_ROOT

CROS_WORKON_COMMIT="bbd54b6d68d92bda63e5232dc88550c2a9ef3c79"

if [[ -n "${ST1Q_SOURCES_QUALCOMM}" ]] ; then
	CROS_WORKON_REPO="git://git-1.quicinc.com"
	CROS_WORKON_PROJECT="platform/vendor/qcom-opensource/omx/mm-core.git"
	CROS_WORKON_LOCALNAME="qcom/opensource/omx/mm-core"

	# EGIT_BRANCH must be set prior to 'inherit git' being used by cros-workon
	EGIT_BRANCH=${EGIT_BRANCH:="${CROS_WORKON_COMMIT}"}
else
	CROS_WORKON_PROJECT="mm-core.git"
fi

inherit cros-workon toolchain-funcs

DESCRIPTION="omx multi-media core libraries"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND=""
DEPEND="chromeos-base/kernel-headers"

src_compile() {
	tc-export CC CXX
	emake CCC="${CXX}" LIBVER=${PV} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" LIBVER=${PV} install || die "emake install failed"
}
