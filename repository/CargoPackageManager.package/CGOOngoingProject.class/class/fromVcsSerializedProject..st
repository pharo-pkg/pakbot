instance creation
fromVcsSerializedProject: aVcsSerializedProject
	| ongoing |
	ongoing := self new
		registry: CGOPackageRegistry default;
		yourself.
	aVcsSerializedProject flushIn: ongoing.
	^ ongoing