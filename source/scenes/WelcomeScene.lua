WelcomeScene = {}
class("WelcomeScene").extends(NobleScene)
local scene = WelcomeScene

-- scene.backgroundColor = Graphics.kColorWhite

local CENTER_X <const> = 400 // 2

function scene:drawBackground()
	scene.super.drawBackground(self)

	Noble.Text.draw("Workout Playdate", CENTER_X, 96, Noble.Text.ALIGN_CENTER, false, Noble.Text.FONT_LARGE)
	Noble.Text.draw("Press A to start", CENTER_X, 136, Noble.Text.ALIGN_CENTER)
end

scene.inputHandler = {
	AButtonDown = function()
		-- Nothing to start yet.
	end,
}
