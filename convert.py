import sys

data = open(sys.argv[1]).read().split('\n')
for i in range(len(data)):
    data[i] = data[i].replace(r'\\', '').replace(r'\"', '')
with open(sys.argv[1], 'w') as f:
    f.write('\n'.join(data))
