initialization
refreshWidgetValues
	nameInputField text: ongoingPackageVersion packageName.
	versionInputField text: ongoingPackageVersion version asString.
	ongoingPackageVersion isProject
		ifTrue: [ ongoingPackageVersion repository ifNotNil: 
			[ :repository | repositoryInputField text: repository repositoryUrl ] ].
	descriptionText text: ongoingPackageVersion description