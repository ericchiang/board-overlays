# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

unset CHROMEOS_ROOT

CROS_WORKON_COMMIT="a8e0d8cd026f050162c6d360f634edeae96a5a11"

if [[ -n "${ST1Q_SOURCES_QUALCOMM}" ]] ; then
    CROS_WORKON_REPO="git://git-1.quicinc.com"
    CROS_WORKON_PROJECT="platform/vendor/qcom-opensource/omx/mm-video.git"
    CROS_WORKON_LOCALNAME="qcom/opensource/omx/mm-video"
else
    CROS_WORKON_PROJECT="mm-video.git"
fi

inherit cros-workon toolchain-funcs

DESCRIPTION="omx multi-media video libraries"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="media-libs/mm-core-oss
	virtual/opengles"
DEPEND="${RDEPEND}
	chromeos-base/kernel-headers"


src_compile() {
	tc-export CC CXX
	emake CCC="${CXX}" LIBVER=${PV} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" LIBVER=${PV} install || die "emake install failed"
	insinto /etc/udev/rules.d
	doins "${FILESDIR}"/62-vdec.rules || die
}
