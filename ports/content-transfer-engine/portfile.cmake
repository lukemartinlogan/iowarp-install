vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO iowarp/content-transfer-engine
    REF "a8a1af98d9fc8d46a90d64093b78143993891a4b"
    SHA512 a2512d6927e3b907344d9457b1d2ac9a6677e37b2273979a3d0a9c7c1bd318a4d6f73bb5ea5a8169314c8034fc6bd4d9647e76c35766f4d658e80c0e1a84fca1
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