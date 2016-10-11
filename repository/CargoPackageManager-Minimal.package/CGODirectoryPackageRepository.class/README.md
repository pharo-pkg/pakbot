This kind of repository is meant to be used as a local repository in the current machine. Useful for caches or testing.

Create an instance of myself doing:

  CGODirectoryPackageRepository newInDirectory: path.

Path  can be both a string or a file reference. If the given path does not exist it will create it. If the given path is an already existing file it will fail with a FileExists exception.

Directory repositories store versions as follows:

 - packages are represented as subdirectories of the package directory.
 - versions are represented as files containing the serialized version information, and stored inside the corresponding package subdirectory.