execution
buildResult: aQueryResult

	| dependencies |
	dependencies := OrderedCollection new.
	
	scope packagesDo: [ :each | 
		each dependencies do: [ :dependency |
			each add: (dependency managedByCalypsoUsing: each manager)]].
	
	aQueryResult fillWith: dependencies