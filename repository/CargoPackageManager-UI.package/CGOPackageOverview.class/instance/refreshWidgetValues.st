initialization
refreshWidgetValues
	nameInputField text: ongoingPackageVersion packageName.
	versionInputField text: ongoingPackageVersion version asString.
	ongoingPackageVersion isProject
		ifTrue: [ repositoryInputField text: ongoingPackageVersion repository repositoryUrl ].
	descriptionText text: ongoingPackageVersion description