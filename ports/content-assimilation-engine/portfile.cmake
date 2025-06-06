vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO iowarp/content-assimilation-engine
    REF "feb50eda601193492aebdd71f3f1801802dd4409"
    SHA512 9b8db2ab127a378b2983eb07a896fbdcdd241f2174bc7271d195d858e9abd2fda66c2553b619c2631222548069047ca4c7d4e7f836928bb9cf54d3da844bed77
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    poco POCO
    aws AWS    
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/omni"
    OPTIONS
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")