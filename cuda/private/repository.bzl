
def _rules_cuda_setup_impl(repository_ctx):
    """CUDA setup implementation"""

    path_to_nvcc = "/usr/loca/cuda-" + repository_ctx.attr.cuda_version + "/bin/nvcc"
    if (repository_ctx.attr.cuda_path != ""):
        path_to_nvcc = repository_ctx.attr.cuda_path + "/bin/nvcc"


    repository_ctx.file("BUILD", """

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "cuda",
    srcs = glob([
        "lib64/**/*libcuda.so",
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
        "lib64/**/libcudart.so.{version}",
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
        "lib64/**/libnvToolsExt.so.1"
    ])
)

cc_library(
    name = "cublas",
    srcs = glob([
        "lib/**/*libcublas.so",
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
        "lib64/libOpenCL.so.{version}"
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
        "lib64/libaccinj64.so.{version}"
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "cudadevrt",
    srcs = [
        "lib64/libcudadevrt.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)


cc_library(
    name = "cufft",
    srcs = [
        "lib64/libcufft.so.{major_version}",
        "lib64/libcufftw.so.{major_version}"
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)    

cc_library(
    name = "cuinj64",
    srcs = [
        "lib64/libcuinj64.so.{version}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
) 

cc_library(
    name = "culibos",
    srcs = [
        "lib64/libculibos.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
) 

cc_library(
    name = "cupti",
    srcs = [
        "lib64/libcupti.so.{version}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "cupti_static",
    srcs = [
        "lib64/libcupti_static.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
) 
          
cc_library(
    name = "curand",
    srcs = [
        "lib64/libcurand.so.{major_version}"
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "curand_static",
    srcs = [
        "lib64/libcurand_static.a"
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "cusolver",
    srcs = [
        "lib64/libcusolver.so.{major_version}",
        "lib64/libcusolverMg.so.{major_version}"        
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "cusolver",
    srcs = [
        "lib64/libcusolver_static.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "cusparse",
    srcs = [
        "lib64/libcusparse.so.{major_version}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "cusparse_static",
    srcs = [
        "lib64/libcusparse_static.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "lapack",
    srcs = [
        "lib64/liblapack_static.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "mentis",
    srcs = [
        "lib64/libmentis_static.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "npp",
    srcs = [
        "lib64/libnppc.so.{major_version}",
        "lib64/libnppial.so.{major_version}",
        "lib64/libnppicc.so.{major_version}",
        "lib64/libnppicom.so.{major_version}",
        "lib64/libnppidei.so.{major_version}",
        "lib64/libnppif.so.{major_version}",
        "lib64/libnppig.so.{major_version}",
        "lib64/libnppim.so.{major_version}",
        "lib64/libnppist.so.{major_version}",
        "lib64/libnppisu.so.{major_version}",
        "lib64/libnppitc.so.{major_version}",
        "lib64/libnpps.so.{major_version}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "npp_static",
    srcs = [
        "lib64/libnppc_static.a",
        "lib64/libnppial_static.a",
        "lib64/libnppicc_static.a",
        "lib64/libnppicom_static.a",
        "lib64/libnppidei_static.a",
        "lib64/libnppif_static.a",
        "lib64/libnppig_static.a",
        "lib64/libnppim_static.a.",
        "lib64/libnppist_static.a",
        "lib64/libnppisu_static.a",
        "lib64/libnppitc_static.a",
        "lib64/libnpps_static.a.",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "nvgraph",
    srcs = [
        "lib64/libnvgraph.so.{major_version}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "nvgraph_static",
    srcs = [
        "lib64/libnvgraph_static.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "nvjpeg",
    srcs = [
        "lib64/libnvjpeg.so.{major_version}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "nvjpeg_static",
    srcs = [
        "lib64/libnvjpeg_static.a",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)

cc_library(
    name = "nvrtc",
    srcs = [
        "lib64/libnvrtc.so.{major_version}",
        "lib64/libnvrtc-builtins.so.{major_version}",
    ],
    hdrs = [],
    includes = ["include/"],
    linkopts = ["-Wl,-rpath,lib64/"]
)
""")


    
    args = [
        
