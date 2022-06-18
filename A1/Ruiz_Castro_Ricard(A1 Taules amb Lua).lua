jacobList = {}

lostCharacters = {"John", "Hugo", "Sawyer", "Sayid", "Jack", "Jin"}

lostNumbers = {4,8,15,16,23,42}

-- Exercici1: Omple la taula jacobList amb les parelles index-valor on Jhon es 4
for i=1,#lostNumbers,1 do
  jacobList[lostCharacters[i]] = lostNumbers[i]
end

-- Exercici2: Imprimeix la jacobList per pantalla
print("jacobList ------")
for i,v in pairs(jacobList) do
  print(i .. " -> " .. v)
end
print("----------------")

-- Exercici3: proba la funció "table.sort" amb lostCharacters 
table.sort(lostCharacters)

-- Exercici4: Escriu la funció reverseT que inverteix la taula
function reverseT(table)
  t = {}
  for i = #table, 1, -1 do
    t[#t + 1] = table[i]
  end
  return t
end

-- Exercici5: Inverteix amb reverseT lostCharacters i imprimeix el resultat
lostCharacters = reverseT(lostCharacters)
print("lostCharacters ------")
for i,v in pairs(lostCharacters) do
  print(i .. " -> " .. v)
end
print("---------------------")

-- Exercici6: Aplica reverseT a la funció jacobList
jacobList = reverseT(jacobList)
