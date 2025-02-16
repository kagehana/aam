while not game:IsLoaded() do
    task.wait()
end
 
task.wait(30)
 
------------------------------------------------------
 
print('- queueing code')
queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/kagehana/aam/refs/heads/main/ingame.lua", true))()')
 
print('- matchmaking')
game:GetService('ReplicatedStorage').endpoints.client_to_server.request_matchmaking:InvokeServer('christmas_event')
