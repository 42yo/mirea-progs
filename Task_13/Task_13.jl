function XTypeKrest(r)
    for i in 0:3
        GoDiagonalAndMark(r, HorizonSide(i))
    end
end

function GoDiagonalAndMark(r, side)
    sides = (side, HorizonSide((Int(side) + 1) % 4))
    counter = 0
    while !isborder(r, sides[1]) && !isborder(r, sides[2])
        putmarker!(r)
        move!(r, sides[1])
        move!(r, sides[2])
        putmarker!(r)
        counter += 1
    end
    while counter != 0
        move!(r, inverse(sides[2]))
        move!(r, inverse(sides[1]))
        counter -= 1
    end
end

function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end