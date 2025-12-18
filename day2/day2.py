import numpy as np

# Read in data, delimiter = , 
with open('data.txt') as f:
    data = f.read().strip().split(',')
print(data)

# for testing
#data = ['11-22','99-115','998-1012']

invalid_ids = []
for id_range in data:
    print(id_range)
    start, end = map(int, id_range.split('-'))
    for id in range(start, end+1):
        if str(id)[:len(str(id))//2] == str(id)[len(str(id))//2:]:
            invalid_ids.append(id)
            print(f"Invalid ID found: {id}")

print(np.sum(invalid_ids))