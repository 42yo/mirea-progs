function AverageTemperature(r)
    sum = 0
    counter = 0
    side = Ost
    while !isborder(r, Nord)
        sum, counter = movementsandcheckformarker(r, side, sum, counter)
        sum, counter = checktemperature(r, sum, counter)
        move!(r, Nord)
        side = inverse(side)
    end
    sum, counter = movementsandcheckformarker(r, side, sum, counter)
    sum, counter = checktemperature(r, sum, counter)
    return sum/counter
end

function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function movementsandcheckformarker(r, side, s, c)
    while !isborder(r, side)
        if ismarker(r)
            s += temperature(r)
            c += 1 
        end
        move!(r, side)
    end
    return s, c
end

function checktemperature(r, s, c)
    if ismarker(r)
        s += temperature(r) 
        c += 1
    end
    return s, c
end