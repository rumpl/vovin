{
    var ENCODING = 'ENCODING';
    var INPUT = 'INPUT';
    var SURVEY = 'SURVEY';
}

start
    = statements*

statements
    = encoding
    / input
    / survey
//    / centerline
//    / scrap
//    / point
//    / line
//    / area
//    / join

encoding "encoding"
    = "encoding" _ keyword:keyword __ { return { type: ENCODING, encoding: keyword }; }

input "input"
    = "input" _ name:string __ { return { type: INPUT, name: name }; }

survey "survey"
    = "survey" _ name:keyword _ namespace:("-" namespace)? __ survey:th_objects* __ "endsurvey" _ name2:keyword? __ { return { type: SURVEY, name: name, survey: survey, namespace: namespace ? namespace[1].namespace : "on" }; }


namespace
    = "namespace" _ value:("on" / "off") __ { return { namespace: value }; }

th_objects
    = line
    / namespace
    / survey

line "line"
    = "line" __ { return "line"; }


keyword "keyword"
    = start:start_keyword end:end_keyword { return start + end; }

start_keyword
    = parts:[A-za-z0-9_/]+ { return parts.join(""); }

end_keyword
    = parts:[A-za-z0-9_\-/]* { return parts.join(""); }

string
    = '"' str:characters '"' { return str; }

characters
    = chars:character+ { return chars.join(""); }

character
    = !('"')  char:. { return char; }

ext_keyword = [A-za-z0-9_/]+[A-za-z0-9_\-/+*.,']*

lineterminator "end of line"
    = "\n"
    / "\r\n"
    / "\r"
_
    = whitespace*
__
  = (whitespace / lineterminator)*

whitespace
    = [ \t]
