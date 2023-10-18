local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
    title = "Buffs to Actionbars",
    description = "Attach playerbuffs to the Actionbars.",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = "Action Bar",
    enabled = nil,
})

module.enable = function(self)
    BuffButton0:ClearAllPoints()
    local offset = 0
    local anchor = ActionButton1
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor
	local pet_offset = PetActionBarFrame:IsVisible() and 40 or 0
    offset = anchor == ActionButton1 and ( MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() ) and 6 or 0
    offset = anchor == ActionButton1 and offset + 6 or offset
    BuffButton0:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 453, 4 + pet_offset)
	
end