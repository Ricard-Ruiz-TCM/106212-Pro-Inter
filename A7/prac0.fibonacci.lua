function reFibonacci(pos, table, exit)
    pos = pos + 1
    if (pos < 3) then
        table[pos] = 1
        table = reFibonacci(pos, table, exit)
    elseif (pos ~= exit) then
        table[pos] = table[pos-1] + table[pos-2]
        table = reFibonacci(pos, table, exit)
    end
    return table
end

function fibonacci(b)
    return reFibonacci(0, {}, b)
end

b = tonumber(arg[1])

if ((string.find(type(b), "number") ~= nil)) then
    str = "Fibonacci de " .. arg[1] .. ": "
    for i,v in ipairs(fibonacci(b)) do
        str = str .. tostring(v) .. ", "
    end
    str = string.sub(str, 1, #str - 2)
    print(str)
else
    print("Introduce un número válido.")
end

