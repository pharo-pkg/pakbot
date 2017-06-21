converting
httpUrlFrom: aString 
	| matcher |
	matcher := 'git@((\w|\d|\.)+)\:(\w+)/(\w+).git' asRegex.
	^ (matcher matches: aString) 
		ifTrue: [ 'https://', (matcher subexpression: 2) , '/' , (matcher subexpression: 4), '/', (matcher subexpression: 5) ]
		ifFalse: [ aString ]
		