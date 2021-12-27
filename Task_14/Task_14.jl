function NewKrest(r)
    for side in 0:3
        GoToTheWallAndMark(r, HorizonSide(side))
    end
end

function GoToTheWallAndMark(r::Robot, side::HorizonSide)
    x = 0
    while !mainborder(r,side)
        putmarker!(r)
        trymove!(r, side)
        x = x + 1
    end
    putmarker!(r)
    while x != 0
        trymove!(r, HorizonSide((Int(side) + 2) % 4))
        x = x - 1
    end
end

function trymove!(r::Robot, side::HorizonSide)
    x = 0
    if isborder(r,side)
        while isborder(r, side)
            move!(r,HorizonSide((Int(side) + 1) % 4))
            x = x + 1
        end
        move!(r,side)
        while isborder(r,HorizonSide((Int(side) + 3) % 4))
            move!(r,side)
        end
        while x != 0
            move!(r,HorizonSide((Int(side) + 3) % 4))
            x = x - 1
        end
    else 
        move!(r,side)
    end
end

function mainborder(r,side)
    x = 0
    b = true
    while isborder(r,side) && !isborder(r,HorizonSide((Int(side) + 3) % 4))
        move!(r,HorizonSide((Int(side) + 3) % 4))
        x = x + 1
    end
    if isborder(r,side)
        b = true
    else 
        b = false
    end
    while x != 0
        move!(r,HorizonSide((Int(side) + 1) % 4))
        x = x - 1
    end
    return b
end