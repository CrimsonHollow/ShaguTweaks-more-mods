local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
    title = "Hide Actionbar Textures",
    description = "Hides Actionbar Textures.",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = "Action Bar",
    enabled = nil,
})

module.enable = function(self)
    MainMenuBarTexture0:Hide()
	MainMenuBarTexture1:Hide()
	BonusActionBarTexture0:Hide()
end