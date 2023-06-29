local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
    title = "Dragonflight-wyverns-dark",
    description = "Change the action bar gryphons to dragonflight wyverns(Dark).",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = "Action Bar",
    enabled = nil,
})

module.enable = function(self)
    for _, g in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
    g:SetTexture[[Interface\Addons\ShaguTweaks-more-mods\img\WyvernHD8LeftDark]]  
    end
end