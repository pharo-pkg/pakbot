activation
systemBrowserToolbarActivator
	<classAnnotation>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		for: ClyEmptyClassSelectionContext new, ClyProjectContextOfFullBrowser  