local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
    title = "Dragonflight-gryphons-dark",
    description = "Change the action bar gryphons dragonflight ones(Dark mode).",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = "Action Bar",
    enabled = nil,
})

module.enable = function(self)
    for _, g in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
    g:SetTexture[[Interface\Addons\ShaguTweaks-more-mods\img\GryphonHD8LeftDark]]  
    end
end