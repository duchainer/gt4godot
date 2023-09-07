Class {
	#name : #TscnParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #generated }
TscnParseNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitParse: self
]
