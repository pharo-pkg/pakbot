activation
systemBrowserToolbarActivator
	<classAnnotation>
	
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1020
		for: ClyManagedProject asCalypsoItemContext, ClyEmptyClassSelectionContext new