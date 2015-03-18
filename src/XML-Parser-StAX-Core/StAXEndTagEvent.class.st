"
An end tag event.
"
Class {
	#name : #StAXEndTagEvent,
	#superclass : #StAXTagEvent,
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #building }
StAXEndTagEvent >> buildWith: aBuilder [
	aBuilder endTagEvent: self
]

{ #category : #testing }
StAXEndTagEvent >> isEndTag [
	^ true
]

{ #category : #testing }
StAXEndTagEvent >> isEndTag: aTagName [
	^ self isNamed: aTagName
]

{ #category : #testing }
StAXEndTagEvent >> isEndTag: aTagName namespaceURI: aUri [
	^ (self isNamed: aTagName) and: [self namespaceURI = aUri]
]

{ #category : #printing }
StAXEndTagEvent >> writeXMLOn: aWriter [
	| tagWriter |

	((tagWriter := aWriter activeTagWriter) notNil
		and: [tagWriter name = self name])
		ifTrue: [tagWriter finishWriting]
]
