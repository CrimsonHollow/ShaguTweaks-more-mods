-- This module can be used to add your own custom code.
-- Make sure to read the comments carefully.

-- Remove the following line to activate the module:
--if true then return end

-- This table holds the meta-data of the module:
local module = ShaguTweaks:register({
  title = "Restyle Override",
  description = "Overrides My Changes to BIG HEALTH",
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
 
