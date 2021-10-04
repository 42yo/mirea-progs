function Mark4CellsNearBorder(r)
    counter = 0
    B = Array{Int, 1}(undef, 1000)
    B, counter = movetothecorner(r, West, B)
    Mark4Cells(r, Ost, B, counter)
    returnfromthecorner(r, Ost, B, counter)
end

function movetothecorner(r, side, B)
    counter = 1
    while ((!isborder(r, side)) || (!isborder(r, HorizonSide((Int(side) + 1) % 4))))
        if !isborder(r, side)
            move!(r, side)
            B[counter] = 1
            counter += 1
        end
        if !isborder(r, HorizonSide((Int(side) + 1) % 4))
            move!(r, HorizonSide((Int(side) + 1) % 4))
            B[counter] = 2
            counter += 1
        end
    end
    return B, counter
end

function Mark4Cells(r, side, B, counter)
    for i in 1:(counter - 1) 
        if B[counter - i] == 1
            move!(r, side)
        end
    end
    putmarker!(r)
    movements(r, side)
    for i in 1:(counter - 1) 
        if B[counter - i] == 2
            move!(r, HorizonSide((Int(side) + 1) % 4))
        end
    end
    putmarker!(r)
    movements(r, HorizonSide((Int(side) - 1) % 4))
    movements(r, inverse(side))
    for i in 1:(counter - 1) 
        if B[counter - i] == 2
            move!(r, HorizonSide((Int(side) + 1) % 4))
        end
    end
    putmarker!(r)
    movements(r, HorizonSide((Int(side) + 1) % 4))
    for i in 1:(counter - 1) 
        if B[counter - i] == 1
            move!(r, side)
        end
    end
    putmarker!(r)
    movements(r, inverse(side))
    movements(r, HorizonSide((Int(side) - 1) % 4))
end

function movements(r, side)
    while !isborder(r, side)
        move!(r, side)
    end
end

function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function returnfromthecorner(r, side, B, counter)
    for i in 1:(counter - 1) 
        if B[counter - i] == 1
            move!(r, side)
        end
        if B[counter - i] == 2
            move!(r, HorizonSide((Int(side) + 1) % 4))
        end
    end
end