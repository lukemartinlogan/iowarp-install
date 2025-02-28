vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO iowarp/cte-hermes-shm
        REF "98c368e98d948e4f6e2fc74e48ddb7161c505eed"
        SHA512 4fda4da6ca391425f9160299e029d29087fd068029d0f47cd0585bb9d9d50b0ef2e0832f02019dc1c2ec93595566f343ddfc5a5f91efa89c9eae965d541483b9
        HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    bench BUILD_HSHM_BENCHMARKS
    boost BUILD_Boost_TESTS
    cereal HERMES_ENABLE_CEREAL
    coverage HERMES_ENABLE_COVERAGE
    doxygen HERMES_ENABLE_DOXYGEN
    elf HERMES_USE_ELF
    mpi BUILD_MPI_TESTS
    openmp BUILD_OpenMP_TESTS
    pthread HERMES_PTHREADS_ENABLED
    shared BUILD_SHARED_LIBS
    test BUILD_HSHM_TESTS
    thallium HERMES_RPC_THALLIUM
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
