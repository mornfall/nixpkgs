findTarballs() {
    local f
    for f in $1/tarballs/*.{tar.gz,tgz,tar.bz2,tbz2,tar.xz,tar.lzma}; do
        test -e $f && echo $f
    done | sort
    echo "$1"
}

propagateImageName() {
    ensureDir $out/nix-support
    cat "$diskImage"/nix-support/full-name > $out/nix-support/full-name
}
