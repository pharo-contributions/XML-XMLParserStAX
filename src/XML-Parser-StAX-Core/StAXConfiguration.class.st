"
StAX-specific configuration options.
"
Class {
	#name : #StAXConfiguration,
	#superclass : #XMLConfiguration,
	#instVars : [
		'skipsCommentEvents',
		'skipsPIEvents',
		'usesSeparateCDataEvents'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #converting }
StAXConfiguration >> asDOMConfiguration [
	^ XMLDOMConfiguration new
		isValidating: self isValidating;
		usesNamespaces: self usesNamespaces;
		requiresDocumentConstraints: self requiresDocumentConstraints;
		parserLimits: self parserLimits;
		entityConfiguration: self entityConfiguration;
		preservesCDataNodes: self usesSeparateCDataEvents;
		preservesCommentNodes: self skipsCommentEvents not
]

{ #category : #accessing }
StAXConfiguration >> defaultParserHandlerClass [
	^ StAXParser
]

{ #category : #initialization }
StAXConfiguration >> initialize [
	super initialize.

	usesSeparateCDataEvents := true.
	skipsCommentEvents := false.
	skipsPIEvents := false.
]

{ #category : #accessing }
StAXConfiguration >> skipsCommentEvents [
	^ skipsCommentEvents
]

{ #category : #accessing }
StAXConfiguration >> skipsCommentEvents: aBoolean [
	skipsCommentEvents := aBoolean
]

{ #category : #accessing }
StAXConfiguration >> skipsPIEvents [
	^ skipsPIEvents
]

{ #category : #accessing }
StAXConfiguration >> skipsPIEvents: aBoolean [
	skipsPIEvents := aBoolean
]

{ #category : #accessing }
StAXConfiguration >> usesSeparateCDataEvents [
	^ usesSeparateCDataEvents
]

{ #category : #accessing }
StAXConfiguration >> usesSeparateCDataEvents: aBoolean [
	usesSeparateCDataEvents := aBoolean
]
