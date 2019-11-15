"
XMLParserStAX is a pull parser in Pharo for XMLParser that provides a streaming interface for ""pulling"" XML events and also supports pull-style DOM parsing for dynamically converting events into DOM nodes.

(see https://github.com/pharo-contributions/XML-XMLParserStAX)
"
Class {
	#name : #BaselineOfXMLParserStAX,
	#superclass : #BaselineOf,
	#category : #BaselineOfXMLParserStAX
}

{ #category : #baseline }
BaselineOfXMLParserStAX >> baselineOf: spec [
	<baseline>
	
	spec
		for: #common
		do: [
			
			self xmlParserOn: spec.		
			
			"Packages"
			spec 
				package: 'XML-ParserStAX-Core' with: [ spec requires: #('XMLParser') ];
				package: 'XML-ParserStAX-Tests' with: [ spec requires: #('XMLParser Tests' 'XML-ParserStAX-Core') ].
			
			"Groups"
			spec
				group: 'Core' with: #('XML-ParserStAX-Core');
				group: 'Tools' with: #('XMLParser Tools'); 
				group: 'Tests' with: #('XML-ParserStAX-Tests');	
				group: 'all' with: #('Core' 'Tools' 'Tests');
				group: 'default' with: #('all')	
	]
]

{ #category : #baseline }
BaselineOfXMLParserStAX >> xmlParserOn: spec [

	spec
		baseline: 'XMLParser'
      with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/XML-XMLParser:3.5.x/src' ]. 
				
	spec 
		project: 'XMLParser Tests' copyFrom: 'XMLParser' with: [ spec loads: #('Tests') ]; 	
		project: 'XMLParser Tools' copyFrom: 'XMLParser' with: [ spec loads: #('Tools') ] 
]
