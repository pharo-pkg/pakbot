actions
editAction
	"only one fixed constraint managed for now"
	| dependency versionString |
	dependency := self selectedPackage.
	versionString := UIManager default
		request: 'Version for this dependency (or empty if no constraint)'
		initialAnswer: (dependency constraints 
			ifEmpty: [ '' ]
			ifNotEmpty: [ :constraints | constraints first asString allButFirst ])
		title: 'Constraints of ' , dependency targetedPackage , ' package'.
	versionString ifNil: [ ^ self ].
	versionString ifEmpty: [ ^ self ].

	ongoingPackageVersion
		updateDependency: (CGOPackageDependency 
			on: dependency packageName 
			for: dependency dependent
			withConstraints: { CGOFixedVersionConstraint with: versionString }).
	self refreshUI