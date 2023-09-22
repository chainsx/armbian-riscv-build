#!/bin/bash
#
# Copyright (c) 2013-2021 Igor Pecovnik, igor.pecovnik@gma**.com
#
# This file is licensed under the terms of the GNU General Public
# License version 2. This program is licensed "as is" without any
# warranty of any kind, whether express or implied.
#
# This file is a part of the Armbian build script
# https://github.com/armbian/build/

# Functions:

# compilation_prepare

compilation_prepare()
{

	# Packaging patch for modern kernels should be one for all.
	# Currently we have it per kernel family since we can't have one
	# Maintaining one from central location starting with 5.3+
	# Temporally set for new "default->legacy,next->current" family naming

	if linux-version compare "${version}" ge 5.17.3; then

		if test -d ${kerneldir}/debian
		then
			rm -rf ${kerneldir}/debian/*
		fi

		sed -i -e '
			s/^KBUILD_IMAGE	:= \$(boot)\/Image\.gz$/KBUILD_IMAGE	:= \$(boot)\/Image/
		' ${kerneldir}/arch/riscv/Makefile

		rm -f ${kerneldir}/scripts/package/{builddeb,mkdebian}

		cp ${SRC}/packages/armbian/builddeb ${kerneldir}/scripts/package/builddeb
		cp ${SRC}/packages/armbian/mkdebian ${kerneldir}/scripts/package/mkdebian

		chmod 755 ${kerneldir}/scripts/package/{builddeb,mkdebian}
	fi

	# After the patches have been applied,
	# check and add debian package compression if required.
	#
	if [ "$(awk '/dpkg --build/{print $1}' $kerneldir/scripts/package/builddeb)" == "dpkg" ];then
		sed -i -e '
			s/dpkg --build/dpkg-deb \${KDEB_COMPRESS:+-Z\$KDEB_COMPRESS} --build/
			' "$kerneldir"/scripts/package/builddeb
	fi
}
