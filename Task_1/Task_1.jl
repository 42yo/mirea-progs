function Krest(r)
    for side in 0:3
        GoToTheWallAndMark(r, HorizonSide(side))
    end
end

function GoToTheWallAndMark(r::Robot, side::HorizonSide)
    x = 0
    while isborder(r, side) != true
        putmarker!(r)
        move!(r, side)
        x = x + 1
    end
    putmarker!(r)
    while x != 0
        move!(r, HorizonSide((Int(side) + 2) % 4))
        x = x - 1
    end
end