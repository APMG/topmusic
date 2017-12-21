define(function(require){ // eslint-disable-line
  'use strict';

  // Required Modules
  var $ = require('jquery');
  var IsOnScreen = require('jquery.isonscreen'); // eslint-disable-line

  var TIMER = 500;

  var Lazyload = function(selector) {
    this.$els = $(selector);

    this.didScroll = false;
  };

  Lazyload.prototype.init = function() {
    this.bindEventHandlers()
      .testVisibility()
      .scrollInterval();
  };

  Lazyload.prototype.selectElements = function() {

    return this;
  };

  Lazyload.prototype.bindEventHandlers = function() {
    $(window).on('scroll', this.onWindowScroll.bind(this));

    return this;
  };

  // Event Handlers

  Lazyload.prototype.onWindowScroll = function() {
    this.didScroll = true;
  };

  // Helpers

  Lazyload.prototype.scrollInterval = function() {
    var self = this;

    setInterval(function() {
      if (self.didScroll === true) {
        self.didScroll = false;
        self.testVisibility();
      }
    }, TIMER);

    return this;
  };

  Lazyload.prototype.testVisibility = function () {
    var self = this;

    this.$els.each(function() {
      var $el = $(this);

      if ($el.isOnScreen(0.5, 0.5) && $el.is(':visible')) {
        self.setSrc($el);
      }
    });

    return this;
  };

  Lazyload.prototype.setSrc = function($el) {
    if (typeof $el.attr('data-src') !== 'undefined') {
      var source = $el.data('src');
      $el.attr('src', source);
      $el.removeAttr('data-src');
      // Remove this element from initial jquery list
      this.$els = this.$els.not($el);
    }
  };


  return Lazyload;
});
