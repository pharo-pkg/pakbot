instance creation
for: aProjectName
	
	self deprecated: 'Please use #named: instead'
		transformWith: '`@receiver for: `@statements1' 
						-> '`@receiver named: `@statements1'.
	
	^ self named: aProjectName