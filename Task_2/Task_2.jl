function MarkPerimetr(r)
    x = 0
    while isborder(r, Nord) != true
        move!(r, Nord)
        x = x + 1 
    end

    for side in 1:5
        GoToTheWallAndMark2(r, HorizonSide(side % 4))
    end

    while x != 0
        move!(r, Sud)
        x = x - 1
    end
end

function GoToTheWallAndMark2(r, side)
    while isborder(r, side) != true
        if ismarker(r) == true
            break
        end
        putmarker!(r)
        move!(r, side)
    end
end