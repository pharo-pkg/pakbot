building
buildDependency

	"We should have validations, probably in the domain object itself"
	self assert: self configurationNameInputText text notEmpty description: 'Invalid Configuration Name'.
	self assert: self repositoryUrlInputText text notEmpty description: 'Invalid URL'.
	self assert: self versionInputText text notEmpty description: 'Invalid version'.

	^ PBMetacelloConfigurationProjectDependency
		name: self configurationNameInputText text
		repositoryUrl: self repositoryUrlInputText text
		version: self versionInputText text