Class {
	#name : #TscnKeyValueNode,
	#superclass : #TscnParseNode,
	#instVars : [
		'key',
		'equalToken',
		'value'
	],
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #generated }
TscnKeyValueNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitKeyValue: self
]

{ #category : #generated }
TscnKeyValueNode >> equalToken [
	^ equalToken
]

{ #category : #generated }
TscnKeyValueNode >> equalToken: aSmaCCToken [
	equalToken := aSmaCCToken
]

{ #category : #generated }
TscnKeyValueNode >> key [
	^ key
]

{ #category : #generated }
TscnKeyValueNode >> key: anObject [
	self setParent: self key to: nil.
	key := anObject.
	self setParent: self key to: self
]

{ #category : #generated }
TscnKeyValueNode >> otherVariables [
	^ #(#key #value)
]

{ #category : #generated }
TscnKeyValueNode >> tokenVariables [
	^ #(#equalToken)
]

{ #category : #generated }
TscnKeyValueNode >> value [
	^ value
]

{ #category : #generated }
TscnKeyValueNode >> value: anObject [
	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]
