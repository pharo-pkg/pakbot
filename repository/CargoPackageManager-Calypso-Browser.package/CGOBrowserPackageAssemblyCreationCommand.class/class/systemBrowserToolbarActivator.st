activation
systemBrowserToolbarActivator
	<classAnnotation>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1001
		for: ClyEmptyClassSelectionContext new, ClyProjectContextOfFullBrowser  