local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
    title = "Hide PetBar",
    description = "Hide the Pet Bar.",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = "Action Bar",
    enabled = nil,
})

module.enable = function(self)
local hookUIParent_ManageFramePositions = UIParent_ManageFramePositions
  UIParent_ManageFramePositions = function(a1, a2, a3)
    -- run original function
    hookUIParent_ManageFramePositions(a1, a2, a3)
    PetActionBarFrame:Hide()
	end
end