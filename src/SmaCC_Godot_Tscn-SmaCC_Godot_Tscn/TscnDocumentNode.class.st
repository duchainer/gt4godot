Class {
	#name : #TscnDocumentNode,
	#superclass : #TscnParseNode,
	#instVars : [
		'expressions',
		'nLTokens'
	],
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #generated }
TscnDocumentNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitDocument: self
]

{ #category : #generated }
TscnDocumentNode >> compositeNodeVariables [
	^ #(#expressions)
]

{ #category : #generated }
TscnDocumentNode >> compositeTokenVariables [
	^ #(#nLTokens)
]

{ #category : #generated }
TscnDocumentNode >> expressions [
	^ expressions
]

{ #category : #generated }
TscnDocumentNode >> expressions: anOrderedCollection [
	self setParents: self expressions to: nil.
	expressions := anOrderedCollection.
	self setParents: self expressions to: self
]

{ #category : #'generated-initialize-release' }
TscnDocumentNode >> initialize [
	super initialize.
	expressions := OrderedCollection new: 2.
	nLTokens := OrderedCollection new: 2.
]

{ #category : #generated }
TscnDocumentNode >> nLTokens [
	^ nLTokens
]

{ #category : #generated }
TscnDocumentNode >> nLTokens: anOrderedCollection [
	nLTokens := anOrderedCollection
]
