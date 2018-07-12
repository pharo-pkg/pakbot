accessing
allSubResolutions
	
	^ self subresolutions asArray , (self subresolutions asArray flatCollect: [ :each | each allSubResolutions asArray ])