querying - installed
isProvidedBy: aInstalledVersion

	^ (aInstalledVersion providesProject: self) or: [ self isInstalledInMetacello ]