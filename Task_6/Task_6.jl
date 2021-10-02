function MarkPerimetrInsideRectangle(r)
    counter = 0
    B = Array{Int, 1}(undef, 1000)
    B, counter = movetothecorner(r, West, B)
    findrectangle(r, Nord)
    marksideofrectangle(r, Nord)
    marksideofrectangle(r, Ost)
    marksideofrectangle(r, Sud)
    marksideofrectangle(r, West)
    marksideofrectangle(r, Nord)
    movements(r, West)
    movements(r, Sud)
    returnfromthecorner(r, Ost, B, counter)
end

function movements(r, side)
    while !isborder(r, side)
        move!(r, side)
    end
end

function movementsandcheckforborder(r, side)
    while !isborder(r, side)
        move!(r, side)
        if isborder(r, Nord)
            break
        end
    end
end

function marksideofrectangle(r, side)
    while isborder(r, side)
        move!(r, HorizonSide((Int(side) + 1) % 4))
        putmarker!(r)
    end
    move!(r, side)
    putmarker!(r)
end

function findrectangle(r, side)
    while !isborder(r, side)
        movementsandcheckforborder(r, HorizonSide((Int(side) + 3) % 4))
        if isborder(r, side)
            break
        end
        move!(r, side)
        movementsandcheckforborder(r, HorizonSide((Int(side) + 1) % 4))
        if isborder(r, side)
            break
        end
        if !isborder(r, side)
            move!(r, side)
        else
            break
        end
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