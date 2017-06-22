# Augmented Reality Sound Controller for Sonic Pi using Unity
##| set_sched_ahead_time! 0.     #for short latency

$settings = sync "/notesend"
$values = $settings

def listen_to_unity()
  $settings = sync "/notesend"
  puts "setings!: ", $settings[0]
  $settings.each do |i|
    raw = i.split(",")
    instrument = raw.first
    x = raw[1].to_i
    y = raw[2].to_i
    if instrument == "Piano"
      puts "settings:", i
      $pianoX = x / 40
      $pianoY = y / 40
      puts $pianoX, $pianoY
    elsif instrument == "Guitar"
      $guitarX = x / 40
      $guitarY = y / 40
    elsif instrument == "Drums"
      $drumsX = x / 40
      $drumsY = y / 40
    elsif instrument == "Sax"
      $saxX = x / 40
      $saxY = y / 40
    end
  end
end

live_loop :time do
  listen_to_unity()
  sleep 0.25
end

live_loop :drums do
  sample :loop_amen
  
end


live_loop :loop do
  ##| puts "piano-strings ", $pianoX
  [1, 3, 6, 4].each do |d|
    (range -3, 3).each do |i|
      play_chord (chord_degree d, :c, :major, $pianoX, invert: i)
      sleep 0.25
    end
  end
end