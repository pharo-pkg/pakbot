instance creation
fromVcsSerializedProject: aVcsSerializedProject
	| ongoing |
	ongoing := self basicNew
		registry: CGOPackageRegistry default;
		yourself.
	aVcsSerializedProject flushIn: ongoing.
	^ ongoing