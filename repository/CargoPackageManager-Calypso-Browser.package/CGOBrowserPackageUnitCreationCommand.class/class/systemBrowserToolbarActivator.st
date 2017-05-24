activation
systemBrowserToolbarActivator
	<commandActivator>
	^ ClyToolbarCommandActivator
		byItemOf: ClyButtonToolbarGroup
		order: 1000
		for: ClyProjectSystemBrowserContext