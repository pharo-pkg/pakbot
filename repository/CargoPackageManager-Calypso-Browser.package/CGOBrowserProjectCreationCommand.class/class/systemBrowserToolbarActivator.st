activation
systemBrowserToolbarActivator
	<classAnnotation>
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		for: ClyEmptyClassSelectionContext new, ClyProjectContextOfFullBrowser  