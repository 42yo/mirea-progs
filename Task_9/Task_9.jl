function FindMarker(r)
    counter = 1
    while !ismarker(r)
        movementsbyfixmovesandcheckmarker(r, Sud, counter)
        if ismarker(r)
            break
        end
        movementsbyfixmovesandcheckmarker(r, Ost, counter)
        if ismarker(r)
            break
        end
        counter += 1
        movementsbyfixmovesandcheckmarker(r, Nord, counter)
        if ismarker(r)
            break
        end
        movementsbyfixmovesandcheckmarker(r, West, counter)
        if ismarker(r)
            break
        end
        counter += 1
    end
end

function movementsbyfixmovesandcheckmarker(r, side, moves)
    while moves != 0 
        move!(r, side)
        if ismarker(r)
            break
        end
        moves -= 1
    end
end