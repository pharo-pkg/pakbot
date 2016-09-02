defaults
packageDescriptionCache
	[ ^ (MCCacheRepository uniqueInstance directory / 'package-descriptions') 
			ensureCreateDirectory; 
			yourself ]
	on: Error 
	do: [ Error signal: 'Can''t create a cache for package-description' ]