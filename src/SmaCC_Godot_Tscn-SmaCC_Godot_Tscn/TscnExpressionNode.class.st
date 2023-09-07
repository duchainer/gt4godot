Class {
	#name : #TscnExpressionNode,
	#superclass : #TscnParseNode,
	#instVars : [
		'comment'
	],
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #generated }
TscnExpressionNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitExpression: self
]

{ #category : #generated }
TscnExpressionNode >> comment [
	^ comment
]

{ #category : #generated }
TscnExpressionNode >> comment: aSmaCCToken [
	comment := aSmaCCToken
]

{ #category : #generated }
TscnExpressionNode >> tokenVariables [
	^ #(#comment)
]
