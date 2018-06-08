activation
systemBrowserToolbarActivator
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: ClyEmptyClassSelectionContext new, ClyProjectContextOfFullBrowser  