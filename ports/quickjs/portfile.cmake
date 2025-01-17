vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO bellard/quickjs
  REF b5e62895c619d4ffc75c9d822c8d85f1ece77e5b # 2021-03-27
  SHA512 ed1c5d5620c35f1aa4c43898e8f7428ecb388c57acb71c30a43710c8e8a95da9aff3821e61b88b2f3932c9a80d86b08a11709152f42236f3dfa591ff7909878a
  HEAD_REF master
  PATCHES 
      fix-win-build.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        bignum ENABLE_BIGNUM
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-${PORT} CONFIG_PATH share/unofficial-${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

configure_file(
    "${CMAKE_CURRENT_LIST_DIR}/quickjs-config.in.cmake"
    "${CURRENT_PACKAGES_DIR}/share/unofficial-${PORT}/unofficial-quickjs-config.cmake"
    @ONLY
)

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
