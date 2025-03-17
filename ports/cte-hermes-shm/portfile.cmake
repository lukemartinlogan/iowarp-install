vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO iowarp/cte-hermes-shm
        REF "0f289f2ae1543b80bc6273462015263d5d5b613f"
        SHA512 aca736563c50656fe85123bf4e21f9f6e8b3b8afd7c99059c7e9bb6d48c28ce0f64a8a9407aa2aa28eb56ff94eaffa9f77a5326efd33adb6bd6a0ae244cc3c14
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
