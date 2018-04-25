activation
systemBrowserToolbarActivator
	<commandActivator>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: ClyProjectContextOfFullBrowser  