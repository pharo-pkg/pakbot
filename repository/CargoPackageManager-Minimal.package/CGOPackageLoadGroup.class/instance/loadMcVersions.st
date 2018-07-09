loading
loadMcVersions
	| versionLoader |
	versionLoader := MCVersionLoader new.
	self mcVersions
		do: [ :mcVersion | versionLoader addVersion: mcVersion ].
	versionLoader hasVersions
		ifTrue: [ versionLoader load ]