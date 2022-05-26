vcpkg_from_gitlab(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Symbitic/TreeSitterPlusPlus
    REF v0.1.0
    SHA512 0
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/tree-sitter TARGET_PATH share/tree-sitter)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()
