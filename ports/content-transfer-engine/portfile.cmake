vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO iowarp/content-transfer-engine
    REF "3727916a319146c88e7a0ab23099075c5d2ba647"
    SHA512 08f1f2e04f674d15c787b9219691da7dc5f80b84524f86fb257fbffa0d3d55e5cc1d10dc19088de68a89f5404a8a390231ab1bd1f63820d7a93e5126b2612c79
    HEAD_REF main
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