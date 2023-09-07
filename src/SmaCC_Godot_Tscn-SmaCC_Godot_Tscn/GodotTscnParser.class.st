Class {
	#name : #GodotTscnParser,
	#superclass : #SmaCCGLRParser,
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #generated }
GodotTscnParser class >> ambiguousTransitions [
^#(
#[ 0 66 0 125] 
#[ 0 250 1 93] 
#[ 0 250 1 97] 
#[ 1 78 1 201] 
#[ 0 98 1 98] 
#[ 1 102 1 245]
	).
]

{ #category : #'generated-accessing' }
GodotTscnParser class >> cacheId [
	^'2023-09-07T17:42:18.564-04:00'
]

{ #category : #generated }
GodotTscnParser class >> definitionComment [
"/*
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
""License""); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  ""AS IS"" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
*/

%glr;
%annotate_tokens;
%root Parse;
%prefix Tscn;
%suffix Node;
/*grammar toml;*/

/*
 * Parser Rules
 */

document : expression 'expression' (<NL> expression 'expression')* {{}};

expression : key_value 'keyValue' comment 'comment' | table comment 'comment' | comment 'comment' {{}};

comment: <COMMENT>? ;

key_value : key 'key' ""="" value 'value' {{}};

key : simple_key | dotted_key;

simple_key : quoted_key | unquoted_key ;

unquoted_key : <UNQUOTED_KEY> 'string' { string value };

quoted_key 
	:  basicString
	| literalString;
literalString
	: <LITERAL_STRING> 'string' { string value copyFrom: 2 to: string value size - 1 }
	;
basicString
	: <BASIC_STRING> 'string' { string value copyFrom: 2 to: string value size - 1 }
	;

dotted_key : simple_key (""."" simple_key)+;

value 
	: string
	| integer 
	| floating_point 
	| bool_ 
	| date_time 
	| array_ 
	| inline_table
	| functionCall
	| stringName
	| dictionary_
	| <UNQUOTED_KEY>
	;
dictionary_
	: ""{"" (<NL> entry ( "","" <NL> entry)* )? <NL> ""}""
	;
entry
    : string "":"" value
    ;
functionCall
	: <UNQUOTED_KEY> ""("" arguments "")""
	;
arguments
	: (argument ( "","" argument) * )?
	;
argument
	: string
	| integer 
	| floating_point 
	| bool_ 
	| date_time 
	| array_ 
	| <UNQUOTED_KEY>
	;

string : basicString | mlBasicString | literalString | mlLiteralString;
stringName
	: ""&"" string
	;
mlLiteralString
	: <ML_LITERAL_STRING> 'string' { string value copyFrom: 4 to: string value size -3 }
	;
mlBasicString
	: <ML_BASIC_STRING> 'string' { string value copyFrom: 4 to: string value size -3 }
	;

integer 
	: <DEC_INT> 'int' { (int value copyWithoutAll: '_') asNumber } 
	| <HEX_INT> 
	| <OCT_INT> 
	| <BIN_INT> ;

floating_point : <FLOAT> | <INF> | <NAN> ;

bool_ : <BOOLEAN> 'bool' { bool value = 'true' };

date_time 
	: <OFFSET_DATE_TIME> 'dt' { dt value asDateAndTime } 
	| <LOCAL_DATE_TIME>'dt' { dt value asDateAndTime } 
	| <LOCAL_DATE> 'date' { date value asDate } 
	| <LOCAL_TIME> 'time' { time value asTime } ;
array_ : ""["" array_values? comment_or_nl ""]"" ;

array_values : (comment_or_nl value 'value' nl_or_comment "","" array_values comment_or_nl) | comment_or_nl value 'value' nl_or_comment "",""? ;

comment_or_nl : (<COMMENT>? <NL>)* ;
nl_or_comment : (<NL> <COMMENT>?)* ;

table : standard_table | array_table ;

standard_table 
	: ""["" key 'table_name' ""]"" {{}}
| ""["" key 'table_name' key_value 'key_value' *""]"" {{}}
	;

inline_table : ""{"" inline_table_keyvals ""}"" ;

inline_table_keyvals : inline_table_keyvals_non_empty? ;

inline_table_keyvals_non_empty : key 'key' ""="" value 'value' ("","" inline_table_keyvals_non_empty)? ;

array_table : ""["" ""["" key 'key' ""]"" ""]"" {{}};

/*
 * Lexer Rules
 */

<whitespace> : [\ \t]+ ;
<NL> : (\r? \n)+ ;
<COMMENT> : \# ([^\n])* ;

<DIGIT> : [0-9] ;
<ALPHA> : [A-Za-z] ;

# booleans
<BOOLEAN> : true | false ;

# strings
<ESC> : \\ ([\""\\\/bfnrt] | <UNICODE> | <EX_UNICODE>) ;
<ML_ESC> : \\ \r? \n | <ESC> ;
<UNICODE> : u <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> ;
<EX_UNICODE> : U <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> ;
<BASIC_STRING> : \"" (<ESC> | [^\""\\])* \"" ;
<ML_BASIC_STRING> : \""\""\"" (<ML_ESC> | [^\""\\])* \""\""\"" ;
<LITERAL_STRING> : \' ([^\'\n])* \' ;
<ML_LITERAL_STRING> : \'\'\' ( [^\\\'] | \'[^\'] | \'\'[^\'] )* \'\'\';
# floating point numbers
<EXP> : (e | E) [\+\-]? <ZERO_PREFIXABLE_INT> ;
<ZERO_PREFIXABLE_INT> : <DIGIT> (<DIGIT> | _ <DIGIT>)* ;
<FRAC> : \. <ZERO_PREFIXABLE_INT> ;
<FLOAT> : <DEC_INT> ( <EXP> | <FRAC> <EXP>?) ;
<INF> : [\+\-]? inf ;
<NAN> : [\+\-]? nan ;
# integers
<HEX_DIGIT> : [A-Fa-f] | <DIGIT> ;
<DIGIT_1_9> : [1-9] ;
<DIGIT_0_7> : [0-7] ;
<DIGIT_0_1> : [0-1] ;
<DEC_INT> : [\+\-]? (<DIGIT> | (<DIGIT_1_9> (<DIGIT> | _ <DIGIT>)+)) ;
<HEX_INT> : 0x <HEX_DIGIT> (<HEX_DIGIT> | _ <HEX_DIGIT>)* ;
<OCT_INT> : 0o <DIGIT_0_7> (<DIGIT_0_7> | _ <DIGIT_0_7>)* ;
<BIN_INT> : 0b <DIGIT_0_1> (<DIGIT_0_1> | _ <DIGIT_0_1>)* ;
# dates
<YEAR> : <DIGIT> <DIGIT> <DIGIT> <DIGIT> ;
<MONTH> : <DIGIT> <DIGIT> ;
<DAY> : <DIGIT> <DIGIT> ;
<DELIM> : T | t | \  ;
<HOUR> : <DIGIT> <DIGIT> ;
<MINUTE> : <DIGIT> <DIGIT> ;
<SECOND> : <DIGIT> <DIGIT> ;
<SECFRAC> : \. <DIGIT>+ ;
<NUMOFFSET> : (\+ | \-) <HOUR> \: <MINUTE> ;
<OFFSET> : Z | <NUMOFFSET> ;
<PARTIAL_TIME> : <HOUR> \: <MINUTE> \: <SECOND> <SECFRAC>? ;
<FULL_DATE> : <YEAR> \- <MONTH> \- <DAY> ;
<FULL_TIME> : <PARTIAL_TIME> <OFFSET> ;
<OFFSET_DATE_TIME> : <FULL_DATE> <DELIM> <FULL_TIME> ;
<LOCAL_DATE_TIME> : <FULL_DATE> <DELIM> <PARTIAL_TIME> ;
<LOCAL_DATE> : <FULL_DATE> ;
<LOCAL_TIME> : <PARTIAL_TIME> ;
# keys
<UNQUOTED_KEY> : (<ALPHA> | <DIGIT> | \- | _| \/)+ ;

<non_NL>
	: [\w\d \t:=-_]
	;"
]

{ #category : #accessing }
GodotTscnParser class >> fileExtension [
	^ '.tscn'
]

{ #category : #generated }
GodotTscnParser class >> reduceTable [
^#(
	#(37 0 #nil 1087489 false) 
	#(37 1 #liftFirstValue: 1087490 false) 
	#(44 1 #reduceActionForbasicString1: 1444865 false) 
	#(43 1 #reduceActionForbasicString1: 1341441 false) 
	#(41 1 #reduceActionForunquoted_key1: 1234945 false) 
	#(35 0 #reduceActionFor__NL__expression__expression___1: 940033 false) 
	#(36 1 #reduceActionForexpression3: 979971 false) 
	#(39 1 #liftFirstValue: 1159169 false) 
	#(40 1 #liftFirstValue: 1191938 false) 
	#(40 1 #liftFirstValue: 1191937 false) 
	#(42 1 #liftFirstValue: 1294338 false) 
	#(42 1 #liftFirstValue: 1294337 false) 
	#(39 1 #liftFirstValue: 1159170 false) 
	#(74 1 #liftFirstValue: 3096577 false) 
	#(74 1 #liftFirstValue: 3096578 false) 
	#(76 0 #reduceActionForkey_value__key_value___1: 3211265 false) 
	#(33 2 #reduceActionFordocument1: 904193 false) 
	#(36 2 #liftFirstValue: 979969 false) 
	#(47 1 #liftFirstValue: 1569793 false) 
	#(45 2 #liftFirstValue: 1545217 false) 
	#(36 2 #liftFirstValue: 979970 false) 
	#(75 3 #reduceActionForstandard_table1: 3137537 false) 
	#(35 2 #reduceActionFor__NL__expression__expression___2: 940034 false) 
	#(70 0 #nil 3036161 false) 
	#(78 0 #nil 3296257 false) 
	#(64 1 #reduceActionForbool_1: 2555905 false) 
	#(61 1 #reduceActionFormlBasicString1: 2285569 false) 
	#(60 1 #reduceActionFormlBasicString1: 2178049 false) 
	#(63 1 #liftFirstValue: 2510849 false) 
	#(63 1 #liftFirstValue: 2510850 false) 
	#(63 1 #liftFirstValue: 2510851 false) 
	#(62 1 #reduceActionForinteger1: 2390017 false) 
	#(62 1 #liftFirstValue: 2390018 false) 
	#(62 1 #liftFirstValue: 2390019 false) 
	#(62 1 #liftFirstValue: 2390020 false) 
	#(65 1 #reduceActionFordate_time1: 2608129 false) 
	#(65 1 #reduceActionFordate_time1: 2608130 false) 
	#(65 1 #reduceActionFordate_time3: 2608131 false) 
	#(65 1 #reduceActionFordate_time4: 2608132 false) 
	#(48 1 #liftFirstValue: 1590283 false) 
	#(58 1 #liftFirstValue: 2075651 false) 
	#(58 1 #liftFirstValue: 2075649 false) 
	#(38 3 #reduceActionForkey_value1: 1111041 false) 
	#(48 1 #liftFirstValue: 1590282 false) 
	#(48 1 #liftFirstValue: 1590280 false) 
	#(48 1 #liftFirstValue: 1590273 false) 
	#(48 1 #liftFirstValue: 1590281 false) 
	#(58 1 #liftFirstValue: 2075652 false) 
	#(58 1 #liftFirstValue: 2075650 false) 
	#(48 1 #liftFirstValue: 1590274 false) 
	#(48 1 #liftFirstValue: 1590275 false) 
	#(48 1 #liftFirstValue: 1590276 false) 
	#(48 1 #liftFirstValue: 1590277 false) 
	#(48 1 #liftFirstValue: 1590278 false) 
	#(48 1 #liftFirstValue: 1590279 false) 
	#(46 2 #liftSecondValue: 1569793 false) 
	#(47 2 #liftFirstValue: 1569794 false) 
	#(75 4 #reduceActionForstandard_table2: 3137538 false) 
	#(76 2 #reduceActionForkey_value__key_value___2: 3211266 false) 
	#(34 2 #reduceActionFor__NL__expression__expression__1: 940033 false) 
	#(59 2 #liftSecondValue: 2149377 false) 
	#(68 1 #liftFirstValue: 3019777 false) 
	#(78 1 #liftFirstValue: 3296258 false) 
	#(54 0 #nil 1917953 false) 
	#(80 5 #reduceActionForarray_table1: 3460097 false) 
	#(66 3 #liftSecondValue: 2825217 false) 
	#(73 0 #nil 3074049 false) 
	#(69 1 #liftFirstValue: 3036161 false) 
	#(70 2 #liftFirstValue: 3036162 false) 
	#(49 3 #liftFirstValue: 1759233 false) 
	#(51 0 #nil 1790977 false) 
	#(77 3 #liftSecondValue: 3248129 false) 
	#(57 1 #liftFirstValue: 1966087 false) 
	#(56 0 #nil 1941505 false) 
	#(57 1 #liftFirstValue: 1966081 false) 
	#(57 1 #liftFirstValue: 1966082 false) 
	#(57 1 #liftFirstValue: 1966083 false) 
	#(57 1 #liftFirstValue: 1966084 false) 
	#(57 1 #liftFirstValue: 1966085 false) 
	#(57 1 #liftFirstValue: 1966086 false) 
	#(66 4 #liftSecondValue: 2825218 false) 
	#(67 3 #liftFirstValue: 2874370 false) 
	#(71 1 #liftFirstValue: 3057665 false) 
	#(69 2 #liftFirstValue: 3036162 false) 
	#(79 3 #liftFirstValue: 3355649 false) 
	#(53 4 #reduceActionForfunctionCall1: 1864705 false) 
	#(54 2 #liftFirstValue: 1917954 false) 
	#(67 4 #liftFirstValue: 2874371 false) 
	#(72 1 #liftFirstValue: 3074049 false) 
	#(73 2 #liftFirstValue: 3074050 false) 
	#(51 2 #liftFirstValue: 1790978 false) 
	#(52 3 #liftFirstValue: 1826817 false) 
	#(56 2 #liftFirstValue: 1941506 false) 
	#(72 2 #liftFirstValue: 3074050 false) 
	#(49 6 #reduceActionForfunctionCall1: 1759234 false) 
	#(79 5 #liftFirstValue: 3355650 false) 
	#(55 2 #liftSecondValue: 1941505 false) 
	#(67 6 #liftFirstValue: 2874369 false) 
	#(50 3 #reduceActionForfunctionCall1: 1790977 false)
	).
]

{ #category : #generated }
GodotTscnParser class >> scannerClass [
	^GodotTscnScanner
]

{ #category : #generated }
GodotTscnParser class >> startingStateFordocument [
	^ 1
]

{ #category : #generated }
GodotTscnParser class >> symbolNames [
	^ #('"&"' '"("' '")"' '","' '"."' '":"' '"="' '"["' '"]"' '"{"' '"}"' '<whitespace>' '<NL>' '<COMMENT>' '<BOOLEAN>' '<BASIC_STRING>' '<ML_BASIC_STRING>' '<LITERAL_STRING>' '<ML_LITERAL_STRING>' '<FLOAT>' '<INF>' '<NAN>' '<DEC_INT>' '<HEX_INT>' '<OCT_INT>' '<BIN_INT>' '<OFFSET_DATE_TIME>' '<LOCAL_DATE_TIME>' '<LOCAL_DATE>' '<LOCAL_TIME>' '<UNQUOTED_KEY>' 'B e g i n' 'document' '(<NL> expression ''expression'')' '(<NL> expression ''expression'')*' 'expression' 'comment' 'key_value' 'key' 'simple_key' 'unquoted_key' 'quoted_key' 'literalString' 'basicString' 'dotted_key' '("." simple_key)' '("." simple_key)+' 'value' 'dictionary_' '( "," <NL> entry)' '( "," <NL> entry)*' 'entry' 'functionCall' 'arguments' '( "," argument)' '( "," argument) *' 'argument' 'string' 'stringName' 'mlLiteralString' 'mlBasicString' 'integer' 'floating_point' 'bool_' 'date_time' 'array_' 'array_values' 'comment_or_nl' '(<COMMENT>? <NL>)' '(<COMMENT>? <NL>)*' 'nl_or_comment' '(<NL> <COMMENT>?)' '(<NL> <COMMENT>?)*' 'table' 'standard_table' 'key_value ''key_value'' *' 'inline_table' 'inline_table_keyvals' 'inline_table_keyvals_non_empty' 'array_table' 'E O F' 'error')
]

{ #category : #generated }
GodotTscnParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #TscnDocumentNode #TscnDocumentNode #OrderedCollection #OrderedCollection #TscnParseNode #SmaCCToken #TscnKeyValueNode #Object #Object #Object #Object #Object #Object #Object #Object #Object #Object #Object #Object nil #Object #Object #Object #Object nil #Object #Object #Object #Object #Object #Object #SmaCCToken #Object #Object nil nil nil #SmaCCToken nil nil #SmaCCToken nil #TscnParseNode #TscnStandardTableNode #OrderedCollection #Object #Object #Object #TscnArrayTableNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GodotTscnParser class >> transitionTable [
^#(
#[1 0 9 0 8 0 6 0 13 0 37 0 14 0 17 0 16 0 21 0 18 0 25 0 31 0 29 0 33 0 33 0 36 0 37 0 37 0 41 0 38 0 45 0 39 0 49 0 40 0 49 0 41 0 49 0 42 0 49 0 43 0 49 0 44 0 45 0 45 0 73 0 74 0 73 0 75 0 73 0 80 0 6 0 81] 
#[1 0 85 0 8 0 17 0 16 0 21 0 18 0 25 0 31 0 89 0 39 0 49 0 40 0 49 0 41 0 49 0 42 0 49 0 43 0 49 0 44 0 89 0 45] 
#[0 0 10 0 13 0 81] 
#[0 0 14 0 3 0 4 0 5 0 6 0 7 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 18 0 3 0 4 0 5 0 6 0 7 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 22 0 5 0 7 0 9 0 16 0 18 0 31] 
#[0 0 0 0 81] 
#[1 0 26 0 13 0 93 0 35 0 26 0 81] 
#[0 0 30 0 13 0 81] 
#[1 0 6 0 13 0 97 0 14 0 97 0 37 0 6 0 81] 
#[0 0 101 0 7] 
#[1 0 105 0 5 0 34 0 7 0 34 0 9 0 34 0 16 0 34 0 18 0 34 0 31 0 113 0 46 0 113 0 47] 
#[0 0 38 0 5 0 7 0 9 0 16 0 18 0 31] 
#[0 0 42 0 5 0 7 0 9 0 16 0 18 0 31] 
#[0 0 46 0 5 0 7 0 9 0 16 0 18 0 31] 
#[0 0 50 0 5 0 7 0 9 0 16 0 18 0 31] 
#[0 0 54 0 7 0 9 0 16 0 18 0 31] 
#[1 0 6 0 13 0 117 0 14 0 117 0 37 0 6 0 81] 
#[0 0 58 0 13 0 14 0 81] 
#[0 0 62 0 13 0 14 0 81] 
#[1 0 17 0 16 0 21 0 18 0 25 0 31 0 121 0 39 0 49 0 40 0 49 0 41 0 49 0 42 0 49 0 43 0 49 0 44 0 121 0 45] 
#[1 0 7 0 9 0 66 0 16 0 66 0 18 0 66 0 31 0 129 0 76] 
#[1 0 133 0 13 0 137 0 34 0 70 0 81] 
#[0 0 74 0 13 0 81] 
#[1 0 141 0 1 0 145 0 8 0 149 0 10 0 153 0 15 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 0 221 0 20 0 221 0 21 0 221 0 22 0 177 0 23 0 221 0 24 0 221 0 25 0 221 0 26 0 193 0 27 0 197 0 28 0 201 0 29 0 205 0 30 0 209 0 31 0 221 0 43 0 221 0 44 0 221 0 48 0 221 0 49 0 221 0 53 0 221 0 58 0 221 0 59 0 221 0 60 0 221 0 61 0 221 0 62 0 221 0 63 0 221 0 64 0 221 0 65 0 221 0 66 0 221 0 77] 
#[1 0 17 0 16 0 21 0 18 0 25 0 31 1 17 0 40 1 17 0 41 1 17 0 42 1 17 0 43 1 17 0 44] 
#[0 0 78 0 5 0 7 0 9 0 16 0 18 0 31] 
#[1 0 105 0 5 0 82 0 7 0 82 0 9 0 82 0 16 0 82 0 18 0 82 0 31 1 21 0 46] 
#[0 0 86 0 13 0 81] 
#[0 1 25 0 9] 
#[0 0 90 0 13 0 14 0 81] 
#[1 1 29 0 9 0 17 0 16 0 21 0 18 0 25 0 31 1 33 0 38 0 45 0 39 0 49 0 40 0 49 0 41 0 49 0 42 0 49 0 43 0 49 0 44 0 45 0 45] 
#[1 0 9 0 8 0 6 0 13 0 37 0 14 0 17 0 16 0 21 0 18 0 25 0 31 1 37 0 36 0 37 0 37 0 41 0 38 0 45 0 39 0 49 0 40 0 49 0 41 0 49 0 42 0 49 0 43 0 49 0 44 0 45 0 45 0 73 0 74 0 73 0 75 0 73 0 80 0 6 0 81] 
#[0 0 94 0 13 0 81] 
#[1 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 1 41 0 43 1 41 0 44 1 41 0 58 1 41 0 60 1 41 0 61] 
#[1 0 98 0 1 0 98 0 8 0 98 0 9 0 98 0 10 0 98 0 13 0 98 0 14 0 98 0 15 0 98 0 16 0 98 0 17 0 98 0 18 0 98 0 19 0 98 0 20 0 98 0 21 0 98 0 22 0 98 0 23 0 98 0 24 0 98 0 25 0 98 0 26 0 98 0 27 0 98 0 28 0 98 0 29 0 98 0 30 0 98 0 31 1 45 0 67 1 49 0 68 1 53 0 70] 
#[1 0 102 0 11 1 57 0 13 0 17 0 16 0 21 0 18 0 25 0 31 1 61 0 39 0 49 0 40 0 49 0 41 0 49 0 42 0 49 0 43 0 49 0 44 1 61 0 45 1 65 0 78 1 65 0 79] 
#[0 0 106 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 110 0 3 0 4 0 6 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 114 0 3 0 4 0 6 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 118 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 122 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 126 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 130 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 134 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 138 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 142 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 146 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 150 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 154 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 158 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[1 1 73 0 2 0 162 0 4 0 162 0 9 0 162 0 11 0 162 0 13 0 162 0 14 0 162 0 16 0 162 0 18 0 162 0 31 0 162 0 81] 
#[0 0 166 0 3 0 4 0 6 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 170 0 3 0 4 0 6 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 174 0 9 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 178 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 182 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 186 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 190 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 194 0 3 0 4 0 6 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 198 0 3 0 4 0 6 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 202 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 206 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 210 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 214 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 218 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 222 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 0 226 0 5 0 7 0 9 0 16 0 18 0 31] 
#[0 0 230 0 5 0 7 0 9 0 16 0 18 0 31] 
#[0 1 77 0 9] 
#[0 0 234 0 13 0 14 0 81] 
#[0 0 238 0 9 0 16 0 18 0 31] 
#[0 0 242 0 13 0 81] 
#[0 0 246 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[1 0 98 0 9 0 98 0 13 0 98 0 14 1 81 0 68 1 53 0 70] 
#[1 0 141 0 1 0 145 0 8 1 85 0 9 0 149 0 10 0 153 0 15 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 1 89 0 20 1 89 0 21 1 89 0 22 0 177 0 23 1 89 0 24 1 89 0 25 1 89 0 26 0 193 0 27 0 197 0 28 0 201 0 29 0 205 0 30 0 209 0 31 1 89 0 43 1 89 0 44 1 89 0 48 1 89 0 49 1 89 0 53 1 89 0 58 1 89 0 59 1 89 0 60 1 89 0 61 1 89 0 62 1 89 0 63 1 89 0 64 1 89 0 65 1 89 0 66 1 89 0 77] 
#[1 0 250 0 1 0 250 0 8 0 250 0 9 0 250 0 10 0 11 0 13 0 15 0 14 0 250 0 15 0 250 0 16 0 250 0 17 0 250 0 18 0 250 0 19 0 250 0 20 0 250 0 21 0 250 0 22 0 250 0 23 0 250 0 24 0 250 0 25 0 250 0 26 0 250 0 27 0 250 0 28 0 250 0 29 0 250 0 30 0 250 0 31 1 101 0 69] 
#[1 1 105 0 11 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 1 113 0 43 1 113 0 44 1 109 0 52 1 113 0 58 1 113 0 60 1 113 0 61] 
#[0 1 117 0 7] 
#[0 1 121 0 11] 
#[0 0 254 0 11] 
#[1 1 2 0 3 0 145 0 8 0 153 0 15 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 1 133 0 20 1 133 0 21 1 133 0 22 0 177 0 23 1 133 0 24 1 133 0 25 1 133 0 26 0 193 0 27 0 197 0 28 0 201 0 29 0 205 0 30 1 133 0 31 1 133 0 43 1 133 0 44 1 129 0 54 1 133 0 57 1 133 0 58 1 133 0 60 1 133 0 61 1 133 0 62 1 133 0 63 1 133 0 64 1 133 0 65 1 133 0 66] 
#[0 1 6 0 13 0 14 0 81] 
#[0 1 161 0 9] 
#[0 1 10 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[1 1 14 0 4 1 14 0 9 1 14 0 13 1 14 0 14 1 165 0 71 1 169 0 73] 
#[0 1 18 0 1 0 8 0 9 0 10 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31] 
#[0 1 173 0 13] 
#[0 1 22 0 1 0 8 0 9 0 10 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31] 
#[0 1 26 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[1 1 30 0 4 1 30 0 13 1 177 0 51] 
#[0 1 181 0 6] 
#[1 0 141 0 1 0 145 0 8 0 149 0 10 0 153 0 15 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 1 185 0 20 1 185 0 21 1 185 0 22 0 177 0 23 1 185 0 24 1 185 0 25 1 185 0 26 0 193 0 27 0 197 0 28 0 201 0 29 0 205 0 30 0 209 0 31 1 185 0 43 1 185 0 44 1 185 0 48 1 185 0 49 1 185 0 53 1 185 0 58 1 185 0 59 1 185 0 60 1 185 0 61 1 185 0 62 1 185 0 63 1 185 0 64 1 185 0 65 1 185 0 66 1 185 0 77] 
#[0 1 34 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 1 38 0 3 0 4] 
#[0 1 189 0 3] 
#[1 1 42 0 3 1 42 0 4 1 193 0 56] 
#[0 1 46 0 3 0 4] 
#[0 1 50 0 3 0 4] 
#[0 1 54 0 3 0 4] 
#[0 1 58 0 3 0 4] 
#[0 1 62 0 3 0 4] 
#[0 1 66 0 3 0 4] 
#[0 1 70 0 3 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[1 1 197 0 4 1 74 0 9 1 74 0 13 1 74 0 14] 
#[1 1 78 0 4 1 78 0 9 0 19 0 13 1 78 0 14 1 205 0 72] 
#[0 1 82 0 1 0 8 0 9 0 10 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31] 
#[1 1 209 0 4 1 213 0 13 1 217 0 50] 
#[1 0 141 0 1 0 145 0 8 0 149 0 10 0 153 0 15 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 1 221 0 20 1 221 0 21 1 221 0 22 0 177 0 23 1 221 0 24 1 221 0 25 1 221 0 26 0 193 0 27 0 197 0 28 0 201 0 29 0 205 0 30 0 209 0 31 1 221 0 43 1 221 0 44 1 221 0 48 1 221 0 49 1 221 0 53 1 221 0 58 1 221 0 59 1 221 0 60 1 221 0 61 1 221 0 62 1 221 0 63 1 221 0 64 1 221 0 65 1 221 0 66 1 221 0 77] 
#[1 1 225 0 4 1 86 0 11] 
#[0 1 90 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[1 1 94 0 3 1 229 0 4 1 233 0 55] 
#[1 0 98 0 1 0 98 0 8 1 98 0 9 0 98 0 10 0 23 0 13 0 23 0 14 0 98 0 15 0 98 0 16 0 98 0 17 0 98 0 18 0 98 0 19 0 98 0 20 0 98 0 21 0 98 0 22 0 98 0 23 0 98 0 24 0 98 0 25 0 98 0 26 0 98 0 27 0 98 0 28 0 98 0 29 0 98 0 30 0 98 0 31 1 237 0 67 1 241 0 68 1 53 0 70] 
#[1 1 102 0 4 1 102 0 9 1 102 0 13 0 27 0 14] 
#[0 1 106 0 4 0 9 0 13 0 14] 
#[0 1 249 0 13] 
#[0 1 253 0 11] 
#[0 1 110 0 4 0 13] 
#[0 1 114 0 4 0 13] 
#[1 0 17 0 16 0 21 0 18 0 25 0 31 1 61 0 39 0 49 0 40 0 49 0 41 0 49 0 42 0 49 0 43 0 49 0 44 1 61 0 45 2 1 0 79] 
#[1 0 145 0 8 0 153 0 15 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 2 5 0 20 2 5 0 21 2 5 0 22 0 177 0 23 2 5 0 24 2 5 0 25 2 5 0 26 0 193 0 27 0 197 0 28 0 201 0 29 0 205 0 30 2 5 0 31 2 5 0 43 2 5 0 44 2 5 0 57 2 5 0 58 2 5 0 60 2 5 0 61 2 5 0 62 2 5 0 63 2 5 0 64 2 5 0 65 2 5 0 66] 
#[0 1 118 0 3 0 4] 
#[1 0 98 0 9 0 98 0 13 0 98 0 14 2 9 0 68 1 53 0 70] 
#[1 0 141 0 1 0 145 0 8 0 149 0 10 0 153 0 15 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 1 89 0 20 1 89 0 21 1 89 0 22 0 177 0 23 1 89 0 24 1 89 0 25 1 89 0 26 0 193 0 27 0 197 0 28 0 201 0 29 0 205 0 30 0 209 0 31 1 89 0 43 1 89 0 44 1 89 0 48 1 89 0 49 1 89 0 53 1 89 0 58 1 89 0 59 1 89 0 60 1 89 0 61 1 89 0 62 1 89 0 63 1 89 0 64 1 89 0 65 1 89 0 66 1 89 0 77] 
#[0 1 122 0 4 0 9 0 13 0 14] 
#[1 0 17 0 16 0 157 0 17 0 21 0 18 0 161 0 19 1 113 0 43 1 113 0 44 2 13 0 52 1 113 0 58 1 113 0 60 1 113 0 61] 
#[0 1 126 0 4 0 9 0 11 0 13 0 14 0 16 0 18 0 31 0 81] 
#[0 1 130 0 11] 
#[0 1 134 0 3 0 4] 
#[0 1 138 0 9 0 13 0 14] 
#[0 1 142 0 4 0 13]
	).
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionFor__NL__expression__expression__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionFor__NL__expression__expression___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionFor__NL__expression__expression___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForarray_table1: nodes [
	| result |
	result := TscnArrayTableNode new.
	result addToken: (nodes at: 1) to: result leftBracketTokens.
	result addToken: (nodes at: 2) to: result leftBracketTokens.
	result key: (nodes at: 3).
	result addToken: (nodes at: 4) to: result rightBracketTokens.
	result addToken: (nodes at: 5) to: result rightBracketTokens.
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForbasicString1: nodes [
	^ (nodes at: 1) value copyFrom: 2 to: (nodes at: 1) value size - 1
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForbool_1: nodes [
	^ (nodes at: 1) value = 'true'
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionFordate_time1: nodes [
	^ (nodes at: 1) value asDateAndTime
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionFordate_time3: nodes [
	^ (nodes at: 1) value asDate
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionFordate_time4: nodes [
	^ (nodes at: 1) value asTime
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionFordocument1: nodes [
	| result |
	result := TscnDocumentNode new.
	result addNode: (nodes at: 1) to: result expressions.
	result addTokens: ((nodes at: 2) at: 1) to: result nLTokens.
	result addNodes: ((nodes at: 2) at: 2) to: result expressions.
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForexpression3: nodes [
	| result |
	result := TscnExpressionNode new.
	result comment: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForfunctionCall1: nodes [
	^ nodes at: 3
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForinteger1: nodes [
	^ ((nodes at: 1) value copyWithoutAll: '_') asNumber
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForkey_value1: nodes [
	| result |
	result := TscnKeyValueNode new.
	result key: (nodes at: 1).
	result equalToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForkey_value__key_value___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForkey_value__key_value___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionFormlBasicString1: nodes [
	^ (nodes at: 1) value copyFrom: 4 to: (nodes at: 1) value size - 3
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForstandard_table1: nodes [
	| result |
	result := TscnStandardTableNode new.
	result leftBracketToken: (nodes at: 1).
	result table_name: (nodes at: 2).
	result rightBracketToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForstandard_table2: nodes [
	| result |
	result := TscnStandardTableNode new.
	result leftBracketToken: (nodes at: 1).
	result table_name: (nodes at: 2).
	result addNodes: (nodes at: 3) to: result key_values.
	result rightBracketToken: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GodotTscnParser >> reduceActionForunquoted_key1: nodes [
	^ (nodes at: 1) value
]
