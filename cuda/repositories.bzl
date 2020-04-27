


rules_cuda_setup = repository_rule(
    attrs = {
        "cuda_version": attr.string(
            manditory = True,
            default = "10.2",
            doc = """
The version of CUDA to be used
"""),
        "cuda_path": attr.string(
            manditory = False,
            doc = """
Path to CUDA root directory if not default location (/usr/local/cuda-{VERSION})
"""),
    },
    implementation = _rules_cuda_setup_impl,
    doc = """A rule for importing CUDA to use in Bazel"""
)
    
                               
