function MarkCellsBySteps(r)
    side = Ost
    moves_Sud_from_start = movementsandcountmoves(r, Sud)
    moves_West_from_start = movementsandcountmoves(r, West)
    counter = movementsandcountmoves(r, Ost)
    movements(r, West)

    markrowbyfixmoves(r, side, counter)
    putmarker!(r)
    movements(r, inverse(side))
    counter -= 1
    while isborder(r, Nord) == false
        move!(r, Nord)
        markrowbyfixmoves(r, side, counter)
        if counter >= 0
            putmarker!(r)
        end
        movements(r, inverse(side))
        counter -= 1
    end

    movements(r, Sud)
    movements(r, West)
    movementsbyfixmoves(r, Ost, moves_West_from_start)
    movementsbyfixmoves(r, Nord, moves_Sud_from_start)
end


function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function markrowbyfixmoves(r, side, counter)
    while (isborder(r, side) == false) && (counter > 0)
        putmarker!(r)
        move!(r, side)
        counter -= 1
    end
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

function movementsbyfixmoves(r, side, moves)
    while moves != 0 
        move!(r, side)
        moves -= 1
    end
end