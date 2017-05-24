activation
systemBrowserToolbarActivator
	<commandActivator>
	
	^ ClyToolbarCommandActivator 
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: ClyProjectSystemBrowserContext