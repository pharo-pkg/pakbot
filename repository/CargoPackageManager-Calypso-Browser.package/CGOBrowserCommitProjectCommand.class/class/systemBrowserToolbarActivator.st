activation
systemBrowserToolbarActivator
	<commandActivator>
	
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: ClyProjectContextOfFullBrowser  