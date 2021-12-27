function NewMarkCellsBySteps(r)
    side = Ost
    counter_start = 0
    B = Array{Int, 1}(undef, 1000)
    B, counter_start = movetothecorner(r, West, B)

    counter = movementsandcountmoves(r, Ost)
    movements(r, West)

    markrowbyfixmoves(r, side, counter)
    putmarker!(r)
    movements(r, inverse(side))
    counter -= 1
    while isborder(r, Nord) == false
        move!(r, Nord)
        t_counter = markrowbyfixmoves(r, side, counter)
        if t_counter >= 0
            putmarker!(r)
        end
        movementsbyfixmoves(r, inverse(side), counter - t_counter)
        counter -= 1
    end

    movements(r, Sud)
    movements(r, West)
    returnfromthecorner(r, inverse(West), B, counter_start)
end

function markrowbyfixmoves(r, side, counter)
    while counter > 0
        putmarker!(r)
        counter = trymove!(r, side, counter)
    end
    return counter 
end

function movementsbyfixmoves(r, side, counter)
    while counter > 0
        counter = trymove!(r, side, counter)
    end
end

function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function movements(r, side)
    while isborder(r, side) == false
        move!(r, side)
    end
end

function movementsandcountmoves(r, side)
    moves = 0
    while isborder(r, side) == false
        move!(r, side)
        moves += 1
    end
    return moves
end

function trymove!(r::Robot, side::HorizonSide, counter::Int)
    x = 0
    if isborder(r,side)
        while isborder(r, side)
            move!(r,HorizonSide((Int(side) + 1) % 4))
            x = x + 1
        end
        move!(r,side)
        counter -= 1
        while isborder(r,HorizonSide((Int(side) + 3) % 4))
            move!(r,side)
            counter -= 1
        end
        while x != 0
            move!(r,HorizonSide((Int(side) + 3) % 4))
            x = x - 1
        end
        return counter
    else 
        move!(r,side)
        return counter - 1
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