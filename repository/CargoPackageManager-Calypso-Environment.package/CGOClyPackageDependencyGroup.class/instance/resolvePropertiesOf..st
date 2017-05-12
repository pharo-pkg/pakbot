item resolving
resolvePropertiesOf: myEnvironmentItem
	super resolvePropertiesOf: myEnvironmentItem.
	package dependencies
		ifNotEmpty: [ myEnvironmentItem markWithChildrenOf: ClyPackageGroupScope ]