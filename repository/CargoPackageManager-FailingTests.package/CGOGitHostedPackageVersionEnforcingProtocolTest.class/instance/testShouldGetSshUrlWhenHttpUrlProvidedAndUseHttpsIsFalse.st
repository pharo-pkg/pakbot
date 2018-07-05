tests
testShouldGetSshUrlWhenHttpUrlProvidedAndUseHttpsIsFalse
	| srcPackageVersion |
	self useSshUrl.
	srcPackageVersion := self srcPackageVersionWithUrl: self gitHttpsUrl.
	self 
		assertSrcPackageVersion: srcPackageVersion 
		repositoryUrlEquals: self gitSshUrl