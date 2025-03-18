vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO iowarp/iowarp-runtime
        REF "fb47b47339931024bc4cfd4a4b6942b18d555aaa"
        SHA512 e26a0c71893a284d3a7ca67d5ee08fcabb08da70bd68f9c961a7572ffcb0a9c96f327588a2935bed23b0e96965eea632f7d419cfc6410c2b95d2ed886904417f
        HEAD_REF main
        PATCHES
        cmake.patch	
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    coverage CHIMAERA_ENABLE_COVERAGE
    cuda CHIMAERA_ENABLE_CUDA
    dotenv CHIMAERA_ENABLE_DOTENV
    doxygen CHIMAERA_ENABLE_DOXYGEN
    jemalloc CHIMAERA_ENABLE_JEMALLOC
    mimalloc CHIMAERA_ENABLE_MIMALLOC
    mpi BUILD_MPI_TESTS
    no CHIMAERA_NO_COMPILE
    openmp BUILD_OpenMP_TESTS
    python CHIMAERA_ENABLE_PYTHON
    remote CHIMAERA_REMOTE_DEBUG
    rocm CHIMAERA_ENABLE_ROCM
    shared BUILD_SHARED_LIBS
    task CHIMAERA_TASK_DEBUG    
    test BUILD_TESTS
    zmq BUILD_ZeroMQ_TESTS
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
