/* Based off of work on http://retromodular.com/ */
/*·····················································
···· Paul Reny ········································
····················· ██ ██ ██ ██ ██ ·· ██ ██ ·········
··············· ██ ██ ▒▒ ░░ ░░ ░░ ░░ ██ ▒▒ ░░ ██ ······
············ ██ ▒▒ ░░ ░░ ██ ░░ ██ ░░ ░░ ██ ░░ ░░ ██ ···
········· ██ ▒▒ ░░ ░░ ░░ ██ ░░ ██ ░░ ░░ ░░ ▒▒ ░░ ██ ···
········· ██ ░░ ░░ ░░ ░░ ██ ░░ ██ ░░ ░░ ░░ ▒▒ ▒▒ ██ ···
······ ██ ░░ ░░ ░░ ▒▒ ▒▒ ░░ ░░ ░░ ▒▒ ▒▒ ░░ ░░ ▒▒ ██ ···
··· ██ ▒▒ ░░ ░░ ░░ ░░ ░░ ░░ ██ ░░ ░░ ░░ ░░ ░░ ░░ ██ ···
··· ██ ░░ ░░ ▒▒ ░░ ░░ ░░ ░░ ██ ░░ ░░ ░░ ░░ ░░ ▒▒ ██ ···
··· ██ ░░ ░░ ▒▒ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ██ ······
······ ██ ██ ██ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ▒▒ ██ ······
··· ██ ▒▒ ▒▒ ▒▒ ██ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ▒▒ ██ ······
··· ██ ▒▒ ▒▒ ▒▒ ▒▒ ██ ░░ ░░ ░░ ░░ ░░ ░░ ▒▒ ██ ·········
··· ██ ▒▒ ▒▒ ▒▒ ▒▒ ██ ░░ ░░ ░░ ░░ ░░ ▒▒ ██ ██ ·········
······ ██ ▒▒ ▒▒ ▒▒ ▒▒ ██ ▒▒ ▒▒ ▒▒ ██ ██ ▒▒ ▒▒ ██ ······
········· ██ ▒▒ ▒▒ ██ ██ ██ ██ ██ ▒▒ ▒▒ ▒▒ ▒▒ ▒▒ ██ ···
············ ██ ██ ██ ········ ██ ██ ██ ██ ██ ██ ······
·····················································*/
/* added dynamic sizing to the text. as long as it's */
/* not too long of string, should always be visible */
/* Controls info: https://code.google.com/p/dat-gui/ */
/* dat.gui.js ==> http://cdnjs.cloudflare.com/ajax/libs/dat-gui/0.5/dat.gui.min.js */

(function (){
  "use strict";
  var textSize = 10;
  var glitcher = {

    init: function () {
      setTimeout((function () {
        this.canvas = document.getElementById('stage');
        this.context = this.canvas.getContext('2d');

        this.initOptions();
        this.resize();
        this.tick();
      }).bind(this), 100);
    },

    initOptions: function () {
      var gui = new dat.GUI(),
        current = gui.addFolder('Current'),
        controls = gui.addFolder('Controls');
      this.width = document.documentElement.offsetWidth;
      this.height = document.documentElement.offsetHeight;

      this.textSize = Math.floor(this.width / 7);
      // sets text size based on window size
      if (this.textSize > this.height) {
        this.textSize = Math.floor(this.height/1.5); }
      // tries to make text fit if window is
      // very wide, but not very tall
      this.font = '900 ' + this.textSize + 'px "Orbitron"';
      this.context.font = this.font;
      this.text = "巫龙";
      this.textWidth = (this.context.measureText(this.text)).width;

      this.fps = 60;

      this.channel = 0; // 0 = red, 1 = green, 2 = blue
      this.compOp = 'lighter'; // CompositeOperation = lighter || darker || xor
      this.phase = 0.0;
      this.phaseStep = 0.05; //determines how often we will change channel and amplitude
      this.amplitude = 0.0;
      this.amplitudeBase = 2.0;
      this.amplitudeRange = 2.0;
      this.alphaMin = 0.8;

      this.glitchAmplitude = 20.0;
      this.glitchThreshold = 0.9;
      this.scanlineBase = 40;
      this.scanlineRange = 40;
      this.scanlineShift = 15;

      current.add(this, 'channel', 0, 2).listen();
      current.add(this, 'phase', 0, 1).listen();
      current.add(this, 'amplitude', 0, 5).listen();
      // comment out below to hide ability to change text string
      var text = controls.add(this, 'text');
      text.onChange((function (){
        this.textWidth = (this.context.measureText(this.text)).width;
      }).bind(this));
      // comment out above to hide ability to change text string
      controls.add(this, 'fps', 1, 60);
      controls.add(this, 'phaseStep', 0, 1);
      controls.add(this, 'alphaMin', 0, 1);
      controls.add(this, 'amplitudeBase', 0, 5);
      controls.add(this, 'amplitudeRange', 0, 5);
      controls.add(this, 'glitchAmplitude', 0, 100);
      controls.add(this, 'glitchThreshold', 0, 1);
      controls.open();
      gui.close(); // start the control panel cloased
    },

    tick: function () {
      setTimeout((function () {
        this.phase += this.phaseStep;

        if (this.phase > 1) {
          this.phase = 0.0;
          this.channel = (this.channel === 2) ? 0 : this.channel + 1;
          this.amplitude = this.amplitudeBase + (this.amplitudeRange * Math.random());
        }

        this.render();
        this.tick();

      }).bind(this), 1000 / this.fps);
    },

    render: function () {
      var x0 = this.amplitude * Math.sin((Math.PI * 2) * this.phase) >> 0,
        x1, x2, x3;

      if (Math.random() >= this.glitchThreshold) {
        x0 *= this.glitchAmplitude;
      }

      x1 = this.width - this.textWidth >> 1;
      x2 = x1 + x0;
      x3 = x1 - x0;


      this.context.clearRect(0, 0, this.width, this.height);
      this.context.globalAlpha = this.alphaMin + ((1 - this.alphaMin) * Math.random());

      switch (this.channel) {
        case 0:
          this.renderChannels(x1, x2, x3);
          break;
        case 1:
          this.renderChannels(x2, x3, x1);
          break;
        case 2:
          this.renderChannels(x3, x1, x2);
          break;
      }
        this.renderScanline();
        if (Math.floor(Math.random() * 2) > 1) {
          this.renderScanline();
          // renders a second scanline 50% of the time
        }
    },

    renderChannels: function (x1, x2, x3) {
      this.context.font = this.font;
      this.context.fillStyle = "rgb(255,0,0)";
      this.context.fillText(this.text, x1, this.height / 2);

      this.context.globalCompositeOperation = this.compOp;

      this.context.fillStyle = "rgb(0,255,0)";
      this.context.fillText(this.text, x2, this.height / 2);
      this.context.fillStyle = "rgb(0,0,255)";
      this.context.fillText(this.text, x3, this.height / 2);
    },

    renderScanline: function () {
      var y = this.height * Math.random() >> 0,
        o = this.context.getImageData(0, y, this.width, 1),
        d = o.data,
        i = d.length,
        s = this.scanlineBase + this.scanlineRange * Math.random() >> 0,
        x = -this.scanlineShift + this.scanlineShift * 2 * Math.random() >> 0;

      while (i-- > 0) {
        d[i] += s;
      }

      this.context.putImageData(o, x, y);
    },

    resize: function () {
      this.width = document.documentElement.offsetWidth;
      this.height = window.innerHeight;
            // this.height = document.documentElement.offsetHeight;
      if (this.canvas) {
        this.canvas.height = this.height;
        //document.documentElement.offsetHeight;
        this.canvas.width = this.width;
        //document.documentElement.offsetWidth;
        this.textSize = Math.floor(this.canvas.width / 7);
        // RE-sets text size based on window size
        if (this.textSize > this.height) {
          this.textSize = Math.floor(this.canvas.height/1.5); }
          // tries to make text fit if window is
          // very wide, but not very tall
        this.font = '900 ' + this.textSize + 'px "Orbitron"';
        this.context.font = this.font;
      }
    }
  };

  document.onload = glitcher.init();
  window.onresize = glitcher.resize();
  // return;
 // executes anonymous function onload
})();
