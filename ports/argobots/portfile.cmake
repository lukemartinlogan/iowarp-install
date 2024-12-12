vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  pmodels/argobots
    REF "v${VERSION}"
    SHA512 4855615ca4a45b9a75c71f61ea19fecf88c0d93d45b1907f46bebd44545ca99c47574d70b3d90cbfb8780cc62ac6ccd2f1d17ef6511b00343a57237024cee5c0
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