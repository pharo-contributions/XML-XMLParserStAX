"
A comment event.
"
Class {
	#name : #StAXCommentEvent,
	#superclass : #StAXEvent,
	#instVars : [
		'string'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXCommentEvent class >> string: aString [
	^ self new string: aString
]

{ #category : #building }
StAXCommentEvent >> buildWith: aBuilder [
	aBuilder commentEvent: self
]

{ #category : #testing }
StAXCommentEvent >> isComment [
	^ true
]

{ #category : #printing }
StAXCommentEvent >> printBodyOn: aStream [
	aStream
		nextPut: $(;
		print: self string;
		nextPut: $)
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
