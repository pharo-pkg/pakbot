loading
load
	| versionLoader |
	versionLoader := MCVersionLoader new.
	self fetch 
		do: [ :mcVersion | versionLoader addVersion: mcVersion ].
	versionLoader load