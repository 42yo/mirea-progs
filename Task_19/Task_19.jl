function NewFindMarker(r)
    counter = 1
    while !ismarker(r)
        for side in 2:5
            movementsbyfixmovesandcheckmarker(r, HorizonSide(side % 4), counter)
            if ismarker(r)
                break
            end
            if side == 3 || side == 5
                counter += 1
            end
        end
    end
end

function movementsbyfixmovesandcheckmarker(r, side, moves)
    while moves != 0 
        trymove!(r, side)
        if ismarker(r)
            break
        end
        moves -= 1
    end
end

function trymove!(r::Robot, side::HorizonSide)
    if isborder(r,side)
        moves = 1
        end_side = HorizonSide((Int(side) + 1) % 4)
        while isborder(r, side)
            movementsbyfixmoves(r,HorizonSide((Int(side) + 1) % 4), moves)
            if !isborder(r, side)
                end_side = HorizonSide((Int(side) + 3) % 4)
                break
            end
            moves += 1
            movementsbyfixmoves(r,HorizonSide((Int(side) + 3) % 4), moves)
            moves += 1
        end
        move!(r,side)
        movementsbyfixmoves(r, end_side, Int(floor((moves+1)/2)))
    else 
        move!(r,side)
    end
end

function movementsbyfixmoves(r, side, moves)
    while moves != 0 
        move!(r, side)
        moves -= 1
    end
end