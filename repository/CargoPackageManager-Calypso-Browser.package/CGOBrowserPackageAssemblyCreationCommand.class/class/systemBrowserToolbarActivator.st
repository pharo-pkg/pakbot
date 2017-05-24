activation
systemBrowserToolbarActivator
	<commandActivator>
	^ ClyToolbarCommandActivator
		byItemOf: ClyButtonToolbarGroup
		order: 1001
		for: ClyProjectSystemBrowserContext