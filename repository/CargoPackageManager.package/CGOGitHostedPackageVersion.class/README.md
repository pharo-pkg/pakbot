I represent a package version containing source code hosted on a Git server.

- repositoryUrl is the git URL that can be used to clone a repository
- subdirectory is the folder into the git repository that contains packages source code (e.g. mc or repository). It could also be empty if packages are available from the root git folder.
- commitish allows to identify the package version. It could be either a commit id (hash) or a tag