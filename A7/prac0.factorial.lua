function factorial(n)
    if (n == 1) then
        return 1
    end 
    return (n * factorial(n - 1))
end

b = tonumber(arg[1])

if (string.find(type(b), "number") ~= nil) then
    print("Factorial de " .. arg[1] .. ": " .. factorial(b))
else
    print("Introduce un número válido.")
end