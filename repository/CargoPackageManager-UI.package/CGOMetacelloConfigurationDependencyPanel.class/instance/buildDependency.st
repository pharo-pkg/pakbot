building
buildDependency

	"We should have validations, probably in the domain object itself"
	self assert: self repositoryUrlInputText text notEmpty description: 'Invalid URL'.
	self assert: self versionInputText text notEmpty description: 'Invalid version'.

	^ CGOMetacelloConfigurationProjectDependency new
		initializeWithRepositoryUrl: self repositoryUrlInputText text
		version: self versionInputText text.
"		configuration: 'Ston'
		repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
		version: #stable."