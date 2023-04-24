local messagetosend = "Player";

local player = game:GetService("Players").LocalPlayer
local feed = player.PlayerGui:WaitForChild("MainGui"):WaitForChild("GameGui"):FindFirstChild("Killfeed")
local chat = nil
local network = nil


for _, x in pairs(getgc()) do
	if type(x) == "function" then
		for _, v in pairs(debug.getupvalues(x)) do
			if type(v) == "table" and rawget(v,"send") then
				network = v
			end
		end
	end
end

if network then
    chat = function(txt)
        network:send("chatted", txt, nil, nil)
    end
    if feed and chat then
        feed.ChildAdded:Connect(function(killfeedaddition)
            wait()
            if killfeedaddition.Name == "Feed" and killfeedaddition.Text == player.Name then
                local num = math.random(1,100);
                local msg = messagetosend .. num;
                chat(msg)
            end
        end)
    end
end