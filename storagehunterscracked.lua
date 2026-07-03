-- Storage Hunters Key Bypass (PRIOR x NARAKAHUB / PandaAuth)

local genv = getgenv()

-- HOOK
local old_req = genv.request
genv.request = function(options)
    if type(options) == "table" and options.Url and options.Url:find("pandauth") then
        return {
            Success = true,
            StatusCode = 200,
            StatusMessage = "OK",
            Body = '{"success":true,"key":"bypass-key-123","expires":"2027-12-31","data":{"hwid":"test","service":"ruthlesshub","rank":"premium"}}'
        }
    end
    return old_req and old_req(options)
end

local old_http = genv.http_request
genv.http_request = function(options)
    if type(options) == "table" and options.Url and options.Url:find("pandauth") then
        return {
            Success = true,
            StatusCode = 200,
            Body = '{"success":true,"key":"bypass-key-123","expires":"2027-12-31","data":{"hwid":"test","service":"ruthlesshub","rank":"premium"}}'
        }
    end
    return old_http and old_http(options)
end

local old_int = genv.internal_request
genv.internal_request = function(options)
    if type(options) == "table" and options.Url and options.Url:find("pandauth") then
        return {
            Success = true,
            StatusCode = 200,
            Body = '{"success":true,"key":"bypass-key-123","expires":"2027-12-31","data":{"hwid":"test","service":"ruthlesshub","rank":"premium"}}'
        }
    end
    return old_int and old_int(options)
end

--Execute Script
print("Hook installed. Loading StorageHunter...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/NarakaHUB/StorageHunter/refs/heads/main/README.md"))()
