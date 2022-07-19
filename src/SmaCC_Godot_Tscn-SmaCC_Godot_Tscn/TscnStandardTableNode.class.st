Class {
	#name : #TscnStandardTableNode,
	#superclass : #TscnParseNode,
	#instVars : [
		'leftBracketToken',
		'table_name',
		'rightBracketToken',
		'key_values'
	],
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #generated }
TscnStandardTableNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitStandardTable: self
]

{ #category : #generated }
TscnStandardTableNode >> compositeNodeVariables [
	^ #(#key_values)
]

{ #category : #'generated-initialize-release' }
TscnStandardTableNode >> initialize [
	super initialize.
	key_values := OrderedCollection new: 2.
]

{ #category : #generated }
TscnStandardTableNode >> key_values [
	^ key_values
]

{ #category : #generated }
TscnStandardTableNode >> key_values: anOrderedCollection [
	self setParents: self key_values to: nil.
	key_values := anOrderedCollection.
	self setParents: self key_values to: self
]

{ #category : #generated }
TscnStandardTableNode >> leftBracketToken [
	^ leftBracketToken
]

{ #category : #generated }
TscnStandardTableNode >> leftBracketToken: aSmaCCToken [
	leftBracketToken := aSmaCCToken
]

{ #category : #generated }
TscnStandardTableNode >> otherVariables [
	^ #(#table_name)
]

{ #category : #generated }
TscnStandardTableNode >> rightBracketToken [
	^ rightBracketToken
]

{ #category : #generated }
TscnStandardTableNode >> rightBracketToken: aSmaCCToken [
	rightBracketToken := aSmaCCToken
]

{ #category : #generated }
TscnStandardTableNode >> table_name [
	^ table_name
]

{ #category : #generated }
TscnStandardTableNode >> table_name: anObject [
	self setParent: self table_name to: nil.
	table_name := anObject.
	self setParent: self table_name to: self
]

{ #category : #generated }
TscnStandardTableNode >> tokenVariables [
	^ #(#leftBracketToken #rightBracketToken)
]
