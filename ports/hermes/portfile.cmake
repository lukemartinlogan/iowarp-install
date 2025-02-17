vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO HDFGroup/hermes
    REF "v${VERSION}"
    SHA512 39fd0cff7d866f0d232d6aa889fa1548a9c21a89c04bc198ac0c2010c9ef582efb45f584ce4f21f56637e2f5a357c0f2b3590657ce2ac7e3875fcaf2f0b2bd7f
    HEAD_REF main
    PATCHES
    hrun.patch
    CMakeLists.txt.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    hdf5 HERMES_ENABLE_VFD
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")