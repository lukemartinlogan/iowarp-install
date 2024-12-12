vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  grc-iit/hermes-shm
    REF "v${VERSION}"
    SHA512 83b9253b2172587ac60a75f1501417d42bc0fe7045291a66aad1bb196eb7ff26d67cdd8fafce8fbeb412decd52d82a9df7fefed227a5eb8bcf212c058520bf60
    HEAD_REF master
    PATCHES
        random.patch    
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DHERMES_ENABLE_DOXYGEN=OFF
)

vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
