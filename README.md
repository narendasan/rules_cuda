# rules_cuda
Bazel rules for CUDA

# Usage

Make sure to have nvcc in your `PATH` (repository rules in progress)

```py
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_cuda",
    remote = "https://github.com/narendasan/rules_cuda",
    branch = "master",
)
```

```py
load("@rules_cuda//cuda:cuda.bzl", "cu_library");

cc_library(
    name = "myprintf",
    hdrs = ["myprintf.h"],
    srcs = ["myprintf.cpp"]
)

cu_library(
    name = "vecAdd",
    srcs = ["vecAdd.cu"],
    hdrs = ["vecAdd.h"],
    gpu_arch = "sm_70",
    gencode = [
        "arch=compute_50,code=sm_50",
        "arch=compute_52,code=sm_52",
        "arch=compute_60,code=sm_60",
        "arch=compute_61,code=sm_61",
        "arch=compute_70,code=sm_70",
        "arch=compute_75,code=sm_75",
    ],
    deps = [
        ":myprintf",
    ]
)
        
cc_binary(
    name = "vec_add",
    srcs = [
        "main.cpp"
    ],
    deps = [
        ":myprintf",
        ":vecAdd",
        "@cuda//:cudart",
    ]
)
```

# Disclaimer 

Rules are unstable and may break

## Known issues

`cu_binary` is broken
