local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
    title = "Dragonflight-gryphons",
    description = "Change the action bar gryphons dragonflight ones.",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = "Action Bar",
    enabled = nil,
})

module.enable = function(self)
    for _, g in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
    g:SetTexture[[Interface\Addons\ShaguTweaks-more-mods\img\GryphonHD8Left]]  
    end
end