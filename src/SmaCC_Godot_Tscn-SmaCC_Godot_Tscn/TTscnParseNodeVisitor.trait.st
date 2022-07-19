Trait {
	#name : #TTscnParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #generated }
TTscnParseNodeVisitor >> visitArrayTable: anArrayTable [
	^ self visitParse: anArrayTable
]

{ #category : #generated }
TTscnParseNodeVisitor >> visitDocument: aDocument [
	^ self visitParse: aDocument
]

{ #category : #generated }
TTscnParseNodeVisitor >> visitExpression: anExpression [
	^ self visitParse: anExpression
]

{ #category : #generated }
TTscnParseNodeVisitor >> visitKeyValue: aKeyValue [
	^ self visitParse: aKeyValue
]

{ #category : #generated }
TTscnParseNodeVisitor >> visitParse: aParse [
	^ self visitSmaCCParseNode: aParse
]

{ #category : #generated }
TTscnParseNodeVisitor >> visitStandardTable: aStandardTable [
	^ self visitParse: aStandardTable
]
