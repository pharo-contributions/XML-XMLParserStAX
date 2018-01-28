"
A comment event.
"
Class {
	#name : #StAXCommentEvent,
	#superclass : #StAXEvent,
	#instVars : [
		'string'
	],
	#category : #'XML-ParserStAX-Core-XML-ParserStAX-Core'
}

{ #category : #'instance creation' }
StAXCommentEvent class >> string: aString [
	^ self new string: aString
]

{ #category : #building }
StAXCommentEvent >> buildWith: aBuilder [
	aBuilder buildCommentEvent: self
]

{ #category : #testing }
StAXCommentEvent >> isComment [
	^ true
]

{ #category : #printing }
StAXCommentEvent >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self string;
		nextPut: $).
]

{ #category : #accessing }
StAXCommentEvent >> string [
	^ string ifNil: [string := '']
]

{ #category : #accessing }
StAXCommentEvent >> string: aString [
	string := aString
]

{ #category : #printing }
StAXCommentEvent >> writeXMLOn: aWriter [
	aWriter comment: self string
]
