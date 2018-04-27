activation
systemBrowserToolbarActivator
	<classAnnotation>
	
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: ClyManagedProject asCalypsoItemContext , ClyEmptyClassSelectionContext new