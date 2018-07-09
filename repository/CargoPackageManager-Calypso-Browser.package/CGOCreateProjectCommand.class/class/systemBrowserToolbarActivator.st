activation
systemBrowserToolbarActivator
	<classAnnotation>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		for: ClyProjectContextOfFullBrowser