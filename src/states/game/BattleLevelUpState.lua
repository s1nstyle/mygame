BattleLevelUpState = Class{__includes = BaseState}

function BattleLevelUpState:init(def)
	self.levelUpMenu = Menu {
		x = 40,
		y = 20,
		width = 200,
		height = 120,
		items = def.statItems,
		cursorEnabled = false
	}
	self.onClose = def.onClose
end

function BattleLevelUpState:update(dt)
	self.levelUpMenu:update(dt)

	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateStack:pop()
		self:onClose()
	end
end

function BattleLevelUpState:render()
	self.levelUpMenu:render()
end