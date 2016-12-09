import re
def regprocessor(path):
	with open(path, 'r') as f:
	    text = f.read().strip()

	#regex = re.compile(r'\[?.*Warning.*\]|\[?.*In.*>\)\]?|\[Warning:.*\nthe.*\n\]|ans\ =\n\n.*')
	regex = re.compile(r'\[[^s].*\n|\]..\n|..In.*\n?')
	text = re.subn(regex, '', text)
	with open(path, 'w') as f1:
	    f1.write(text[0])

def regprocessor2(path):
	with open(path, 'r') as f:
	    text = f.read().strip()

	#regex = re.compile(r'\[?.*Warning.*\]|\[?.*In.*>\)\]?|\[Warning:.*\nthe.*\n\]|ans\ =\n\n.*')
	regex = re.compile(r'\=\ i')
	text = re.subn(regex, '=\n i', text)
	with open(path, 'w') as f1:
	    f1.write(text[0])
