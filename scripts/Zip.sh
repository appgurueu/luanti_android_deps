#!/bin/bash -e
zip_ver=1.11.4

download () {
	get_tar_archive libzip "https://github.com/nih-at/libzip/releases/download/v${zip_ver}/libzip-${zip_ver}.tar.gz"
}

build () {
	old_pwd="${PWD}"
	(
		cd $srcdir/libzip
		mkdir -p build
		(
			cd build
			cmake "${CMAKE_FLAGS[@]}" -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX="${old_pwd}" ..
			cmake --build . -j $(nproc)
			cmake --install .
		)
	)
	# TODO extract to copy ()
	mv lib/*.a $pkgdir/
	mv include/*.h $pkgdir/
}
