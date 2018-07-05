activation
systemBrowserMenuActivator
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: CGOSCMMenuGroup
		order: 10000
		for: ClyManagedProject asCalypsoItemContext 