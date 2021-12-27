function CountHorizontalBorders(r::Robot)
    counter = 0
    B = Array{Int, 1}(undef, 1000)
    B, counter = movetothecorner(r, West, B)
    
    num_horizontal_borders = snake(r)

    movements(r, Sud)
    movements(r, West)
    returnfromthecorner(r, inverse(West), B, counter)
    
    return num_horizontal_borders - 1
end

function snake(r::Robot)
    side = Ost
    num_horizontal_borders = movementsandcountborder(r, side)
    while isborder(r, Nord) == false
        move!(r, Nord)
        side = inverse(side)
        num_horizontal_borders += movementsandcountborder(r, side)
    end
    return num_horizontal_borders
end

function movementsandcountborder(r,side)
    num_borders = 0
    while !isborder(r,side)
        move!(r,side)
        if isborder(r,Nord)
            num_borders += 1
        end
        while isborder(r,Nord)
            if isborder(r,side)
                break
            end
            move!(r,side)
        end
    end
    return num_borders
end

function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function movements(r, side)
    while isborder(r, side) == false
        move!(r, side)
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