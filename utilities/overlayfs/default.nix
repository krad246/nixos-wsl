{
  srcDir,
  dstDir,
  offset,
  ...
}: let
  # Helper function to generate all the bindings for an OverlayFS.
  mkOverlayPath = {
    src,
    dst,
    path,
  }: let
    # Need a 'bottom' of the dirstack, as well as a 'top',
    # as well as a copy buffer / staging buffer.
    bottom = "${dst}/.ro/${path}";
    top = "${dst}/.rw/${path}";
    tmp = "${dst}/.rw/workdir-${path}";
    target = "${dst}/${path}";
  in {
    # Mount the bottom as immutable.
    fileSystems."${bottom}" = let
      original = "${src}/${path}";
    in {
      options = ["bind" "ro"];
      device = "${original}";
    };

    # Mount a writable spot DIFFERENT from the bottom.
    # This allows us to segregate writes between the layers.
    # We mount the resultant overlay onto the actual home directory.
    # Thus, all writes shall trap into the upper directory.
    # For atomicity, the copy buffer... exists.
    fileSystems."${target}" = let
      options = [
        "lowerdir=${bottom}"
        "upperdir=${top}"
        "workdir=${tmp}"
      ];
    in {
      device = "overlay";
      fsType = "overlay";
      inherit options;
    };
  };
in
  mkOverlayPath {
    src = srcDir;
    dst = dstDir;
    path = offset;
  }
