asserting
assertSrcPackageVersion: srcPackageVersion hasSameUrlAs: anotherPackageVersion
	| repoUrl expectedUrl |
	repoUrl := ((srcPackageVersion instVarNamed: 'repository')
						instVarNamed: 'repositoryUrl').
	expectedUrl := ((anotherPackageVersion instVarNamed: 'repository') 
						instVarNamed: 'repositoryUrl').
	self assert: (repoUrl isKindOf: String).
	self assert: repoUrl	equals: expectedUrl