





nvcc_toolchain = rule(
    _nvcc_toolchain_impl,
    attrs = {
        "nvcc": attr.label(
            doc = "Location of the `nvcc` binary",
            allow_single_file = True,
        ),
        "cudart": attr.label(
            
        )
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
        
