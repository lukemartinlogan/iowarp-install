vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  mochi-hpc/mochi-thallium
    REF "v${VERSION}"
    SHA512 45a8d9639fd83be9d2b7fc85a1a2338961467792df5ace8d28202956f6e43c736e0006ac071462367af3b9181d348931b2d46f0595aa3fc102f113fee1646ca6
    HEAD_REF main    
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYRIGHT")
