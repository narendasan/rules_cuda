# rules_cuda
Bazel rules for CUDA

# Usage

Make sure to have nvcc in your `PATH` (repository rules in progress)

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_cuda",
    remote = "https://github.com/narendasan/rules_cuda",
    branch = "master",
)


# Disclaimer 

Rules are unstable and may break

## Known issues

`cu_binary` is broken
