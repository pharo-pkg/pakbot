loading
load
	| versionLoader |
	versionLoader := MCVersionLoader new.
	self mcVersions 
		do: [ :mcVersion | versionLoader addVersion: mcVersion ].
	versionLoader hasVersions ifTrue: [ versionLoader load ].
	self packageVersions do: 
		[ :pkgVersion |
		CGOPackageRegistry default register: pkgVersion ]