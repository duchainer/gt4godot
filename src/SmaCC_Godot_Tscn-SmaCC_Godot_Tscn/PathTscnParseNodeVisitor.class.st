Class {
	#name : #PathTscnParseNodeVisitor,
	#superclass : #TscnParseNodeVisitor,
	#instVars : [
		'paths',
		'rootDirectory'
	],
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn-SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #accessing }
PathTscnParseNodeVisitor >> appendPath: aStringPath [
	| filePath |
	filePath := rootDirectory / (aStringPath removePrefix:'res://').
	self paths add: ( filePath asFileReference)
]

{ #category : #accessing }
PathTscnParseNodeVisitor >> paths [
	paths ifNil: [ paths := OrderedCollection new ].
	^ paths
]

{ #category : #accessing }
PathTscnParseNodeVisitor >> paths: somePaths [
	 paths := somePaths
]

{ #category : #accessing }
PathTscnParseNodeVisitor >> rootDirectory: projectPath [ 
	rootDirectory := projectPath asFileReference
]

{ #category : #accessing }
PathTscnParseNodeVisitor >> visitKeyValue: aKeyValue [
	aKeyValue key = 'path' 
	ifTrue: [
		self appendPath: aKeyValue value
	]
]
