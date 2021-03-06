--[[
    GD50
    Super Mario Bros. Remake

    -- GameLevel Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameLevel = Class{}

function GameLevel:init(entities, objects, tilemap)
    self.entities = entities
    self.objects = objects
    self.tileMap = tilemap
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end
end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    for k, object in pairs(self.objects) do
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function GameLevel:render()
    self.tileMap:render()

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end
end

function GameLevel:spawnLevelEnd()
    table.insert(self.objects, self:spawnRod(levelWidth -1, -1, 4, self.objects))
    table.insert(self.objects, self:spawnFlag(levelWidth -1, -1, 4, self.objects))
end

function GameLevel:spawnRod(x, y, blockHeight, objects)
    return GameObject {
        texture = 'rods',
        x = (x -1) * TILE_SIZE,
        y = (blockHeight -1) * TILE_SIZE,
        width = 14,
        height = 16 *4,
        -- math.random(#RODS)
        frame = 1,
        collidable = false,
        consumable = true,
        hit = false,
        solid = false,

        onCollide = function(obj)
            gSounds['powerup-reveal']:play()
            return true
        end,

        onConsume = function(obj)
            gStateMachine:change('play', obj)
        end
    }
end

function GameLevel:spawnFlag(x, y, blockHeight, objects)
    return GameObject {
        texture = 'flags',
        -- I Don't know why this is the case
        x = (x -1) * TILE_SIZE + 8,
        y = (blockHeight - 1) * TILE_SIZE,
        width = 16,
        height = 16,
        --math.random(#FLAGS)
        frame = 7,
        collidable = false,
        solid = false,

        onCollide = function()
        end,
        onConsume = function()
        end
    }
end