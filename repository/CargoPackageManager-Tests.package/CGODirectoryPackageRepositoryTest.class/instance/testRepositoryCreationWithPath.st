tests
testRepositoryCreationWithPath
	| path |
	path := '/tmp/cargo-repo-test'.
	path asFileReference ensureDeleteAll.
	CGODirectoryPackageRepository newWithUrl: path.
	self assert: path asFileReference isDirectory