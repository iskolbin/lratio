local R = require('Ratio')
assert( getmetatable( R()) == R )
assert( getmetatable( R.new()) == R )
assert( R():num() == 0 )
assert( R():den() == 1 )
assert( R(2):num() == 2 )
assert( R(2):den() == 1 )
assert( R(1,2):num() == 1 )
assert( R(1,2):den() == 2 )
assert( R(1,2) + R(1,2) == R(1))
assert( (R(1,3) + R(1,3) + R(1,3)):tonumber() == 1 )
assert( R(2,3) < R(3,5))
assert( R(1,2) > -R(2))
assert( R(10,8) == R(5,4))
assert( R(1,7) <= R(2,7))
assert( R(1,8) <= R(1,8))
assert( R(1,8) ~= R(1,9))
assert( R(2) ~= 2 )
assert( R(2):tonumber() == 2 )
assert( R.parse(0.5) == R(1,2))
assert( R.parse(0.125) + R(1,8) == R(2,8))
assert( R(4,3):int() == R(1) )
assert( R(4,3):frac() == R(1,3))
assert( R(2,3) >= R(1,3))
assert( R(4,3) >= R(4,3))
assert( R(2,6):tointeger() == 0 )
assert( R(-2,6):tointeger() == 0 )
assert( R(7,4):tointeger() == 1 )
assert( R.parse'22.12' == R(2212,100))
