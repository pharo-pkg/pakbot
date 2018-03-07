I represent a repository containing source code hosted on a Git server.
I hold a reference to an Iceberg repository to use it for some git operations.

- version : I can refer to a specific branch, tag or commit hash of the given git repository. If not, default version will be 'master.
- repositoryUrl: I also keep the origin url as it can be changed so that Iceberg accepts it. It is the same URL but with a different form (e.g. github://demarey/cargo:master vs git@gihub.com:demarey/cargo.git

	self example inspect