activation
systemBrowserToolbarActivator
	<classAnnotation>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: ClyEmptyClassSelectionContext new, ClyProjectContextOfFullBrowser  