load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def open_watcom_deps():
    http_archive(
        name = "open_watcom_v2_bin",
        url = "https://github.com/open-watcom/open-watcom-v2/releases/download/2021-10-02-Build/ow-snapshot.tar.gz",
        sha256 = "63403da8f8e30d3a7c013ae01c9ca54a3dd59184dbbe1b8a367212371f9865a9",
        build_file = "//third_party:open_watcom_v2.BUILD",
        strip_prefix = "",
    )
