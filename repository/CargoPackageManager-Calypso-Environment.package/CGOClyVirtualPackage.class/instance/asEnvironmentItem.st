converting
asEnvironmentItem
	| item |
	item := super asEnvironmentItem.
	item scope: ClyPackageGroupScope.
	^ item