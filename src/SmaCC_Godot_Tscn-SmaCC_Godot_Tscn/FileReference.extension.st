Extension { #name : #FileReference }

{ #category : #'*SmaCC_Godot_Tscn-SmaCC_Godot_Tscn' }
FileReference >> newMethod [
	"This is a new method"
]

{ #category : #'*SmaCC_Godot_Tscn-SmaCC_Godot_Tscn' }
FileReference >> parseTscn [
	| ast |
	^ self isDirectory ifFalse: [
	ast := (GodotTscnParser parseFile: self)
	PathTscnParseNodeVisitor accept: ast
	] 
]

{ #category : #'*SmaCC_Godot_Tscn-SmaCC_Godot_Tscn' }
FileReference >> parseTscnFile [
	| ast |
	^ self isDirectory ifFalse: [
	ast := (GodotTscnParser parseFile: self)
	PathTscnParseNodeVisitor accept: ast
	] 
]
