Dir.foreach(".") do |fname|
    puts  "[[SimpleAudioEngine sharedEngine] preloadEffect:\"#{fname}\"];"
end
