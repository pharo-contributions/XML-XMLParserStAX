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
	aBuilder textEvent: self
]

{ #category : #testing }
StAXTextEvent >> isText [
	^ true
]

{ #category : #testing }
StAXTextEvent >> isText: aString [
	^ self string = aString
]

{ #category : #printing }
StAXTextEvent >> printBodyOn: aStream [
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
