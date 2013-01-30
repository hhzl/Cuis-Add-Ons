Cuis has limited Unicode support.

Externally (files and clipboard) UFT8 is used.

Internally ISO8959-15  --> only 255 code points. The rest is converted to numerical character entities.


## Construction of example data for test


http://rishida.net/tools/conversion/


abc αβγ

Decimal NCRs
abc &#945;&#946;&#947;

Hexadecimal NCRs
abc &#x03B1;&#x03B2;&#x03B3;

UTF8 code units
61 62 63 20 CE B1 CE B2 CE B3

JavaScript escapes
abc \u03B1\u03B2\u03B3