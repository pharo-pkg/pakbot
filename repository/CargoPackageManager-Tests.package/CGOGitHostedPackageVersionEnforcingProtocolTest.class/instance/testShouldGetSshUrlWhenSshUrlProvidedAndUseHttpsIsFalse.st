tests
testShouldGetSshUrlWhenSshUrlProvidedAndUseHttpsIsFalse
	| srcPackageVersion |
	self useSshUrl.
	srcPackageVersion := self srcPackageVersionWithUrl: self gitSshUrl.
	self 
		assertSrcPackageVersion: srcPackageVersion 
		repositoryUrlEquals: self gitSshUrl