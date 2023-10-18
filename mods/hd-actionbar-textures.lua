local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
    title = "HD Actionbar Textures",
    description = "New Actionbar Textures.",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = "Dragonflight",
    enabled = nil,
})

module.enable = function(self)
     for _, g in pairs({MainMenuBarTexture1, MainMenuBarTexture0,BonusActionBarTexture1}) do
    g:SetTexture[[Interface\Addons\ShaguTweaks-more-mods\img\UI-MainMenuBar-Dwarf]]  
    end
end