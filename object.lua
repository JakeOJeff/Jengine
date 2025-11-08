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
function object:newCirc(world, x, y, radius, type, angle)
    local self = setmetatable({}, object)
    self.x = x + radius/2
    self.y = y + radius/2
    self.radius = radius/2
    self.angle = angle or 0
    self.type = type

    self.body = love.physics.newBody(world, self.x, self.y, self.type)
    self.shape = love.physics.newCircleShape(self.radius)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    if not gravity then
        self.body:setLinearVelocity(0, 0)
        self.body:setAngularVelocity(0)
    end

    self.body:setAngle(self.angle)

    return self
end


function object:newTri(world, x, y, size, type, angle)
    local self = setmetatable({}, object)
    self.x = x + size/2
    self.y = y + size/2
    self.size = size
    self.angle = angle or 0
    self.type = type or "dynamic"

    self.body = love.physics.newBody(world, self.x, self.y , self.type)

    local half = size/2
    self.shape = love.physics.newPolygonShape(
        0, -half
        -half, half,
        half, half
    )

    self.fixture = love.physics.newFixture(self.body, self.shape)
    
    if not gravity then
        self.body:setLinearVelocity(0, 0)
        self.body:setAngularVelocity(0)
    end

    self.body:setAngle(self.angle)
    return self
end
return object