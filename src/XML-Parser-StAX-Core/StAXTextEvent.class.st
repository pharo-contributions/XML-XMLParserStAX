"
A text event.
"
Class {
	#name : #StAXTextEvent,
	#superclass : #StAXEvent,
	#instVars : [
		'string'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXTextEvent class >> string: aString [ 
	^self new string: aString
]

{ #category : #building }
StAXTextEvent >> buildWith: aBuilder [
	aBuilder buildTextEvent: self
]

{ #category : #testing }
StAXTextEvent >> isEmpty [
	^ self string isEmpty
]

{ #category : #testing }
StAXTextEvent >> isText [
	^ true
]

{ #category : #testing }
StAXTextEvent >> isText: aString [
	^ self string = aString
]

{ #category : #testing }
StAXTextEvent >> isWhitespace [
	^ self string isXMLWhitespace
]

{ #category : #testing }
StAXTextEvent >> notEmpty [
	^ self string notEmpty
]

{ #category : #printing }
StAXTextEvent >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self string;
		nextPut: $)
]

{ #category : #accessing }
StAXTextEvent >> string [
	^ string ifNil: [string := '']
]

{ #category : #accessing }
StAXTextEvent >> string: aString [
	string := aString
]

{ #category : #printing }
StAXTextEvent >> writeXMLOn: aWriter [
	aWriter string: self string
]
