"
An end tag event.
"
Class {
	#name : #StAXEndTagEvent,
	#superclass : #StAXTagEvent,
	#category : #'XML-ParserStAX-Core'
}

{ #category : #building }
StAXEndTagEvent >> buildWith: aBuilder [
	aBuilder buildEndTagEvent: self
]

{ #category : #testing }
StAXEndTagEvent >> isEndTag [
	^ true
]

{ #category : #testing }
StAXEndTagEvent >> isEndTagNamed: aTagName [
	^ self isNamed: aTagName
]

{ #category : #testing }
StAXEndTagEvent >> isEndTagNamedAny: aTagNameCollection [
	^ self isNamedAny: aTagNameCollection
]

{ #category : #initialization }
StAXEndTagEvent >> setName: aName localName: aLocalName namespaceScope: aNamespaceScope [
	name := aName.
	localName := aLocalName.
	namespaceScope := aNamespaceScope.
]

{ #category : #printing }
StAXEndTagEvent >> writeXMLOn: aWriter [
	aWriter endTag
		name: self name;
		write
]
