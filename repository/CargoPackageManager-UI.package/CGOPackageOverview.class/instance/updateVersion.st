updating
updateVersion
	| versionString |
	versionString := versionInputField text.
	versionString asSemanticVersion. "check the version string"
	ongoingPackageVersion version: versionString