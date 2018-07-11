accessing
allAvailableFor: aProject

	^ self allSubclasses 
		select: [ :aClass | aClass isAvailableFor: aProject ] 
		thenCollect: [ :aClass | aClass forProject: aProject ]