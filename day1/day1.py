
import os


# Get current directory of script
current_dir = os.path.dirname(os.path.abspath(__file__))

# Read in data
with open(os.path.join(current_dir, 'data.txt')) as f:
    data = f.read().strip().split('\n')

print(data)

start_point = 50

# Dial goes 0-99 and starts at 50
# RXX means rotate right XX points
# LXX means rotate left XX points
# After 99, it wraps around to 0
# Data has a set of LXX, RXX instructions
# Find number of times the dial crosses 0

position = start_point
pointing_at_zero = 0
for instruction in data:
    direction = instruction[0]
    magnitude = int(instruction[1:])

    if direction == 'R':
        position = (position + magnitude) % 100
    elif direction == 'L':
        position = (position - magnitude) % 100
    else:
        raise ValueError(f"Invalid direction: {direction}")
    
    if position == 0:
        pointing_at_zero += 1

print(f"Final position on dial: {position}")
print(f"Number of times dial pointed at zero: {pointing_at_zero}")