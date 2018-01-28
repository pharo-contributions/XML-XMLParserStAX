"
A non-markup string event.
"
Class {
	#name : #StAXStringEvent,
	#superclass : #StAXEvent,
	#instVars : [
		'string'
	],
	#category : #'XML-ParserStAX-Core-XML-ParserStAX-Core'
}

{ #category : #'instance creation' }
StAXStringEvent class >> string: aString [ 
	^self new string: aString
]

{ #category : #converting }
StAXStringEvent >> asString [
	^ self string
]

{ #category : #building }
StAXStringEvent >> buildWith: aBuilder [
	aBuilder buildStringEvent: self
]

{ #category : #testing }
StAXStringEvent >> isEmpty [
	^ self string isEmpty
]

{ #category : #testing }
StAXStringEvent >> isStringEvent [
	^ true
]

{ #category : #testing }
StAXStringEvent >> isStringEvent: aStringOrStringEvent [
	^ self string = aStringOrStringEvent asString
]

{ #category : #testing }
StAXStringEvent >> isWhitespace [
	^ self string isXMLWhitespace
]

{ #category : #testing }
StAXStringEvent >> notEmpty [
	^ self string notEmpty
]

{ #category : #printing }
StAXStringEvent >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self string;
		nextPut: $).
]

{ #category : #accessing }
StAXStringEvent >> string [
	^ string ifNil: [string := '']
]

{ #category : #accessing }
StAXStringEvent >> string: aString [
	string := aString
]

{ #category : #printing }
StAXStringEvent >> writeXMLOn: aWriter [
	aWriter string: self string
]
