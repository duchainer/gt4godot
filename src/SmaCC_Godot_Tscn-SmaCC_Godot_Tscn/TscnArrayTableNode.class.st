Class {
	#name : #TscnArrayTableNode,
	#superclass : #TscnParseNode,
	#instVars : [
		'leftBracketTokens',
		'key',
		'rightBracketTokens'
	],
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #generated }
TscnArrayTableNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitArrayTable: self
]

{ #category : #generated }
TscnArrayTableNode >> compositeTokenVariables [
	^ #(#leftBracketTokens #rightBracketTokens)
]

{ #category : #'generated-initialize-release' }
TscnArrayTableNode >> initialize [
	super initialize.
	leftBracketTokens := OrderedCollection new: 2.
	rightBracketTokens := OrderedCollection new: 2.
]

{ #category : #generated }
TscnArrayTableNode >> key [
	^ key
]

{ #category : #generated }
TscnArrayTableNode >> key: anObject [
	self setParent: self key to: nil.
	key := anObject.
	self setParent: self key to: self
]

{ #category : #generated }
TscnArrayTableNode >> leftBracketTokens [
	^ leftBracketTokens
]

{ #category : #generated }
TscnArrayTableNode >> leftBracketTokens: anOrderedCollection [
	leftBracketTokens := anOrderedCollection
]

{ #category : #generated }
TscnArrayTableNode >> otherVariables [
	^ #(#key)
]

{ #category : #generated }
TscnArrayTableNode >> rightBracketTokens [
	^ rightBracketTokens
]

{ #category : #generated }
TscnArrayTableNode >> rightBracketTokens: anOrderedCollection [
	rightBracketTokens := anOrderedCollection
]
