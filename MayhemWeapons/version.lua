

-- add dots to version.
function fixVersion(version)
    return string.sub(version, 1, 1) .. "." .. string.sub(version, 2, 2) .. "." .. string.sub(version, 3, 3)
end

-- check if resource version is up to date
PerformHttpRequest("https://raw.githubusercontent.com/Andyyy7666/ND_Framework/main/ND_Core/fxmanifest.lua", function(errorCode, resultData, resultHeaders)
    i, j = string.find(tostring(resultData), "version")
    resultData = string.sub(tostring(resultData), i, j + 12)
    resultData = string.gsub(resultData, "version \"", "")
    i, j = string.find(resultData, "\"")
    resultData = string.sub(resultData, 1, i - 1)
    local githubVersion = string.gsub(resultData, "%.", "")
    local fileVersion = string.gsub(GetResourceMetadata(expectedName, "version", 0), "%.", "")
    githubVersion = tonumber(githubVersion)
    fileVersion = tonumber(fileVersion)

    if githubVersion and fileVersion then
        if githubVersion > fileVersion then
            print("^1[^4" .. expectedName .. "^1] WARNING^0")
            print("^4" .. expectedName .. " ^0is outdated. Please update it from ^5https://github.com/Andyyy7666/ND_Framework ^0| Current Version: ^1" .. fixVersion(fileVersion) .. " ^0| New Version: ^2" .. fixVersion(githubVersion) .. " ^0|")
        elseif githubVersion < fileVersion then
            print("^1[^4" .. expectedName .. "^1] WARNING^0")
            print("^4" .. expectedName .. " ^0version number is higher than expected | Current Version: ^3" .. fixVersion(fileVersion) .. " ^0| Expected Version: ^2" .. fixVersion(githubVersion) .. " ^0|")
        else
            print("^4" .. expectedName .. " ^0is up to date | Current Version: ^2" .. fixVersion(fileVersion) .. " ^0|")
        end
    else
        print("^1[^4" .. expectedName .. "^1] WARNING^0")
        print("You may not have the latest version of ^4" .. expectedName .. "^0. A newer, improved version may be present at ^5https://github.com/Andyyy7666/ND_Framework^0")
    end
end)