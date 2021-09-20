function MarkAllCells(r)
    side = Ost
    moves_Sud = movementsandcountmoves(r, Sud)
    moves_West = movementsandcountmoves(r, West)
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
    movementsbyfixmoves(r, Ost, moves_West)
    movementsbyfixmoves(r, Nord, moves_Sud)
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
    while isborder(r, side) == false
        putmarker!(r)
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

function movementsbyfixmoves(r, side, moves)
    while moves != 0 
        move!(r, side)
        moves -= 1
    end
end

