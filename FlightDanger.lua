-- TABLE -- 
-----------
danger = {}

-- LOCALS --
------------
local fd = CreateFrame("Frame")

-- REGISTER EVENTS --
---------------------
fd:RegisterEvent("CHAT_MSG_CHANNEL")
fd:RegisterEvent("TAXIMAP_OPENED")

-- EVENT HANDLER --
-------------------
fd:SetScript("OnEvent",
             function(self, event, msg, _, _, _, _, _, _, channel, channelname)

    if (event == "CHAT_MSG_CHANNEL") and (channelname == "WorldDefense") then

        -- Left pad the minutes if it's 0-9. We always want 14:09, for example.
        local hour, minute = GetGameTime()
        if (string.len(minute) == 1) then minute = "0" .. minute end
        local time = hour .. ":" .. minute

        -- Remove UI Escape codes and extract the location of the attack
        local rawMsg = unescape(msg)
        local location = string.gsub(rawMsg, " is under attack!", "")

        -- Add the entry and time to the table
        danger[location] = time
    end

    -- Hook the TaxiMap flight buttons to display the custom tooltips
    if (event == "TAXIMAP_OPENED") then
        for i = 1, NumTaxiNodes(), 1 do
            local taxiButton = _G["TaxiButton" .. i]
            if taxiButton and not taxiButton.entered then
                taxiButton:HookScript("OnEnter", taxiNodeOnButtonEnter)
                taxiButton.entered = true
            end
        end
    end
end)

-- HELPER FUNCTIONS --
----------------------
function taxiNodeOnButtonEnter(button)
    local id = button:GetID()
    if TaxiNodeGetType(id) ~= "REACHABLE" then return end
    GameTooltip:AddLine(isDanger(TaxiNodeName(id)), 1, 0, 0)
    GameTooltip:Show()
end

-- Remooves UI Escape Codes which grant text color to strings
function unescape(str)
    local escapes = {
        ["|c%x%x%x%x%x%x%x%x"] = "", -- color start
        ["|r"] = "" -- color end
    }
    for k, v in pairs(escapes) do str = gsub(str, k, v) end
    return str
end

-- Check if the extracted location is present in the danger table.
function isDanger(location)
    city, _ = location:match("([^,]+),([^,]+)")
    local timeago = danger[city]
    if timeago ~= nil then
        local hour, minute = timeago:match("([^,]+):([^,]+)")
        local currentHour, currentMinute = GetGameTime()
        if (tonumber(hour) == currentHour) then
            -- Only mark as dangerous of the world defense message is less than 5 minutes ago
            if ((currentMinute - tonumber(minute)) < 5) then
                return "Camped"
            end
        end
    end
end

-- SLASH COMMANDS --
--------------------
function MyAddonCommands(msg, editbox)
    -- Print the danger table
    if msg == 'print' then for k, v in pairs(danger) do print(k, v) end end
end
SLASH_FLIGHTDANGER1 = '/fd'
SlashCmdList["FLIGHTDANGER"] = MyAddonCommands
