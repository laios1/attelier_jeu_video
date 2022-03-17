--a = {r = 3,44,p = 5}

--b = {{1,2,3},
--     {44324,5,6}}


f = io.open("caca.txt","a")
print(f:write("wiiiiiii"))


f:close(f) 

f = io.open("caca.txt","r")
a = ""
b = {}
while type(a) ~= "nil" do
  b[#b+1]= a
  a = f:read("*l")
end
for k,v in pairs(b) do
  print(v.."\n")
end
f:close(f)

