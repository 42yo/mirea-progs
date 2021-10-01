function FindEntry(r)
    counter = 0
    while isborder(r, Nord)
        movementsbyfixmoves(r, West, counter)
        counter += 1
        if !isborder(r, Nord)
            break
        end
        movementsbyfixmoves(r, Ost, counter)
        counter += 1
    end
end

function movementsbyfixmoves(r, side, moves)
    while moves != 0 
        move!(r, side)
        moves -= 1
    end
end