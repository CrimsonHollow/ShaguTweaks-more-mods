local module = ShaguTweaks:register({
    title = "Restyle-Delirium",
    description = "Restyles the ui based on my (Delirium/Ark) preferences",
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = nil,
    enabled = nil,
})

module.enable = function(self)
    local _G = ShaguTweaks.GetGlobalEnv()
    local restyle = CreateFrame("Frame", nil, UIParent)
    local addonpath = "Interface\\AddOns\\ShaguTweaks-more-mods"
	local customfont = addonpath .. "\\fonts\\PROTOTYPE.TTF"


	

    function restyle:addons()
        --[[
            Supported Addons:
            SP_SwingTimer (Vanilla/Turtle),
            MinimapButtonBag (Vanilla/Turtle)
        ]]

        local function lock(frame)
            frame.ClearAllPoints = function() end
            frame.SetAllPoints = function() end
            frame.SetPoint = function() end         
        end

	


        -- SP_SwingTimer
        if IsAddOnLoaded("SP_SwingTimer") and (not IsAddOnLoaded("GryllsSwingTimer")) then
            -- local w, h, b = 200, 14, 6
            local h, b = 14, 6
            -- set mainhand
            -- SP_ST_Frame:SetWidth(w)
            SP_ST_Frame:SetHeight(h)
            -- SP_ST_Frame:SetScale(1)
            -- SP_ST_Frame:SetAlpha(1)
            -- -- set oh
            -- SP_ST_FrameOFF:SetWidth(w)
            SP_ST_FrameOFF:SetHeight(h)
            -- SP_ST_FrameOFF:SetScale(1)
            -- SP_ST_FrameOFF:SetAlpha(1)
            -- set position
            SP_ST_Frame:ClearAllPoints()
            SP_ST_FrameOFF:ClearAllPoints()

            SP_ST_Frame:SetPoint("CENTER", 0, -180)
            SP_ST_FrameOFF:SetPoint("TOP", "SP_ST_Frame", "BOTTOM", 0, -4);

            SP_ST_FrameTime:ClearAllPoints()
	        SP_ST_FrameTime2:ClearAllPoints()            
            
            SP_ST_FrameTime:SetPoint("CENTER", "SP_ST_Frame", "CENTER")
		    SP_ST_FrameTime2:SetPoint("CENTER", "SP_ST_FrameOFF", "CENTER")
            -- set time
            -- SP_ST_FrameTime:SetWidth(w)
            SP_ST_FrameTime:SetHeight(h-b)

            -- SP_ST_FrameTime2:SetWidth(w)
            SP_ST_FrameTime2:SetHeight(h-b)
            -- hide icons
            SP_ST_mainhand:SetTexture(nil)
            SP_ST_mainhand:SetWidth(0)

            SP_ST_offhand:SetTexture(nil)
            SP_ST_offhand:SetWidth(0)

            SP_ST_mainhand:Hide()
            SP_ST_offhand:Hide()
            -- hide timers
            SP_ST_maintimer:Hide()
            SP_ST_offtimer:Hide()
            -- hide oh
            SP_ST_FrameOFF:Hide()
            SP_ST_FrameTime2:Hide()

            -- add borders
            local function border(frame)
                local x, y, e, i = 4, 2, h, 4
                f = CreateFrame("Frame", nil, frame)
                f:SetPoint("TOPLEFT", f:GetParent(), "TOPLEFT", -x, y)
                f:SetPoint("BOTTOMRIGHT", f:GetParent(), "BOTTOMRIGHT", x, -y)
                
                f:SetBackdrop({
                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                    -- edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                    edgeSize = e,
                    insets = { left = i, right = i, top = i, bottom = i },
                })

                local r, g, b, a = .7, .7, .7, .9
                f:SetBackdropBorderColor(r, g, b, a)
            end           
            
            border(SP_ST_Frame)
            border(SP_ST_FrameOFF)            
        end

        -- MinimapButtonFrame    
        if MBB_MinimapButtonFrame then
            -- reposition MBB to the bottom of the styleFrame (under the minimap)
            -- show the button OnEnter and hide when OnLeave
            
            if IsAddOnLoaded("MinimapButtonBag-TurtleWoW") then
                MBB_MinimapButtonFrame_Texture:SetTexture("Interface\\Icons\\Inv_misc_bag_10_green")
            else
                MBB_MinimapButtonFrame_Texture:SetTexture("Interface\\Icons\\Inv_misc_bag_10")
            end            

            MBB_MinimapButtonFrame:ClearAllPoints()
            MBB_MinimapButtonFrame:SetPoint("CENTER", Minimap, "TOPRIGHT", 30, 30)
            lock(MBB_MinimapButtonFrame)           
            
            local function showButton(button)
                button:SetAlpha(1)
            end

            local function hideButton(button)
                button:SetAlpha(0)  
            end            

            hideButton(MBB_MinimapButtonFrame)
            local hide = CreateFrame("BUTTON", nil, MBB_MinimapButtonFrame)
            hide:SetAllPoints(hide:GetParent())

            hide:SetScript("OnEnter", function()
                showButton(MBB_MinimapButtonFrame)
            end)

            hide:SetScript("OnLeave", function()
                hide.timer = GetTime() + 6
                hide:SetScript("OnUpdate", function()            
                    if (GetTime() > hide.timer) then
                        MBB_HideButtons() -- MBB function to hide buttons
                        hideButton(MBB_MinimapButtonFrame)
                        hide:SetScript("OnUpdate", nil)
                    end
                end)
            end)
            
            hide:RegisterForClicks("LeftButtonDown","RightButtonDown")
            hide:SetScript("OnClick", function()
                MBB_OnClick(arg1)
            end)
        end
    end

    function restyle:buffs()
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

    function restyle:buttons()
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

    function restyle:minimap()
        -- Change Texture
        if MinimapBorder:GetTexture() then
            -- not minimap-square
            MinimapBorder:SetTexture(addonpath .. "\\img\\UI-MINIMAP-BORDER")
        end

        -- Move minimap elements
        local styleFrame = CreateFrame("Frame", nil, MinimapCluster)        
        styleFrame:SetFrameStrata("HIGH")    
        styleFrame:SetPoint("CENTER", Minimap, "BOTTOM")
        styleFrame:SetHeight(16)
        styleFrame:SetWidth(Minimap:GetWidth())

        -- Zone Text
        MinimapZoneTextButton:ClearAllPoints()
        MinimapZoneTextButton:SetPoint("TOP", Minimap, 0, 13)
        MinimapZoneText:SetFont(customfont, 14, "OUTLINE")
        MinimapZoneText:SetDrawLayer("OVERLAY", 7)   
        MinimapZoneText:SetParent(styleFrame)
        -- MinimapZoneText:Hide()

        -- Minimap:SetScript("OnEnter", function()
        --     MinimapZoneText:Show()
        -- end)

        -- Minimap:SetScript("OnLeave", function()
        --     MinimapZoneText:Hide()
        -- end)

        -- ShaguTweaks clock
        if MinimapClock then
            MinimapClock:ClearAllPoints()
            MinimapClock:SetPoint("CENTER", styleFrame, "CENTER", -1, 0)
        end

        -- ShaguTweaks-Mods fps
        if MinimapFPS then
            MinimapFPS:ClearAllPoints()
            MinimapFPS:SetPoint("LEFT", styleFrame, "LEFT")
        end

        -- ShaguTweaks-Mods ms
        if MinimapMS then
            MinimapMS:ClearAllPoints()
            MinimapMS:SetPoint("RIGHT", styleFrame, "RIGHT")
        end

        if Minimap.border then -- if using square minimap
            -- Tracking
            MiniMapTrackingFrame:ClearAllPoints()
            MiniMapTrackingFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -2, 1)
            MiniMapTrackingFrame:SetScale(0.9)
            MiniMapTrackingBorder:SetTexture(nil)
			Minimap:SetMaskTexture[[Interface\Addons\ShaguTweaks-more-mods\img\MinimapMask]]
			Minimap:SetWidth(192.6)
			Minimap:SetHeight(172.6)
			

            -- Mail
            MiniMapMailFrame:ClearAllPoints()
            MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 4, 2)
            MiniMapMailFrame:SetScale(1.2)
            MiniMapMailBorder:SetTexture(nil)

            -- PVP
            MiniMapBattlefieldFrame:ClearAllPoints()
            MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 2, 8)
        end        
    end

    function restyle:unitnames()
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

    function restyle:chatframes()
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

    function restyle:nameplates()
        if ShaguPlates then return end

        local font, size, outline = customfont, 16, "OUTLINE"
        table.insert(ShaguTweaks.libnameplate.OnUpdate, function()            
            this.name:SetFont(font, size, outline)
            this.level:SetFont(font, size, outline)
        end)
    end
	
	
    
    restyle:RegisterEvent("PLAYER_ENTERING_WORLD")
    restyle:SetScript("OnEvent", function()
        if not this.loaded then
            this.loaded = true
            restyle:addons()           
            restyle:buffs()
            restyle:buttons()
            restyle:minimap()
            restyle:unitnames()
            restyle:chatframes()
            restyle:nameplates()
        end           
    end)
end
