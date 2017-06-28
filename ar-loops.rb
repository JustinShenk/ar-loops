# Augmented Reality Sound Controller for Sonic Pi using Unity
##| set_sched_ahead_time! 0.     #for short latency

$settings = sync "/notesend"
dir = "<insert path to sample directory>"

def listen_to_unity()
  $settings = sync "/notesend"
  puts "setings!: ", $settings
  parameters = $settings[0].split(",")
  # Initialize instrument volume as 0
  $guitarAmp = parameters[0].to_i
  $drumsAmp = parameters[1].to_i
  $pianoAmp = parameters[2].to_i
  $saxAmp = parameters[3].to_i
  $guitarX = parameters[4].to_i / 40
  $drumsX = parameters[5].to_i / 40
  $pianoX = parameters[6].to_i / 40
  $saxX = parameters[7].to_i / 40
  $guitarY = parameters[8].to_i / 40
  $drumsY = parameters[9].to_i / 40
  $pianoY = parameters[10].to_i / 40
  $saxY = parameters[11].to_i / 40
end

live_loop :time do
  listen_to_unity()
  sleep 0.25
end

live_loop :drums do
  if ($drumsAmp > 0)
    sample :loop_amen, amp: $drumsY*0.5, beat_stretch: $drumsX/8.0
  end
  sleep 1.0
end
live_loop :sax6 do
  if ($saxAmp > 0)
    sample dir, :alto1, amp: 0.1, attack: 2, beat_stretch: 3, amp: $saxY, pitch: $saxX/10.0
  end
  ##| sample :ambi_choir
  sleep 2
end

##| live_loop :guitar1 do
### high beat stretch needed (around 40)
##|   sample dir + "guitarcrunch.wav", beat_stretch: 40
##|   sleep 6
##| end

live_loop :guitar do
  # beat_stretch between 1 and 2 sounds good
  if ($guitarAmp > 0)
    sample dir + "guitar1.wav", beat_stretch: $guitarX/15.0, amp: $guitarY
    sleep 0.5
  end
  sleep 0.5
end

live_loop :loop do
  ##| puts "piano-strings ", $pianoX
  if ($pianoAmp > 0)
    [1, 3].each do |d|
      (range -1, 1).each do |i|
        play_chord (chord_degree d, :c, :major, $pianoX, amp: $pianoY,invert: i)
        sleep 0.3
      end
    end
  end
  sleep 1.0
end
