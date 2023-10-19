local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
    title = "My UI",
    description = "Moves unit frames, minimap, buffs and chat based on my preferences.",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = nil,
    enabled = nil,
})

module.enable = function(self)
    local resolution = GetCVar("gxResolution")
    local _, _, screenwidth, screenheight = strfind(resolution, "(.+)x(.+)")
    screenwidth = tonumber(screenwidth)
    -- screenheight = tonumber(screenheight)
    -- local res = screenwidth/screenheight
    -- local uw
    -- if res > 1.78 then uw = true end
    
    local function unitframes()    
        -- Player        
        PlayerFrame:SetClampedToScreen(true)
        PlayerFrame:ClearAllPoints()
        PlayerFrame:SetPoint("RIGHT", UIParent, "CENTER", -80, -180)
    
        -- Target        
        TargetFrame:SetClampedToScreen(true)
        TargetFrame:ClearAllPoints()
        TargetFrame:SetPoint("LEFT", UIParent, "CENTER", 80, -180)
    
    
        -- Party
        local scale = 1.25        
        PartyMemberFrame1:SetClampedToScreen(true)
        PartyMemberFrame1:SetScale(scale)
        PartyMemberFrame2:SetScale(scale)
        PartyMemberFrame3:SetScale(scale)
        PartyMemberFrame4:SetScale(scale)

        PartyMemberFrame1:ClearAllPoints()
        PartyMemberFrame1:SetPoint("RIGHT", UIParent, "CENTER", -230, 80)
		-- PartyMemberFrame1:SetPoint("RIGHT", UIParent, "CENTER", -620, 390)
        -- PartyMemberFrame2/3/4 moves with PartyMemberFrame1
    end
    
    local function minimap()
		local x = 30
        local y = 30
        MinimapCluster:SetClampedToScreen(true)
        MinimapCluster:ClearAllPoints()
        MinimapCluster:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x, y)
        MinimapCluster.ClearAllPoints = function() end
        MinimapCluster.SetPoint = function() end
		DurabilityFrame:ClearAllPoints()
		DurabilityFrame:SetPoint("TOPLEFT", Minimap , "TOPRIGHT", 200, -100)
		QuestTimerFrame:ClearAllPoints()
		QuestTimerFrame:SetPoint("TOP", Minimap , "TOP", 200, 100)
    end
    
    local function buffs()
        -- Buffs start with TemporaryEnchantFrame
        -- Debuffs are aligned underneath the TemporaryEnchantFrame    
        TemporaryEnchantFrame:ClearAllPoints()
        TemporaryEnchantFrame:SetPoint("BOTTOMRIGHT", PlayerFrame, -5, -4)
		BuffButton16:ClearAllPoints()
		BuffButton16:SetPoint("TOPRIGHT", UIParent, -40, -40)
        -- prevent TemporaryEnchantFrame from moving
        TemporaryEnchantFrame.ClearAllPoints = function() end
        TemporaryEnchantFrame.SetPoint = function() end
    end

    local function chat()
        local _, fontsize = ChatFrame1:GetFont()
        -- local lines = 9 -- number of desired chat lines
        -- local h = (fontsize * (lines*1.1))
        local h = 120
        local w = 400
        -- local x = 32
        -- if uw then x = screenwidth/9 end
        local x = screenwidth/9
        local y = 115

        ChatFrame1:SetClampedToScreen(true)
        ChatFrame1:SetWidth(w)
        ChatFrame1:SetHeight(h)
        ChatFrame1:ClearAllPoints()
        ChatFrame1:SetPoint("BOTTOMRIGHT", "UIParent", -x/2, y)

        local found
        local frame

       

      
    end
    
    local events = CreateFrame("Frame", nil, UIParent)	
    events:RegisterEvent("PLAYER_ENTERING_WORLD")

    events:SetScript("OnEvent", function()
        if not this.loaded then
            this.loaded = true
            unitframes()
            minimap()
            buffs()
            chat()
        end
    end)
end

