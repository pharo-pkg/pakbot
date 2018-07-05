tests
testShouldGetHttpsUrlWhenHttpsUrlProvidedAndUseHttpsIsTrue
	| srcPackageVersion |
	self useHttpsUrl.
	srcPackageVersion := self srcPackageVersionWithUrl: self gitHttpsUrl.
	self 
		assertSrcPackageVersion: srcPackageVersion 
		repositoryUrlEquals: self gitHttpsUrl