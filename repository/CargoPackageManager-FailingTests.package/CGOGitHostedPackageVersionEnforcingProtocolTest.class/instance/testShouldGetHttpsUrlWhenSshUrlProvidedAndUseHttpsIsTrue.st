tests
testShouldGetHttpsUrlWhenSshUrlProvidedAndUseHttpsIsTrue
	| srcPackageVersion |
	self useHttpsUrl.
	srcPackageVersion := self srcPackageVersionWithUrl: self gitSshUrl.
	self 
		assertSrcPackageVersion: srcPackageVersion 
		repositoryUrlEquals: self gitHttpsUrl