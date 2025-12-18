
# Read in data
with open('data.txt') as f:
    data = f.read().strip().split('\n')

print(data)

start_point = 50

# Dial goes 0-99 and starts at 50
# RXX means rotate right XX points
# LXX means rotate left XX points
# After 99, it wraps around to 0
# Data has a set of LXX, RXX instructions
# Find number of times the dial points at 0 (part 1)
# Find number of times dial points to + crosses 0 (part 2)

position = start_point
pointing_at_zero = 0
crossed_zero = 0
for instruction in data:
    direction = instruction[0]
    magnitude = int(instruction[1:])
    print("New pos: ", position,". Executing new instruction: ", direction, magnitude)

    if direction == 'R':
        # Number of wraps (crossings) is how many times we cross 100, 200, ...
        wraps = (position + magnitude) // 100
        crossed_zero += wraps
        if wraps:
            print("crosses detected (R): ", wraps)
        position_new = (position + magnitude) % 100   # Wrap around dial

    elif direction == 'L':
        # Number of wraps (crossings) is how many times we cross 0, -100, -200, ...
        position_new = position - magnitude

        if position_new >= 0:
            wraps = 0 # No wraps
        else:
            wraps = 1 + (-position_new - 1) // 100
            print("crosses detected (L): ", wraps)

        position_new = position_new % 100   # Wrap around dial

    else:
        raise ValueError(f"Invalid direction: {direction}")

    if position_new == 0:
        pointing_at_zero += 1
        print("Points at zero!")

    position = position_new

print(f"Final position on dial: {position}")
print(f"Number of times dial pointed at zero (answer to part 1): {pointing_at_zero}")
print(f"Number of times dial crossed + pointed at zero (answer to part 2): {crossed_zero+pointing_at_zero}")