# Augmented Reality Sound Controller for Sonic Pi using Unity
##| set_sched_ahead_time! 0.     #for short latency

$settings = sync "/notesend"
$values = $settings

dir = "/Users/justinshenk/Projects/ar-loops/"

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
      $pianoAmp = 1
      $pianoX = x / 40
      $pianoY = y / 40
      puts $pianoX, $pianoY
    elsif instrument == "Guitar"
$guitarAmp = 1
      $guitarX = x / 40
      $guitarY = y / 40
    elsif instrument == "Drums"
$drumsAmp = 1
      $drumsX = x / 40
      $drumsY = y / 40
    elsif instrument == "Sax"
$saxAmp = 1
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
  sleep
end

live_loop :sax6 do
  sample dir, :alto1, amp: 0.1, attack: 2, beat_stretch: 3
  ##| sample :ambi_choir
  sleep 2
end

# OPTIONAL
##| live_loop :guitar1 do
### high beat stretch needed (around 40)
##|   sample dir + "guitarcrunch.wav", beat_stretch: 40
##|   sleep 6
##| end

live_loop :guitar do
# beat_stretch between 1 and 2 sounds good
  sample dir + "guitar1.wav", beat_stretch: 1
  sleep 2
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
