pkg_name=minecraft
pkg_description="A game focused on building in a 3d world"
pkg_version=1.10.2
pkg_maintainer="Michael Ducy <michael@chef.io>"
pkg_license=('Apache 2.0')
pkg_description="Minecraft is a sandbox video game originally created by Swedish programmer Markus "Notch" Persson and later developed and published by Mojang. The creative and building aspects of Minecraft enable players to build constructions out of textured cubes in a 3D procedurally generated world."
pkg_upstream_url="https://minecraft.net/en/download/server"
pkg_source=https://s3.amazonaws.com/Minecraft.Download/versions/1.10.2/minecraft_server.1.10.2.jar
pkg_shasum=195f468227c5f9218f3919538b9b16ba34adced67fc7d7b652c508a5e8d07a21

pkg_deps=(
  core/jdk8
  core/coreutils
)
pkg_expose=(25565)


# The default implementation extracts your tarball source file into HAB_CACHE_SRC_PATH. The
# supported archives are: .tar, .tar.bz2, .tar.gz, .tar.xz, .rar, .zip, .Z, .7z. If the file
# archive could not be found or was not supported, then a message will be printed to stderr
# with additional information.

do_unpack() {
  return 0
}

# The default implementation is to update the prefix path for the configure script to
# use $pkg_prefix and then run make to compile the downloaded source. This means the
# script in the default implementation does ./configure --prefix=$pkg_prefix && make. You
# should override this behavior if you have additional configuration changes to make or
# other software to build and install as part of building your package.
do_build() {
    return 0
}

# The default implementation is to run make install on the source files and place the compiled
# binaries or libraries in HAB_CACHE_SRC_PATH/$pkg_dirname, which resolves to a path like
# /hab/cache/src/packagename-version/. It uses this location because of do_build() using the
# --prefix option when calling the configure script. You should override this behavior if you
# need to perform custom installation steps, such as copying files from HAB_CACHE_SRC_PATH
# to specific directories in your package, or installing pre-built binaries into your package.
do_install() {
    build_line "Performing install"
    
    cp -vR ${HAB_CACHE_SRC_PATH}/minecraft_server.${pkg_version}.jar ${pkg_prefix}/minecraft_server.jar

    # default permissions included in the tarball don't give any world access
    find "${pkg_prefix}/" -type f -exec chmod -v 644 {} +
    chown -R hab:hab ${pkg_prefix}/
}
