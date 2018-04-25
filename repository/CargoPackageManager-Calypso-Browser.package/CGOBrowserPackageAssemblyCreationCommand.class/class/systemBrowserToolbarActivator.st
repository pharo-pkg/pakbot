activation
systemBrowserToolbarActivator
	<commandActivator>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1001
		for: ClyProjectContextOfFullBrowser  