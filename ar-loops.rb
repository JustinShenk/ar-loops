# Augmented Reality Sound Controller for Sonic Pi using Unity
$settings = sync "/notesend"
$piano = $settings[0]

def listen_to_unity()
  $settings = sync "/notesend"
  $pianoStrings = $settings[0].split(",").last.to_i / 40
  puts "setting: ", $settings
end

live_loop :time do
  listen_to_unity()
  puts "piano:", $settings[0]
  sleep 2
end
##| with_fx :wobble, phase: 1, phase_slide: $guitarVolume do
live_loop :loop do
  puts "piano-strings ", $pianoStrings
  [1, 3, 6, 4].each do |d|
    (range -3, 3).each do |i|
      play_chord (chord_degree d, :c, :major, $pianoStrings, invert: i)
      sleep 0.25
    end
  end
end
##| end