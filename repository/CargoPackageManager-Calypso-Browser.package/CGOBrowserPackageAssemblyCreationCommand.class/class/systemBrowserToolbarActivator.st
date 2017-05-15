activation
systemBrowserToolbarActivator
	<commandActivator>
	^ ClyToolbarCommandActivator
		byItemOf: ClyButtonToolbarGroup
		for: ClyPackageGroupSystemBrowserContext