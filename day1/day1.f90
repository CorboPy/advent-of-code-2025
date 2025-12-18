program day1
    implicit none

    ! Declare
    integer :: dial = 50
    character(len=3) :: instruction
    character(len=1) :: direction
    integer :: magnitude, zeros, clicks, rotation
    character(len=3) :: line
    character(len=3), allocatable :: data_(:)
    integer :: n, unit


    ! Read in data
    unit = 10
    open(unit, file='data.txt', status='old')
    ! count lines
    n = 0
    do 
        read(unit, *, end=10) line
        n = n + 1
    end do
10  continue

    rewind(unit) ! go back to start of file

    ! Allocate data
    allocate(character(len=3) :: data_(n))   ! Set size of data array
    ! Read data into array
    do n = 1, n 
        read(unit, "(A3)") data_(n) ! Read in first 3 characters per line 
    end do

    close(unit) ! Close file

    ! Print data to check
    ! to print an array in fortran, you have to loop through it otherwise it prints the full array as a string block
    print *, "Data read in: ", data_

    ! Dial goes 0-99 and starts at 50
    ! RXX means rotate right XX points
    ! LXX means rotate left XX points
    ! After 99, it wraps around to 0
    ! Data has a set of LXX, RXX instructions
    ! Find number of times the dial stops at 0
    
    zeros = 0
    do n = 1, size(data_)
        instruction = data_(n)
        direction = instruction(1:1)

        ! Convert magnitude string to integer
        read(instruction(2:3), *) magnitude

        print *, "Instruction: ", instruction, ", Direction: ", direction, ", Magnitude: ", magnitude

        clicks = magnitude / 100
        rotation = mod(magnitude, 100)

        ! Count full rotations
        zeros = zeros + clicks

        if (direction == 'R') then
            ! Rotate right 
            if (dial + rotation >= 100) then
                zeros = zeros + 1
            end if
            dial = mod(dial+rotation,100)
        else if (direction == 'L') then
            ! Rotate left 
            if (dial /= 0 .and. dial - rotation <= 0) then
                zeros = zeros + 1
            end if
            dial = mod(dial - rotation,100)
            if (dial < 0) dial = dial + 100 ! Fortran mod can return negative
        else
            print *, "Invalid direction: ", direction
            stop 1
        end if
    end do

    ! Results
    print *, "Final Position: ", dial
    print *, "Number of times dial pointed at zero: ", zeros
end program day1