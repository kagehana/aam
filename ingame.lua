-- services
local repstore  = game:GetService('ReplicatedStorage')
local players   = game:GetService('Players')
local http      = game:GetService('HttpService')
local workspace = game:GetService('Workspace')

while not game:IsLoaded() do
    task.wait()
end

task.wait(27)

-- containers
local client = players.LocalPlayer
local endp   = repstore.endpoints.client_to_server
local wave   = workspace:WaitForChild('_wave_num')
local pgui   = client.PlayerGui
local money  = pgui:WaitForChild('spawn_units').Lives.Frame.Resource.Money.text

print('- voting to start')
endp.vote_start:InvokeServer()

while tonumber(money.Text) < 1000 do
    task.wait()
end

local map = workspace._map:GetChildren()

for k, v in pairs(map) do
    if v.Name == 'hill' then
        local part = v.Model['Bridge.004']

        game:GetService('ReplicatedStorage').endpoints.client_to_server.spawn_unit:InvokeServer(
            '{c50679af-51b6-415a-bc20-24ccbea14423}',
            (part.CFrame * (CFrame.new(0, part.Size.Y / 2, 0) * CFrame.Angles(math.pi / 2, 0, 0)))
        )

        break
    end
end

local function leave()
    print('- queueing more code')
    queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/kagehana/aam/refs/heads/main/main.lua", true))()')

    print('- back to the lobby we go...')
    endp.teleport_back_to_lobby:InvokeServer()
end

pgui.ResultsUI.Holder.Title:GetPropertyChangedSignal('Text'):Connect(function()
    print('- your teammates sucked')
    leave()
end)

wave:GetPropertyChangedSignal('Value'):Connect(function()
    print('- on wave #' .. wave.Value)

    if wave.Value == 50 then
        print('- reporting to the server')
        leave()
    end
end)

while task.wait(60) do
    mouse1click()
end
