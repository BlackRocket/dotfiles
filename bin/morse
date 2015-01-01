#!/bin/bash
##################################################
# Morse code encoding and decoding		 #
##################################################

###### this is a short Morse code decoder written as a shellscript using sed
# the Morse coded text should be written with spaces between the letters
# only good to convert from Morse code to text
# by scvalex
function morse2text()
{
echo $1\  | tr . 0 | sed -e {s/0----\ /1/g} -e {s/00---\ /2/g} -e {s/000--\ /3/g} -e {s/000-\ /4/g} -e {s/00000\ /5/g} -e {s/-0000\ /6/g} -e {s/--000\ /7/g} -e {s/---00\ /8/g} -e {s/----0\ /9/g} -e {s/-----\ /0/g} \
	| sed -e {s/-0-0\ /c/g} -e {s/-000\ /b/g} -e {s/00-0\ /f/g} -e {s/0000\ /h/g} -e {s/0---\ /j/g} -e {s/0-00\ /l/g} -e {s/0--0\ /p/g} -e {s/--0-\ /q/g} -e {s/000-\ /v/g} -e {s/-00-\ /x/g} -e {s/-0--\ /y/g} -e {s/--00\ /z/g} \
	| sed -e {s/0--\ /w/g} -e {s/-00\ /d/g} -e {s/--0\ /g/g} -e {s/-0-\ /k/g} -e {s/---\ /o/g} -e {s/0-0\ /r/g} -e {s/000\ /s/g} -e {s/00-\ /u/g} \
	| sed -e {s/0-\ /a/g} -e {s/00\ /i/g} -e {s/--\ /m/g} -e {s/-0\ /n/g} \
	| sed -e {s/0\ /e/g} -e {s/-\ /t/g}
}


function text2morse()
{
cat > "/tmp/text2morse.py" <<"End-of-message"
#!/usr/bin/python
# short mark, dot or 'dit' (.) = .
# longer mark, dash or 'dah' (-) = -
# intra-character gap (between the dots and dashes within a character) = no space
# short gap (between letters) = single space
# medium gap (between words) = double space
import sys
__author__="Aanand Natarajan"
# morse code dictionary
codes = {'1':".----",'2':"..---",'3':"...--",'4':"....-",'5':".....",'6':"-....",'7':"--...",'8':"---..",
'9':"----.",'0':"-----",'A':".-",'B':"-...",'C':"-.-.",'D':"-..",'E':".",'F':"..-.",'G':"--.",
'H':"....",'I':"..",'J':".---",'K':"-.-",'L':".-..",'M':"--",'N':"-.",'O':"---",'P':".--.",
'Q':"--.-",'R':".-.",'S':"...",'T':"-",'U':"..-",'V':"...-",'W':".--",'X':"-..-",'Y':"-.--",
'Z':"--..",
# punctuations
',':"--..--",'.':".-.-.-",'?':"..--..",';':"-.-.-",':':"---...",'/':"-..-.",
'-':"-....-","'":".----.",'(':"-.--.",')':"-.--.-",'!':"-.-.--",'&':".-...",
'=':"-...-",'+':".-.-.",'_':"..--.-",'"':".-..-.",'$':"...-..-",'@':".--.-.",
# space
' ':"|"}
binary = {'.':'.','-':'-',',':' ','|':'  '}
def encode(value):
    """ encodes the value into morse code """
    morse_value=""
    value.replace('*', 'X')
    value.replace('^', 'XX')
    for c in value:
       try :
               morse_value += codes[c.upper()]+','
       except :
         print "Unintended character " + c + " omitted"
    return _get_binary(morse_value)
def decode(morse_code_value):
    """ decodes the morse bytes """
    decoded_value = _decode_binary(morse_code_value)
    ascii_value=""
    for v in decoded_value.split(","):
        ascii_value += _get_key(v)
    return ascii_value
def _get_binary(value):
     binary_value = ""
     for c in value:
         binary_value += binary[c]
     return binary_value
def _get_key(value):
     """ returns the key for the given value """
     for k,v in codes.items():
         if v == value:
            return k
     return ''
def _decode_binary(binary):
    dah_replaced = binary.replace('-', '-')
    dit_replaced = dah_replaced.replace('.', '.')
    comma_replaced = dit_replaced.replace(' ', ',')
    zero_replaced = comma_replaced.replace('', '|,')
    return zero_replaced
def _do_decode(value):
    print "Decoded : "+decode(value)
def _do_encode(value):
    print "Encoded : "+encode(value)
if __name__ == "__main__":
   if len(sys.argv) > 2:
      if sys.argv[1] == 'd' :
         print "decoding"
         _do_decode(sys.argv[2])
      else:
         print "encoding"
         _do_encode(sys.argv[2])
   elif len(sys.argv) > 1:
        print "encoding"
        _do_encode(sys.argv[1])
   else:
        print "Usage : "+sys.argv[0]+" [d (decode) |e (encode)] [input string]"
End-of-message
chmod +x "/tmp/text2morse.py"
"/tmp/text2morse.py" "$1"
rm "/tmp/text2morse.py"
}

options_found=0
while getopts "m:t:" o; do
   options_found=1
   case "${o}" in
      m)    morse2text "${OPTARG}" ;;
      t)    text2morse "${OPTARG}" ;;
      \?)   echo "Unbekannte Option \"-$OPTARG\"." >&2; usage; exit 1;;
      :)    echo "Option \"-$OPTARG\" benötigt ein Argument." >&2; exit 1;;
   esac
done
shift $((OPTIND-1))
if ((!options_found)); then
  usage
  exit 1
fi