local floor, ceil = math.floor, math.ceil 
local assert, error, setmetatable = _G.assert, _G.error, _G.setmetatable

local Ratio = {}

Ratio.__index = Ratio

local function gcd( a, b )
	if a == b then
		return a
	elseif a > b then
		return gcd( a - b, b )
	else
		return gcd( a, b - a )
	end
end

local function normalize( num, den )
	if den == 0 then
		error( 'Division by zero' )
	elseif num == 0 then
		return 0, 1	
	end
	local num_ = num > 0 and num or -num
	local den_ = den > 0 and den or -den
	local positive = (num > 0 and den > 0) or (num < 0 and den < 0)
	local n = gcd( num_, den_ )
	if positive then
		return num_/n, den_/n
	else
		return -num_/n, den_/n
	end
end


local function make( num, den )
	return setmetatable( {normalize( num, den )}, Ratio )
end

function Ratio.new( num, den )
	num, den = num or 0, den or 1
	
	if num ~= num then
		error( 'Numerator is NaN' )
	elseif den ~= den then
		error( 'Denominator is NaN' )
	elseif floor( num ) ~= num then
		error( 'Numerator is float, only integers are supported' )
	elseif floor( den ) ~= den then
		error( 'Denominator is float, only integers are supported' )
	end

	return make( num, den )
end

function Ratio:__add( o )
	if self[2] ~= o[2] then
		return make( self[1]*o[2] + o[1]*self[2], self[2]*o[2] )
	else
		return make( self[1] + o[1], self[2] )
	end
end

function Ratio:__sub( o )
	if self[2] ~= o[2] then
		return make( self[1]*o[2] - o[1]*self[2], self[2]*o[2] )
	else
		return make( self[1] + o[1], self[2] )
	end
end

function Ratio:__mul( o )
	return make( self[1]*o[1], self[2]*o[2] )
end

function Ratio:__div( o )
	return make( self[1]*o[2], self[2]*o[1] )
end

function Ratio:__unm()
	return make( -self[1], self[2] )
end

function Ratio:__tostring()
	if self[1] == 0 then
		return '0'
	elseif self[2] == 1 then
		return tostring( self[1] )
	else
		return tostring( self[1] ) .. '/' .. tostring( self[2] )
	end
end

function Ratio:num()
	return self[1]
end

function Ratio:den()
	return self[2]
end

function Ratio:tonumber()
	return self[1] / self[2]
end

function Ratio:int()
	if self[1] < 0 then
		return ceil(self:tonumber())
	else
		return floor(self:tonumber())
	end
end

function Ratio:frac()
	return self - make( self:int(), 1 )
end

function Ratio.parse( s )
	local n = assert( tonumber( s ), 'Cannot parse as number' )
	if floor( n ) == n then
		return make( n, 1 )
	elseif n ~= n then
		error( 'Parsing number is NaN' )
	else
		local n_ = n > 0 and n or -n
		local num1, den2, den1 = n_, 1/n_, 1
		while floor(num1) ~= num1 and floor(den2) ~= den2 do
			num1, den2, den1 = num1 * 10, den2 * 10, den1 * 10
		end
		if floor(num1) == num1 then
			return make( num1, den1 )
		else
			return make( den1, den2 )
		end
	end
end

return setmetatable( Ratio, { __call = function( _, num, den )
	return Ratio.new( num, den )
end })
