def BUILD_for_compiler(cuda_version):
    return """
load("@rules_cuda//cuda:toolchain.bzl", "nvcc_toolchain")

filegroup(
    name = "nvcc",
    srcs = ["bin/nvcc{binary_ext}"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "cudart",
    srcs = ["lib64/cudart.{dylib_ext}"],
    visibility = ["//visibility:public"],
)
""".format(
        binary_ext = system_to_binary_ext(system),
        dylib_ext = system_to_binary_ext(system),
    )

def BUILD_for_CUDA(target_triple):

    return """
package(default_visibility = ["//visibility:public"])

cc_library(
    name = "cuda",
    srcs = glob([
        "lib/**/*libcuda.{dylib_ext}",
    ]),
    hdrs = glob([
        "include/**/*.h",
        "include/**/*.hpp",
        "include/**/*.inl",
    ]),
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"],
    deps = [
        ":cudart",
        ":nvToolsExt",
    ]
)

cc_library(
    name = "cudart",
    srcs = glob([
        "lib/**/libcudart.{dylib_ext}",
    ]),
    hdrs = glob([
        "include/**/*.h",
        "include/**/*.hpp",
        "include/**/*.inl",
    ]),
    includes = ["include/"],
)

cc_library(
    name = "nvToolsExt",
    srcs = glob([
        "lib/**/libnvToolsExt.{dylib_ext}"
    ])
)

cc_library(
    name = "cublas",
    srcs = glob([
        "lib/**/*libcublas.{dylib_ext}",
    ]),
    hdrs = glob([
        "include/**/*cublas*.h",
        "include/**/*.hpp",
        "include/**/*.inl",
    ]),
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"],
)

cc_library(
    name = "opencl",
    srcs = [
        "lib/libOpenCL.{dylib_ext}"
    ],
    hdrs = [
        "include/CL/**/*.h"
    ],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"],
)

cc_library(
    name = "accinj64",
    srcs = [
        "lib/libaccinj64.{dylib_ext}"
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "cudadevrt",
    srcs = [
        "lib/libcudadevrt.{static_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "cufft",
    srcs = [
        "lib/libcufft.{dylib_ext}",
        "lib/libcufftw.{dylib_ext}"
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)
    
cc_library(
    name = "cuinj64",
    srcs = [
        "lib/libcuinj64.{dylib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)
 
cc_library(
    name = "culibos",
    srcs = [
        "lib/libculibos.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)
 
cc_library(
    name = "cupti",
    srcs = [
        "lib/libcupti.{dylib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "cupti_static",
    srcs = [
        "lib/libcupti_static.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
) 
          
cc_library(
    name = "curand",
    srcs = [
        "lib/libcurand.{dylib_ext}"
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "curand_static",
    srcs = [
        "lib/libcurand_static.{staticlib_ext}"
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "cusolver",
    srcs = [
        "lib/libcusolver.{dylib_ext}",
        "lib/libcusolverMg.{dylib_ext}"        
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "cusolver_static",
    srcs = [
        "lib/libcusolver_static.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "cusparse",
    srcs = [
        "lib/libcusparse.{dylib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "cusparse_static",
    srcs = [
        "lib/libcusparse_static.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "lapack",
    srcs = [
        "lib/liblapack_static.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "mentis",
    srcs = [
        "lib64/libmentis_static.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "npp",
    srcs = [
        "lib/libnppc.{dylib_ext}",
        "lib/libnppial.{dylib_ext}",
        "lib/libnppicc.{dylib_ext}",
        "lib/libnppicom.{dylib_ext}",
        "lib/libnppidei.{dylib_ext}",
        "lib/libnppif.{dylib_ext}",
        "lib/libnppig.{dylib_ext}",
        "lib/libnppim.{dylib_ext}",
        "lib/libnppist.{dylib_ext}",
        "lib/libnppisu.{dylib_ext}",
        "lib/libnppitc.{dylib_ext}",
        "lib/libnpps.{dylib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)
cc_library(
    name = "npp_static",
    srcs = [
        "lib/libnppc_static.{staticlib_ext}",
        "lib/libnppial_static.{staticlib_ext}",
        "lib/libnppicc_static.{staticlib_ext}",
        "lib/libnppicom_static.{staticlib_ext}",
        "lib/libnppidei_static.{staticlib_ext}",
        "lib/libnppif_static.{staticlib_ext}",
        "lib/libnppig_static.{staticlib_ext}",
        "lib/libnppim_static.{staticlib_ext}",
        "lib/libnppist_static.{staticlib_ext}",
        "lib/libnppisu_static.{staticlib_ext}",
        "lib/libnppitc_static.{staticlib_ext}",
        "lib/libnpps_static.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "nvgraph",
    srcs = [
        "lib/libnvgraph{dylib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "nvgraph_static",
    srcs = [
        "lib/libnvgraph_static.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "nvjpeg",
    srcs = [
        "lib/libnvjpeg.{dylib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "nvjpeg_static",
    srcs = [
        "lib/libnvjpeg_static.{staticlib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)

cc_library(
    name = "nvrtc",
    srcs = [
        "lib64/libnvrtc.{dylib_ext}",
        "lib64/libnvrtc-builtins.{dylib_ext}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib/"]
)
""".format(
        dylib_ext = system_to_dylib_ext(system),
        staticlib_ext = system_to_staticlib_ext(system),
    )

        
def BUILD_for_nvcc_toolchain(workspace_name, name, exec_triple, target_triple, cuda_version = "10.2"):

    system = triple_to_system(target_triple)

    return """
nvcc_toolchain(
    name = "{toolchain_name}_impl",
    cudart = "@{workspace_name}//:,
    staticlib_ext = {staticlib_ext},
        dylib_ext = {dylib_ext},
        target_triple = {target_triple},
        exec_triple = {exec_triple},
        os = {system},
        cuda_version = {cuda_version},
)
""".format(
        toolchain_name = name,
        workspace_name = workspace_name,
        dylib_ext = system_to_dylib_ext(system),
        staticlib_ext = system_to_staticlib_ext(system),
        system = system,
        cuda_version = cuda_version,
        target_triple = target_triple,
        exec_triple = exec_triple,
    )





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
    
                               
