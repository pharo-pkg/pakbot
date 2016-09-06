initialization
refreshWidgetValues
	nameInputField text: ongoingPackageVersion packageName.
	versionInputField text: ongoingPackageVersion version asString.
	ongoingPackageVersion repositories 
		ifEmpty: [ repositoryValueLabel label: '' ]
		ifNotEmpty: [ repositoryValueLabel label: ongoingPackageVersion repositories first ].
	descriptionText text: ongoingPackageVersion description