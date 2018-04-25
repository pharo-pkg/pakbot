activation
systemBrowserToolbarActivator
	<commandActivator>
	
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1020
		for: ClyProjectContextOfFullBrowser  