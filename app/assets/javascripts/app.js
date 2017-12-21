// Here we kick off our require.js app
// This is only the top-level initialization.
// Use main.js for initializing individual modules.
require( ['Main'], function(Main) {
  'use strict';

  // Initialize
  window.app = new Main();
});
