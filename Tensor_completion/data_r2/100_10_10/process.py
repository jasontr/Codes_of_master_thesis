import re
with open('100_10_10.txt', 'r') as f:
    text = f.read().strip()

regex = re.compile(r'\[?.*Warning.*\]|\[?.*In.*>\)\]?|\[Warning:.*\nthe.*\n\]|ans\ =\n\n.*')
text = re.subn(regex, '', text)
with open('100_10_10_.txt', 'w') as f1:
    f1.write(text[0])
