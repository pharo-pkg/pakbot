private
normalizeUrl: aString 
	| colonIndex |
	colonIndex := aString indexOf: $:.
	^ aString copyReplaceFrom: colonIndex to: colonIndex with: '/'