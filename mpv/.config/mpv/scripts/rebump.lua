local timer = mp.get_time()
mp.add_periodic_timer(1, 
                      (function()
                            if mp.get_property_bool("core-idle") then
                               if mp.get_property("path") then
                                  if string.find(mp.get_property("path"), "peca") 
                                     or
                                     string.find(mp.get_property("path"), "192.") 
                                  then
                                     if mp.get_time() - timer >= 20 then
                                        timer = mp.get_time()
                                        mp.osd_message("reconnecting",3)
                                        print("reconnecting")
                                        mp.commandv("playlist_next")
                                        mp.osd_message("reconnected",3)
                                        print("reconnected")
                                     end
                                  end
                               end
                            else
                               timer = mp.get_time()
                            end
end))

function my_auto_refresh ()
   if mp.get_property("path") then
      if string.find(mp.get_property("path"), "peca")
         or 
         string.find(mp.get_property("path"), "192.168")
      then
         local cache = mp.get_property_number("cache-used", 0)
         local avsync = math.abs(mp.get_property_number("total-avsync-change" , 0))
         if cache > 1500 or avsync > 1 then
            mp.osd_message("Refresh",3)
            print(string.format("Cache: %dKB AVsync: %d Refresh", cache,avsync))
            mp.commandv("playlist_next")
         end
      end
   end
end
mp.add_periodic_timer(30, my_auto_refresh)

function addbumpurl_handler()
   if mp.get_property("path") then
      if string.find(mp.get_property("path"),"/stream/".. string.rep("%x", 32)) ~= nil  
         and
         mp.get_property_number("playlist-count")  < 3 
      then
         local streampath = mp.get_property("path")
         local id = {string.find(streampath,"/stream/(%x*)")}
         local a = {}
         mp.set_property("loop", "inf")
         mp.commandv("playlist_clear")
         for i in string.gmatch(streampath, "[^/]+") do
            table.insert(a, i)
         end
         for i = 0 , 2 do
            mp.commandv("loadfile", streampath , "append")
         end
         mp.commandv("loadfile", "http://".. a[2] .."/admin?cmd=bump&id=".. id[3] , "append")
      end
   end
end
mp.register_event("file-loaded", addbumpurl_handler)

function bump_handler()
   if mp.get_property("path") then
      if string.find(mp.get_property("path"),"/stream/".. string.rep("%x", 32)) ~= nil 
      then
         local streampath = mp.get_property("path")
         local id = {string.find(streampath,"/stream/(%x*)")}
         local a = {}
         mp.commandv("playlist_clear")
         for i in string.gmatch(streampath, "[^/]+") do
            table.insert(a, i)
         end
         mp.commandv("loadfile", "http://".. a[2] .."/admin?cmd=bump&id=".. id[3] , "append")
         mp.commandv("playlist_next")
         print("bump")
         mp.osd_message("bump",3)
         for i = 0 , 2 do
            mp.commandv("loadfile", streampath , "append")
         end
         print("bumped")
         mp.osd_message("bumped",3)
      end
   end
end
mp.add_key_binding("z", "bump", bump_handler)
