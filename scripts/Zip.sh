#!/bin/bash -e
zip_ver=1.11.4

download () {
	get_tar_archive libzip "https://github.com/nih-at/libzip/releases/download/v${zip_ver}/libzip-${zip_ver}.tar.gz"
}

build () {
	(
		cd $srcdir/libzip
		mkdir -p build
		(
			cd build
			cmake "${CMAKE_FLAGS[@]}" ..
			cmake --build . -j $(nproc)
			cmake --install .
		)
	)
}
