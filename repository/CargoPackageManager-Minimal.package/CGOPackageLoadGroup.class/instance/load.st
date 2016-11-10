loading
load
	| versionLoader |
	versionLoader := MCVersionLoader new.
	self mcVersions 
		do: [ :mcVersion | versionLoader addVersion: mcVersion ].
	versionLoader load