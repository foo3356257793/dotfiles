local M = {}

local function parse_time(s)
    local h, m = s:match("^(%d%d)(%d%d)$")

    if not h then
        return nil
    end

    h = tonumber(h)
    m = tonumber(m)

    if h > 23 or m > 59 then
        return nil
    end

    return h * 60 + m
end

local function format_time(minutes)
    minutes = minutes % (24 * 60)

    local h = math.floor(minutes / 60)
    local m = minutes % 60

    return string.format("%02d%02d", h, m)
end

local function total_minutes(entries)
    local total = 0

    for i = 1, #entries - 1, 2 do
        total = total + (entries[i + 1] - entries[i])
    end

    return total
end

local function read_times()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local out = {}

    for _, line in ipairs(lines) do
        local t = parse_time(vim.trim(line))

        if t then
            table.insert(out, t)
        end
    end

    return out
end

function M.show_options()
    local times = read_times()

    if #times == 0 then
        print("No valid times found")
        return
    end

    local odd = (#times % 2 == 1)

    local base = {}

    for i, v in ipairs(times) do
        base[i] = v
    end

    local current_clockout = nil

    if not odd then
        current_clockout = base[#base]
        table.remove(base, #base)
    end

    local last_time = base[#base]

    local options = {}

    for candidate = last_time + 15, last_time + (12 * 60), 15 do
        local trial = {}

        for i, v in ipairs(base) do
            trial[i] = v
        end

        table.insert(trial, candidate)

        local total = total_minutes(trial)

        if total % 15 == 0 then
            table.insert(options, {
                clockout = candidate,
                total = total,
            })
        end
    end

    local lines = {}

    if odd then
        table.insert(lines, "Possible clock-out times:")
    else
        table.insert(lines, "Possible edited clock-out times:")
    end

    table.insert(lines, "")

    for _, opt in ipairs(options) do
        local marker = ""

        if current_clockout and opt.clockout == current_clockout then
            marker = "   <--- current"
        end

        table.insert(
            lines,
            string.format(
                "%s  ->  %.2f hours%s",
                format_time(opt.clockout),
                opt.total / 60,
                marker
            )
        )
    end

    vim.cmd("new")

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

-- module export
return M
