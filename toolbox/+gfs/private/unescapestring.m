function unescaped = unescapestring(str)
    unescaped = replace(str, "_d", ".");
    unescaped = replace(unescaped, "_u", "_");
end