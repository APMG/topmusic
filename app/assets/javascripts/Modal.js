define(function(require){ // eslint-disable-line
  'use strict';

  // Required Modules
  var $ = require('jquery');

  var FADE_SPEED = 150;

  var Modal = function(selector) {
    this.$link = $(selector);
  };

  Modal.prototype.init = function() {
    this.selectElements()
      .bindEventHandlers();

  };

  Modal.prototype.selectElements = function() {
    this.$shade = $('#js-modal-shade');
    this.$modals = $('.js-modal');
    this.$close = $('.js-modal-close');

    return this;
  };

  Modal.prototype.bindEventHandlers = function() {
    this.$link.on('click', this.onLinkClick.bind(this));
    this.$shade.on('click', this.onShadeClick.bind(this));
    this.$close.on('click', this.onCloseClick.bind(this));

    return this;
  };

  // Event Handlers

  Modal.prototype.onLinkClick = function(e) {
    var $target = $(e.currentTarget);
    var modalId = $target.data('modal');
    var $modal = $('#' + modalId);

    e.preventDefault();

    this.showModal($modal);
  };

  Modal.prototype.onShadeClick = function(e) {
    e.preventDefault();

    this.hideModals();
  };

  Modal.prototype.onCloseClick = function(e) {
    e.preventDefault();

    this.hideModals();
  };

  // Helpers
  Modal.prototype.showModal = function($modal) {
    this.$shade.fadeIn(FADE_SPEED);
    $modal.fadeIn(FADE_SPEED);
  };

  Modal.prototype.hideModals = function() {
    this.$shade.fadeOut(FADE_SPEED);
    this.$modals.fadeOut(FADE_SPEED);
  };

  return Modal;
});
