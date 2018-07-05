activation
systemBrowserToolbarActivator
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1001
		for: ClyEmptyClassSelectionContext new, ClyProjectContextOfFullBrowser  