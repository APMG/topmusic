// Required modules for page load
define(function(require, exports, module) { // eslint-disable-line
  'use strict';

  // Require external modules
  var $ = require('jquery');
  var Ballot = require('Ballot');
  var Filter = require('Filter');
  var Modal = require('Modal');
  var Lazyload = require('Lazyload');

  // Constructor
  var Main = function() {
    this.init();
  };

  Main.prototype.init = function() {
    if ($('.js-ballot').length) {
      new Ballot($('.js-ballot')).init();
    }

    if ($('#js-filter').length) {
      new Filter().init();
    }

    if ($('[data-modal]').length) {
      new Modal('[data-modal]').init();
    }

    if ($('.js-lazy').length) {
      new Lazyload('.js-lazy').init();
    }
  };

  return Main;

});
