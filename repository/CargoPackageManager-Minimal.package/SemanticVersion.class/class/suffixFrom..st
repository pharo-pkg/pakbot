private
suffixFrom: aString
	"discard all numbers until another character is found."
	| regex |

	regex := '([0-9]+)(.*)' asRegex.
	regex matches: aString.
	^ (regex subexpression: 3) ifEmpty: [ nil ]