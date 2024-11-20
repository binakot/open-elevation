wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.headers["Accept"] = "application/json"

single_request_coords = 10000

fromLat = 43.583874
fromLng = 39.720716

toLat = 64.713456
toLng = 177.738192

curLat = fromLat
curLng = fromLng

request = function()
    local body = "["
    for i = 1, single_request_coords, 1 do
        body = body .. "[" .. (curLat + 0.0001 * i) .. "," .. (curLng + 0.0001 * i) .. "]"
        if i < single_request_coords then
            body = body .. ","
        end
    end
    body = body .. "]"
    --print("REQ\n" .. body)

    curLat = curLat + 0.01
    curLng = curLng + 0.01
    if curLat > toLat or curLng > toLng then
        curLat = fromLat
        curLng = fromLng
    end

    return wrk.format("POST", "/api/v2/lookup", nil, body)
end

function response(status, headers, body)
    if status ~= 200 then
        print("Error: " .. status)
    end
    --("RESP\n" ..body)
end
