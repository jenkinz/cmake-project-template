<Delete me!>

This folder is exclusively for git submodules, e.g. for testing.

Useful tips:

If you want to add a git repository as a submodule on the same service (GitHub,
GitLab, BitBucket, etc.) the following is the correct git command to set that up
as a submodule in the extern directory:

    $ git submodule add ../../owner/repo.git extern/repo

The relative path to the repo is important; it allows you to kepp the same
access method (ssh or https) as the parent repository.

(From https://cliutils.gitlab.io/modern-cmake/chapters/projects/submodule.html)

CMake is then configured to automatically initialize and update the submodules
you add (see top-level CMakeLists.txt, starting at the find_package(Git QUIET)
command). This way, users don't need to run the git submodule command
themselves.