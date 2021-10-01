function MarkChess(r)
    flag::Bool = true
    side = Ost
    moves_from_start_west = 0
    moves_from_start_sud = 0
    moves_from_start_west, flag = movementsandcountmovesandswitchflag(r, West, flag)
    moves_from_start_sud, flag = movementsandcountmovesandswitchflag(r, Sud, flag)

    flag = markrowbyflags(r, side, flag)
    while !isborder(r, Nord)
        move!(r, Nord)
        flag = !flag
        side = inverse(side)
        flag = markrowbyflags(r, side, flag)
    end
    
    movements(r, West)
    movements(r, Sud)
    movementsbyfixmoves(r, Ost, moves_from_start_west)
    movementsbyfixmoves(r, Nord, moves_from_start_sud)
end

function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function movements(r, side)
    while !isborder(r, side)
        move!(r, side)
    end
end

function movementsandcountmovesandswitchflag(r, side, flag)
    moves = 0
    while !isborder(r, side)
        move!(r, side)
        moves += 1
        flag = !flag
    end
    return moves, flag
end

function movementsbyfixmoves(r, side, moves)
    while moves != 0 
        move!(r, side)
        moves -= 1
    end
end

function markrowbyflags(r, side, flag)
    while !isborder(r, side)
        if flag
            putmarker!(r)
        end
        move!(r, side)
        flag = !flag
    end
    if flag
        putmarker!(r)
    end
    return flag
end