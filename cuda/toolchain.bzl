
def _nvcc_toolchain_impl(ctx):
    compilation_mode_opts = {}
    for k, v in ctx.attr.opt_level.items():
        if not k in ctx.attr.debug_info:
            fail("Compilation mode {} is not defined in debug_info but is defined opt_level".format(k))
        compilation_mode_opts[k] = struct(debug_info = ctx.attr.debug_info[k], opt_level = v)
    for k, v in ctx.attr.debug_info.items():
        if not k in ctx.attr.opt_level:
            fail("Compilation mode {} is not defined in opt_level but is defined debug_info".format(k))

    toolchain = platform_common.ToolchainInfo(
        nvcc = ctx.file.nvcc,
        cudart = ctx.attr.cuda,
        staticlib_ext = ctx.attr.staticlib_ext,
        dylib_ext = ctx.attr.dylib_ext,
        target_triple = ctx.attr.target_triple,
        exec_triple = ctx.attr.exec_triple,
        os = ctx.attr.os,
        target_arch = ctx.attr.target_triple.split("-")[0],
        cuda_version = ctx.attr.cuda_version,
        compilation_mode_opts = compilation_mode_opts,
        crosstool_files = ctx.files._crosstool,
    )
    return [toolchain]

nvcc_toolchain = rule(
    _nvcc_toolchain_impl,
    attrs = {
        "nvcc": attr.label(
            doc = "Location of the `nvcc` binary",
            allow_single_file = True,
        ),
        "cudart": attr.label(
            doc = "CUDA libraries"
        ),
        "staticlib_ext": attr.string(mandatory = True),
        "dylib_ext": attr.string(mandatory = True),
        "os": attr.string(mandatory = True),
        "_crosstool": attr.label(
            default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")
        ),
        "exec_triple": attr.string(),
        "target_triple": attr.string(),
        "opt_level": attr.string_dict(default = {
            "opt": "3",
            "dbg": "0",
            "fastbuild": "0"
        }),
        "debug_info": attr.string_dict(default = {
            "opt": "",
            "debug": "-g -G",
            "fastbuild": ""
        }),
    },
    doc = """""",
)
