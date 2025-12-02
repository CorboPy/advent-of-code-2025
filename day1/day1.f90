program day1
    implicit none

    ! Declare
    integer :: start_point = 50
    integer :: position
    integer :: pointing_at_zero = 0
    character(len=3) :: instruction
    character(len=1) :: direction
    integer :: magnitude
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

    position = start_point
    do n = 1, size(data_)
        instruction = data_(n)
        direction = instruction(1:1)

        ! Convert magnitude string to integer
        read(instruction(2:3), *) magnitude

        print *, "Instruction: ", instruction, ", Direction: ", direction, ", Magnitude: ", magnitude

        ! Update position. position can't be negative or > 99
        if (direction == 'R') then
            position = position + magnitude
            position = mod(position, 100) ! wrap around
            if (position < 0) position = position + 100
        else if (direction == 'L') then
            position = position - magnitude
            ! If go into negative, it will be 99 - something
            position = mod(position, 100) ! wrap around
            if (position < 0) position = position + 100 ! In Fortran, mod(-1,100) is -1 so we need to add 100 so it becomes 99
        else
            print *, "Unknown direction: ", direction
            ! Raise error
            stop 1
        end if

        ! Check if crossed zero
        if (position == 0) then
            pointing_at_zero = pointing_at_zero + 1
        end if
    end do

    print *, "Final Position: ", position
    print *, "Number of times dial pointed at zero: ", pointing_at_zero

end program day1