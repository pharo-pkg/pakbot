initialization
refreshWidgetValues
	provisionsInputField text: (ongoingPackageUnit provisions
		ifEmpty: [ '' ]
		ifNotEmpty: [ Character space join: ongoingPackageUnit provisions ]).
	"fileInputField text: ongoingPackageUnit file."
	platformRequirementWidget := self buildPlatformTagsMorph asSpecAdapter