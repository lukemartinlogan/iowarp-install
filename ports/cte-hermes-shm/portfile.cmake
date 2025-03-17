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
    cereal HSHM_ENABLE_CEREAL
    coverage HSHM_ENABLE_COVERAGE
    doxygen HSHM_ENABLE_DOXYGEN
    elf HSHM_USE_ELF
    mpi HSHM_ENABLE_MPI
    openmp HSHM_ENABLE_OPENMP
    pthread HSHM_ENABLE_PTHREADS
    shared BUILD_SHARED_LIBS
    test BUILD_HSHM_TESTS
    thallium HSHM_RPC_THALLIUM
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
