item resolving
resolvePropertiesOf: myEnvironmentItem
	super resolvePropertiesOf: myEnvironmentItem.
	myEnvironmentItem actualObject isEmpty
		ifFalse: [ myEnvironmentItem markWithChildrenOf: ClyPackageGroupScope ]