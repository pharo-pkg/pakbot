Extension { #name : #IceProjectReader }

{ #category : #'*Pakbot-Minimal' }
IceProjectReader class >> availableReaders [
	^ (self allSubclasses collect: [ :each | each new ])
			sorted: [ :a :b | a priority < b priority ]
]
