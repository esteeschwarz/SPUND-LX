# // var midiNotes = []; // will hold mapping from numbers in mod sequence
# //                     // to midi note numbers.  128 indicates overflow
# // 		    // (if midi note over 127, no noteis  played).

# // var notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B", "C"];
notes = c("C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B")
ncpt<-rep(notes,10)
ncpt
pitch = 0 #;	// 0 to 11
octave = 1 #;	// -2 to 8
# midiOffset; // added on mapping
# var scale = [];	// array of intervals

# setPitch(0);			// C
#setOctave(1);			// C1
#setScale([2,2,1,2,2,2,1]); 	// default to major scale

setPitch<-function(i) {
    if (i < 0 || i > 11) { cat("Pitch out of range (0-11):" , i,"\n") }
    pitch = i
   # document.getElementById("pitch").innerHTML = notes[i];
    midiOffset = 12 * octave + pitch + 24
#    drawMap();
}

#// In MIDI middle C is defined as MIDI note 60
#// Conventions vary as to which Octave number this is (C3, C4, C5)
#// Here we choose C3, which means the MIDI octaves run from -2 to 8
#// (where 8 is incomplete as the last note is 127 = G).
#// This gives C0 = 24, C1 = 36, C2 = 48, C3 = 60, C4 = 72, C5 = 84, ...

setOctave<-function(i) {
    if (i < -2 || i > 8) { cat( "Octave out of range (-2 to 8):" , i,"\n" )}
    octave = i;
#    document.getElementById("octave").innerHTML = i;
    midiOffset = 12 * octave + pitch + 24
#    drawMap();
}

#setScale<-function (s) {
 #   if ( s == undefined ) { cat( "setScale expects array\n") }
  #  scale = s

#    var scaleString = document.getElementById("scale");
   # scaleString.value = s.join(" ");
    #drawMap();
#}

#// reGenerate uses the array of intervals to rebuild the scale

function reGenerate() {
    var scaleString = document.getElementById('scale').value;
    var s = [];
    var ns = [];

    // parse string into array s then create new scale array ns

    s = scaleString.match(/(\d+)/g);
    
    if (s) {
        for (var i=0; i < s.length; i++) {
            ns[i] = Number(s[i]);
            if (ns[i] < 1 || ns[i] > 23) {
                window.alert("Intervals must be between 1 and 23: " + n);
	        return;
            }
        }
    } else {
        // check for WH or TS notation instead of numbers
        s = scaleString.match(/[WH]/g) || scaleString.match(/[TS]/g);
        if (!s) {
            window.alert("Intervals must be in format 2,2,1 or TTS or WWH");
            return;
        }
        for (var i=0; i < s.length; i++) {
            if ( s[i] == "H" || s[i] == "S" ) ns[i] = 1; 
            else if ( s[i] == "W" || s[i] == "T" ) ns[i] = 2; 
        }
    }

    // success show string and set scale array

    document.getElementById('scale').value = s.join(" ");
    scale = ns;
    drawMap();
}