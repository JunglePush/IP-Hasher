local function Map(n, start1, stop1, start2, stop2)
return ((n-start1)/(stop1-start1))*(stop2-start2)+start2
end

local function HashIP(IP)
local S = {}
local Ts = {}
local Dots = 0
local function SChar(n)
if n < 0 then n = 0 end
if n > 255 then n = 255 end
local r = "x"
pcall(function()
r = string.char(math.floor(Map(n, 0, 255, 33, 126)))
end)
return r
end
for i = 0, string.len(IP), 1 do
local v = string.sub(IP, i, i)
if v ~= "." and tonumber(v) then
table.insert(Ts, tonumber(v))
elseif v == "." then
Dots = Dots + 1
S[Dots] = Ts
Ts = {}
end
S[Dots+1] = Ts
end
for i, v in pairs(S)do
local n0 = v[1]
local n1 = v[2]
local n2 = v[3]
if n0 == nil or n0 == 0 then S[i][1] = 3+i end
if n1 == nil or n1 == 0 then S[i][2] = 6-i end
if n2 == nil or n2 == 0 then S[i][3] = 7-i end
end
local L = string.len(IP)
local N1 = S[1][1] + S[2][1] - S[3][1] - S[4][1]
local N2 = S[1][3] * (S[2][1]*S[4][2])
local N3 = S[1][3] - S[4][3] / S[3][2] + S[2][3]
local N4 = L - N2 * (L*S[4][2]) * N2
local N5 = L/N4 - S[3][3]
local N6 = (N5 + N4)/(N5 - N4) + L
local N7 = S[4][3] * S[3][2] - L + N6
local N8 = N7*N7 + L
local N9 = N1 * N2 + N3 * (N6 / N6) - (2*L)
local C0 = (N1 + N2 * N3)..(2*N3 - N2)
local C1 = (N3-N4+L+N5-N6)
local C2 = (N9-N8-(L/L) * (N3/N3)+N2*N1+(L*N2))
local C3 = (N2+N8-N9+(L*L)*N3-N4/(3*N5*N7))
local C4 = (N3+N4)
local C5 = (N6)
N1 = tostring(N1)
N2 = tostring(N2)
N3 = tostring(N3)
N4 = tostring(N4)
N5 = tostring(N5)
N6 = tostring(N6)
N7 = tostring(math.floor(N7))
N8 = tostring(N8)
N9 = tostring(N9)
local HASH = N1..N2..N3..C0..N4..C0..C1..N5..N6..N7..C2..N8..N9..C3..C4..N4..C5..C0
return HASH
end

local function CompLink(Link)
local Body = nil
pcall(function()
Body = HttpGet(Link)
end)
if Body then
return Body
end
pcall(function()
Body = game:HttpGetAsync(Link)
end)
if Body then
return Body
end
pcall(function()
Body = HttpS:GetAsync(Link)
end)
return Body
end

local function GetIP()
return CompLink("https://myexternalip.com/raw")
end

setclipboard(HashIP(GetIP()))
print(HashIP(GetIP()))
