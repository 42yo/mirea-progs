function MarkAllCellsNew(r)
    side = Ost
    counter = 0
    B = Array{Int, 1}(undef, 1000)
    B, counter = movetothecorner(r, West, B)

    markrow(r, side)
    putmarker!(r)
    while isborder(r, Nord) == false
        move!(r, Nord)
        side = inverse(side)
        markrow(r, side)
        putmarker!(r)
    end

    movements(r, Sud)
    movements(r, West)
    returnfromthecorner(r, inverse(West), B, counter)
end


function movements(r, side)
    while isborder(r, side) == false
        move!(r, side)
    end
end

function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function markrow(r, side)
    putmarker!(r)
    while trymove!(r, side) == false
        putmarker!(r)
        trymove!(r, side)
        putmarker!(r)
    end
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

function trymove!(r::Robot, side::HorizonSide)
    x = 0
    z = false
    if isborder(r,side)
        while isborder(r, side)
            if isborder(r,HorizonSide((Int(side) + 1) % 4))
                z = true
                break
            end
            move!(r,HorizonSide((Int(side) + 1) % 4))
            x = x + 1
        end
        if !z
            move!(r,side)
            while isborder(r,HorizonSide((Int(side) + 3) % 4))
                move!(r,side)
            end
        end
    
        while x != 0
            move!(r,HorizonSide((Int(side) + 3) % 4))
            x = x - 1
        end
        return z
    else 
        move!(r,side)
        return false
    end
end