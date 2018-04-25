activation
systemBrowserToolbarActivator
	<commandActivator>
	^ ClyToolbarCommandActivation
		byItemOf: ClyButtonToolbarGroup
		for: ClyProjectContextOfFullBrowser  