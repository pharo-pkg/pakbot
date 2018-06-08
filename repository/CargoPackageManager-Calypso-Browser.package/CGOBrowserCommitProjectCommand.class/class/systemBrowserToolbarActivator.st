activation
systemBrowserToolbarActivator
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: ClyManagedProject asCalypsoItemContext , ClyEmptyClassSelectionContext new