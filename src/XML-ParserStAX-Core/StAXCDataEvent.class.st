"
A non-markup string event from a CDATA section. See #usesSeparateCDataEvents:.
"
Class {
	#name : #StAXCDataEvent,
	#superclass : #StAXStringEvent,
	#category : #'XML-ParserStAX-Core-XML-ParserStAX-Core'
}

{ #category : #building }
StAXCDataEvent >> buildWith: aBuilder [
	aBuilder buildCDataEvent: self
]

{ #category : #testing }
StAXCDataEvent >> isCData [
	^ true
]

{ #category : #printing }
StAXCDataEvent >> writeXMLOn: aWriter [
	aWriter cdata: self string
]
