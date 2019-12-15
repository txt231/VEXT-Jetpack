return
{
    -- player acceleration
    acceleration = Vec3(0.0, 35.0, 0.0),

    -- max y velocity
    maxYVelocity = 10,

    -- velocity dampening factor
    -- if its 0, then player will continue untill infinite unless they touch ground
    velocityDampingFactor = 2,

    -- Max height at this will work at
    -- if its -1 its ignored
    maxHeight = -1,

}