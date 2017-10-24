-- https://github.com/mpv-player/mpv/issues/2256

-- local url = nil
-- local time = nil

-- function restore_position()
    -- mp.set_property('time-pos', time)
    -- mp.unregister_event(restore_position)
    -- print('restored position:', url, time)
-- end

function reconnect()
    url = mp.get_property('path')
    -- time = mp.get_property('time-pos')
    -- mp.register_event('playback-restart', restore_position)
    mp.commandv('loadfile', url)
end

mp.add_key_binding('Ctrl+r', reconnect)
