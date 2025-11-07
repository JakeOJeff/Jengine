local object = {}
object.__index = object

function object:newRect(world, x, y, width, height, type, angle)
    local self = setmetatable({}, object)
    self.x = x + width / 2
    self.y = y + height / 2
    self.width = width
    self.height = height
    self.angle = angle or 0
    self.type = type

    self.body = love.physics.newBody(world, self.x, self.y, self.type)
    self.shape = love.physics.newRectangleShape(self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    if not gravity then
        self.body:setLinearVelocity(0, 0)
        self.body:setAngularVelocity(0)
    end

    self.body:setAngle(self.angle)

    return self
end

return object