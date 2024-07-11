function escaped = escapestring(str)
    escaped = replace(str, "_", "_u");
    escaped = replace(escaped, ".", "_d");
end