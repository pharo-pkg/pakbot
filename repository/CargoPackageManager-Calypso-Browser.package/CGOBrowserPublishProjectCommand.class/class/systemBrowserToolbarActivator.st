activation
systemBrowserToolbarActivator
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1020
		for: ClyManagedProject asCalypsoItemContext, ClyEmptyClassSelectionContext new