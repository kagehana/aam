while not game:IsLoaded() do
    task.wait()
end
 
task.wait(15)
 
------------------------------------------------------
 
print('- queueing code')
queue_on_teleport('loadstring(game:HttpGet("https://pastebin.com/raw/vRESX1Zq", true))()')
 
print('- matchmaking')
game:GetService('ReplicatedStorage').endpoints.client_to_server.request_matchmaking:InvokeServer('christmas_event')
