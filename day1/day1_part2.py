
# Read in data
with open('data.txt') as f:
    data = f.read().strip().split('\n')

print(data)

dial = 50

# Dial goes 0-99 and starts at 50
# RXX means rotate right XX points
# LXX means rotate left XX points
# After 99, it wraps around to 0
# Data has a set of LXX, RXX instructions
# Find number of times dial points to + crosses 0 (part 2)

zeros = 0
for instruction in data:
    direction = instruction[0]
    magnitude = int(instruction[1:])
    #print("New pos: ", dial,". Executing new instruction: ", direction, magnitude)

    clicks, rotation = divmod(magnitude, 100)
    zeros += clicks # This captures extra full rotations

    if direction == 'R': # Rotate right
        if dial + rotation >= 100: 
            zeros += 1 # Count crossing
        dial = (dial + rotation) % 100 # Update dial position

    elif direction == 'L': # Rotate left
        if dial and (dial-rotation) <= 0: 
            zeros += 1 # Count crossing
        dial = (dial - rotation) % 100 # Update dial position

    else:
        raise ValueError(f"Invalid direction: {direction}")

print(f"Final position on dial: {dial}")
print(f"Number of times dial crossed + pointed at zero (answer to part 2): {zeros}")