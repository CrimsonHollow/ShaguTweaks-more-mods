local module = ShaguTweaks:register({
    title = "Dragonflight Castbar",
    description = "Its the improved castbar module with Dragonflight Textures",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
	category = "Dragonflight",
    enabled = nil,
})

module.enable = function(self)
   local _G = ShaguTweaks.GetGlobalEnv()
	local addonpath = "Interface\\AddOns\\ShaguTweaks-more-mods"
	local customfont = addonpath .. "\\fonts\\PROTOTYPE.TTF"
    local UnitCastingInfo = ShaguTweaks.UnitCastingInfo
    local UnitChannelInfo = ShaguTweaks.UnitChannelInfo
	local hooksecurefunc = ShaguTweaks.hooksecurefunc

    local castbar = CreateFrame("Frame", nil, CastingBarFrame)
	
	-- CastingBarFrame:SetHeight(30)
	
 CastingBarFrame:SetStatusBarTexture("Interface\\Addons\\ShaguTweaks-more-mods\\img\\Castbar\\CastingBarStandard2")
 CastingBarBorder:ClearAllPoints()
 CastingBarBorder:SetPoint("TOPLEFT", CastingBarFrame, "TOPLEFT", -2 , 2)
 CastingBarBorder:SetPoint("BOTTOMRIGHT", CastingBarFrame, "BOTTOMRIGHT", 2, -2) 

 
 CastingBarBorder:SetTexture("Interface\\Addons\\ShaguTweaks-more-mods\\img\\Castbar\\CastingBarFrame2")
 CastingBarSpark:SetTexture("Interface\\Addons\\ShaguTweaks-more-mods\\img\\Castbar\\CastingBarSpark")


	
castbar:Hide()
	function CastingBarFrame_OnUpdate()
    if ( this.casting ) then
        local status = GetTime();
        if ( status > this.maxValue ) then
            status = this.maxValue
        end
        CastingBarFrameStatusBar:SetValue(status);
        CastingBarFlash:Hide();
        local sparkPosition = ((status - this.startTime) / (this.maxValue - this.startTime)) * 250;
        if ( sparkPosition < 0 ) then
            sparkPosition = 0;
        end
        CastingBarSpark:SetPoint("CENTER", CastingBarFrame, "LEFT", sparkPosition, 2);
    elseif ( this.channeling ) then
        local time = GetTime();
        if ( time > this.endTime ) then
            time = this.endTime
        end
        if ( time == this.endTime ) then
            this.channeling = nil;
            this.fadeOut = 1;
            return;
        end
        local barValue = this.startTime + (this.endTime - time);
        CastingBarFrameStatusBar:SetValue( barValue );
        CastingBarFlash:Hide();
        local sparkPosition = ((barValue - this.startTime) / (this.endTime - this.startTime)) * 250;
        CastingBarSpark:SetPoint("CENTER", CastingBarFrame, "LEFT", sparkPosition, 2);
    elseif ( GetTime() < this.holdTime ) then
        return;
    elseif ( this.flash ) then
        local alpha = CastingBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP;
        if ( alpha < 1 ) then
            CastingBarFlash:SetAlpha(alpha);
        else
            CastingBarFlash:SetAlpha(1.0);
            this.flash = nil;
        end
    elseif ( this.fadeOut ) then
        local alpha = this:GetAlpha() - CASTING_BAR_ALPHA_STEP;
        if ( alpha > 0 ) then
            this:SetAlpha(alpha);
        else
            this.fadeOut = nil;
            this:Hide();
        end
    end
end
	
	hooksecurefunc('CastingBarFrame_OnUpdate', function()
	-- CastingBarFrameStatusBar:SetValue(250)
	
    CastingBarFrame:SetWidth(250)
	CastingBarFrame:SetHeight(18)
end)

    castbar.texture = CreateFrame("Frame", nil, castbar)
    castbar.texture:SetPoint("RIGHT", CastingBarFrame, "LEFT", -10, 2)
    castbar.texture:SetWidth(28)
    castbar.texture:SetHeight(28)
	
	
	
    castbar.texture.icon = castbar.texture:CreateTexture(nil, "BACKGROUND")
    castbar.texture.icon:SetPoint("CENTER", 0, 0)
    castbar.texture.icon:SetWidth(24)
    castbar.texture.icon:SetHeight(24)
     castbar.texture:SetBackdrop({
         -- edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
         edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
         tile = true, tileSize = 8, edgeSize = 12,
         insets = { left = 2, right = 2, top = 2, bottom = 2 }
     })
    
    if ShaguTweaks.DarkMode then
        castbar.texture:SetBackdropBorderColor( .3, .3, .3, .9)
    end   

    castbar.spellText = castbar:CreateFontString(nil, "HIGH", "GameFontWhite")
    castbar.spellText:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 3)
    local font, size, outline = customfont, 12, "OUTLINE" 
    castbar.spellText:SetFont(font, size, "THINOUTLINE")

    castbar.timerText = castbar:CreateFontString(nil, "HIGH", "GameFontWhite")
    castbar.timerText:SetPoint("RIGHT", CastingBarFrame, "RIGHT", -5, 3)
    castbar.timerText:SetFont(font, size, "THINOUTLINE")

    CastingBarText:Hide()

    local name = GetUnitName("player")

    castbar:SetScript("OnUpdate", function()
        local cast, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo("player")
        if not cast then
        -- scan for channel spells if no cast was found
        cast, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo("player")
        end
			
			
			
        local alpha = CastingBarFrame:GetAlpha()
        castbar:SetAlpha(alpha)
		CastingBarFlash:Hide()
		
		
		
        if cast then
            local channel = UnitChannelInfo(name)
            local duration = endTime - startTime
            local max = duration / 1000
            local cur = GetTime() - startTime / 1000

            if channel then
                cur = max + startTime/1000 - GetTime()
            end

            cur = cur > max and max or cur
            cur = cur < 0 and 0 or cur

            local rem = max - cur
            rem = string.format("%.1fs", rem)

            castbar.spellText:SetText(cast)
            castbar.timerText:SetText(rem)

            if texture then
                castbar.texture.icon:SetTexture(texture)
                castbar.texture.icon:Show()
            else
                castbar.texture.icon:Hide()
            end            
        else
            if ( alpha == 0 ) then
                castbar:Hide()
            end
        end
    end)
	
	

    local events = CreateFrame("Frame", nil, UIParent)
    events:RegisterEvent("SPELLCAST_START")
    events:RegisterEvent("SPELLCAST_CHANNEL_START")
    events:SetScript("OnEvent", function()
        castbar:Show()
    end)
end
