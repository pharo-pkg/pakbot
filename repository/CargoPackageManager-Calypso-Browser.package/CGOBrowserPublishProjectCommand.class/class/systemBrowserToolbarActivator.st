activation
systemBrowserToolbarActivator
	<commandActivator>
	
	^ ClyToolbarCommandActivator
		byItemOf: ClyButtonToolbarGroup
		order: 1020
		for: ClyProjectSystemBrowserContext