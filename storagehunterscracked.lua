  local origInt = getgenv().internal_request
  local origReq = getgenv().request
  local origHttp = getgenv().http_request

  getgenv().internal_request = function(options)
      if type(options) == "table" and options.Url and options.Url:find("pandauth") then
          return {Success=true, StatusCode=200, Body=[[{"success":true,"key":"bypass-prior-key-001","expires":"2027-12-3
  1","data":{"hwid":"test","service":"prior","rank":"premium"}}]]}
      end
      return origInt and origInt(options)
  end

  getgenv().request = function(options)
      if type(options) == "table" and options.Url and options.Url:find("pandauth") then
          return {Success=true, StatusCode=200, Body=[[{"success":true,"key":"bypass-prior-key-001","expires":"2027-12-3
  1","data":{"hwid":"test","service":"prior","rank":"premium"}}]]}
      end
      return origReq and origReq(options)
  end

  getgenv().http_request = function(options)
      if type(options) == "table" and options.Url and options.Url:find("pandauth") then
          return {Success=true, StatusCode=200, Body=[[{"success":true,"key":"bypass-prior-key-001","expires":"2027-12-3
  1","data":{"hwid":"test","service":"prior","rank":"premium"}}]]}
      end
      return origHttp and origHttp(options)
  end

  print("[Bypass] Prior bypass ACTIVE...")
  loadstring(game:HttpGet("https://raw.githubusercontent.com/NarakaHUB/StorageHunter/refs/heads/main/README.md"))()
