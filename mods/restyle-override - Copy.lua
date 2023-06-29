-- This module can be used to add your own custom code.
-- Make sure to read the comments carefully.

-- Remove the following line to activate the module:
--if true then return end

-- This table holds the meta-data of the module:
local module = ShaguTweaks:register({
  title = "Restyle Override",
  description = "Moves the buffs above your actionbars",
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  category = nil,
  enabled = nil,
})

-- Global code:
--   This is where you can put your most basic variable assignments.
--   Code in this scope will *always* run, no matter if the module is enabled or not.
local _G = ShaguTweaks.GetGlobalEnv()

module.enable = function(self)
	local addonpath = "Interface\\AddOns\\ShaguTweaks-more-mods"
	local customfont = addonpath .. "\\fonts\\PROTOTYPE.TTF"
   local function setup()
    if TargetFrameHealthBar._SetStatusBarColor then
        -- unitframes-bighealth is active
        -- move text strings a bit higher
        if PlayerFrameHealthBar.TextString then
            PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrameHealthBar, "BOTTOM", 0, 30)
        end
    
        if TargetFrameHealthBar.TextString then
            TargetFrameHealthBar.TextString:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", -2, 30)
        end
    end
	
	if restyle:nameplates() then
        -- restyle ui is active
        -- move text strings a bit higher
        if restyle:unitnames() then
               local names = {
            PlayerFrame.name,
			PlayerLevelText,
			TargetLevelText,
			PlayerFrameHealthBar.TextString,
			PlayerFrameManaBar.TextString,
			TargetFrameHealthBar.TextString,
			TargetFrameManaBar.TextString,
			PetName,
            TargetFrame.name,
            TargetofTargetName,
            --PartyMemberFrame1.name,
            --PartyMemberFrame2.name,
            --PartyMemberFrame3.name,
            --PartyMemberFrame4.name,
            --PartyMemberFrame1PetFrame.name,
            --PartyMemberFrame2PetFrame.name,
            --PartyMemberFrame3PetFrame.name,
            --PartyMemberFrame4PetFrame.name
        }
		
		PlayerFrame.name:Hide()
		PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrameHealthBar, "BOTTOM", 0, 30)
		TargetFrameHealthBar.TextString:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", -2, 30)
		PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrame, "TOP", 50, -15)
		PlayerFrame.name:SetPoint("TOP", PlayerFrame, "TOP", 50, -15)
		TargetFrame.name:SetPoint("TOP", TargetFrame, "TOP", -50, -15)
        local font, size, outline = customfont, 12, "OUTLINE"
        for _, name in pairs(names) do
            name:SetFont(font, size, outline)
        end
		
		PlayerFrameHealthBar.TextString:SetFont(font, size +2, outline)
		TargetFrameHealthBar.TextString:SetFont(font, size +2, outline)
    end
    
        
    end
	
	if restyle:RegisterEvent("PLAYER_ENTERING_WORLD") then
        -- restyle is active
        -- change minimap
        if restyle:minimap() then
            MinimapZoneText:SetFont(customfont, 14, "OUTLINE")
			Minimap:SetWidth(252)
			Minimap:SetHeight(192.6)
        end
		
		-- restyle chat
        if restyle:chatframes() then
            local frames = {
            ChatFrame1,
            ChatFrame2,
            ChatFrame3
        }

        local font = customfont
        for _, frame in pairs(frames) do            
            local _, size, outline = frame:GetFont()
            frame:SetFont(font, size, outline)
        end
        end
		
		-- restyle buttons
		 if restyle:buttons() then
            local function style(button)
            if not button then return end        

            local hotkey = _G[button:GetName().."HotKey"]
            if hotkey then
                local font, size, outline = customfont, 12, "OUTLINE"
                hotkey:SetFont(font, size, outline)
            end

            local macro = _G[button:GetName().."Name"]  
            if macro then
                local font, size, outline = customfont, 12, "OUTLINE"
                macro:SetFont(font, size, outline)   
            end

            local count = _G[button:GetName()..'Count']
            if count then
                local font, size, outline = customfont, 14, "OUTLINE"
                count:SetFont(font, size, outline)   
            end
        end
        
        for i = 1, 24 do
            local button = _G['BonusActionButton'..i]
            if button then
                style(button)
            end
        end

        for i = 1, 12 do
            for _, button in pairs(
                    {
                    _G['ActionButton'..i],
                    _G['MultiBarRightButton'..i],
                    _G['MultiBarLeftButton'..i],
                    _G['MultiBarBottomLeftButton'..i],
                    _G['MultiBarBottomRightButton'..i],
                }
            ) do
                style(button)
            end        
        end 

        for i = 1, 10 do
            for _, button in pairs(
                {
                    _G['ShapeshiftButton'..i],
                    _G['PetActionButton'..i]
                }
            ) do
                style(button)
            end
        end
        end
    
		 -- restyle addons 
        if restyle:addons() then
            SP_ST_Frame:ClearAllPoints()
            SP_ST_FrameOFF:ClearAllPoints()

            SP_ST_Frame:SetPoint("CENTER", 0, -180)
            SP_ST_FrameOFF:SetPoint("TOP", "SP_ST_Frame", "BOTTOM", 0, -4);
        end
		
		 -- restyle buffs 
        if restyle:buffs() then
            local font, size, outline = customfont, 9, "OUTLINE"
        local yoffset = 7
        local f = CreateFrame("Frame", nil, GryllsMinimap)
        f:SetFrameStrata("HIGH")

        local function buffText(buffButton)
            -- remove spaces from buff durations
            local duration = getglobal(buffButton:GetName().."Duration");
            local durationtext = duration:GetText()
            if durationtext ~= nil then
                local timer = string.gsub(durationtext, "%s+", "")
                duration:SetText(timer)
            end
        end

        for i = 0, 2 do
            for _, v in pairs(
                    {
                    _G['TempEnchant'..i..'Duration'],
                }
            ) do
                local b = _G['TempEnchant'..i]
                v:SetFont(font, size, outline)
                v:ClearAllPoints()
                v:SetPoint("CENTER", b, "BOTTOM", 0, yoffset)
                v:SetParent(f)            

                local f = CreateFrame("Frame", nil, b)
                f:SetScript("OnUpdate", function()
                    buffText(b)
                end)
            end
        end

        for i = 0, 16 do
            for _, v in pairs(
                    {
                    _G['BuffButton'..i..'Duration'],
                }
            ) do
                local b = _G['BuffButton'..i]
                v:SetFont(font, size, outline)
                v:ClearAllPoints()
                v:SetPoint("CENTER", b, "BOTTOM", 0, yoffset)
                v:SetParent(f)            

                local f = CreateFrame("Frame", nil, b)
                f:SetScript("OnUpdate", function()
                    buffText(b)
                end)
            end
        end
		
		for i = 0, 16 do
            for _, v in pairs(
                    {
                    _G['BuffButton'..i],
                    _G['BuffButton'..i..'Border'],
                }
            ) do
                local s = 32
                v:SetWidth(s)
                v:SetHeight(s)
            end
        end
		
		for i = 16, 23 do
            for _, v in pairs(
                    {
                    _G['BuffButton'..i..'Duration'],
                }
            ) do
                local b = _G['BuffButton'..i]
                v:SetFont(font, size, outline)
                v:ClearAllPoints()
                v:SetPoint("CENTER", b, "BOTTOM", 0, yoffset)
                v:SetParent(f)            
	
                local f = CreateFrame("Frame", nil, b)
                f:SetScript("OnUpdate", function()
                    buffText(b)
                end)
            end
        end
		
		    for i = 16, 23 do
            for _, v in pairs(
                    {
                    _G['BuffButton'..i],
                    _G['BuffButton'..i..'Border'],
                }
            ) do
                local s = 40
                v:SetWidth(s)
                v:SetHeight(s)
            end
        end
        end
	end

  end

  -- create a timer
  local timer = CreateFrame("Frame")
  timer:Hide()
  timer:SetScript("OnUpdate", function()
    if GetTime() >= timer.time then
      timer.time = nil
      setup()
      this:Hide()
      this:SetScript("OnUpdate", nil)
    end
  end)

  local events = CreateFrame("Frame", nil, UIParent)
  events:RegisterEvent("PLAYER_ENTERING_WORLD")
  events:SetScript("OnEvent", function()
      -- trigger the timer to go off 1 second after login
      timer.time = GetTime() + 1
      timer:Show()
    end)
	end
 
