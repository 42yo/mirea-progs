function MarkNChess(r, n)
    counter = 0
    Moves = Array{Int,1}(undef, 1000)
    Moves, counter = movetothecorner(r, West, Moves)
    markntypechess(r, n)
    movements!(r, Sud)
    movements!(r, West)
    returnfromthecorner(r, Ost, Moves, counter)
end

function markntypechess(r, n)
    side = Ost
    x_coordinate = 0
    y_coordinate = 0
    while !isborder(r, Nord)
        x_coordinate = movelineandmarkntypechess(r, x_coordinate, y_coordinate, n, side)
        move!(r, Nord)
        y_coordinate += 1
        side = inverse(side)
    end
    x_coordinate = movelineandmarkntypechess(r, x_coordinate, y_coordinate, n, side)
end

function changexcoordinate(x_coordinate, side)
    if side == Ost
        x_coordinate += 1
    end
    if side == West
        x_coordinate -= 1
    end
    return x_coordinate
end

function putrightmarker(r, x_coordinate, y_coordinate, n)
    if (floor(x_coordinate / n) + floor(y_coordinate / n)) % 2 == 0
        putmarker!(r)
    end
end

function movelineandmarkntypechess(r, x_coordinate, y_coordinate, n, side)
    putrightmarker(r, x_coordinate, y_coordinate, n)
    while !isborder(r, side)
        move!(r, side)
        x_coordinate = changexcoordinate(x_coordinate, side)
        putrightmarker(r, x_coordinate, y_coordinate, n)
    end
    return x_coordinate
end