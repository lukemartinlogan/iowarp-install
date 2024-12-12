vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  mochi-hpc/mochi-margo
    REF "v${VERSION}"
    SHA512 8e3ddae8eb91c239f75b6f69abc53a274b40845aa381d983e6fed205bda9147cea85a4282a566ef440e6e2d74d67b423e1c443471ae93a6f2f01868e74570bf1
    HEAD_REF main
)

vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    AUTOCONFIG
    OPTIONS
        ${options}
)

vcpkg_install_make()
vcpkg_fixup_pkgconfig()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYRIGHT")