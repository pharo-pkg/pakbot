execution
checkEmptyResult
	
	scope packagesDo: [ :each | 
		each dependencies do: [ :dependency | ^false]].
	^true
	