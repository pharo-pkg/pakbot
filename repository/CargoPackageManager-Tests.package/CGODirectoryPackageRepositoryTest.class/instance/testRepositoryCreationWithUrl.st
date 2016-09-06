tests
testRepositoryCreationWithUrl
	| path repo |
	path := '/tmp/cargo-repo-test'.
	repo := CGODirectoryPackageRepository newWithUrl: ('file://' , path).
	self 
		assert: repo rootDirectory 
		equals: path asFileReference