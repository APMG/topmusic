define(function(require){ // eslint-disable-line
  'use strict';

  // Required Modules
  var $ = require('jquery');

  var Ballot = function($el) {
    // The containing DOM element
    this.$el = $el;
  };

  Ballot.prototype.init = function() {
    this.selectElements()
      .bindEventHandlers()
      .updateOnCheck();

    this.min = this.$el.data('min');
    this.max = this.$el.data('max');
  };

  Ballot.prototype.selectElements = function() {
    this.$candidates = this.$el.find('.js-ballot-candidate');
    this.$submitButton = this.$el.find('.js-ballot-submit');
    this.$count = this.$el.find('.js-ballot-count');
    this.$max = this.$el.find('.js-ballot-max');

    return this;
  };

  Ballot.prototype.bindEventHandlers = function() {
    this.$candidates.on('change', this.onCandidateChange.bind(this));
    this.$el.on('submit', this.onFormSubmit.bind(this));

    return this;
  };

  // Event Handlers

  Ballot.prototype.onCandidateChange = function() {
    this.updateOnCheck();
  };

  Ballot.prototype.onFormSubmit = function(e) {
    var target = e.target;
    e.preventDefault();
    // Quick way to make sure filtered items are in DOM before submission
    $('#js-filter-clear').trigger('click');
    this.disableSubmit();
    window.setTimeout(function() {
      target.submit();
    }, 300);
  };

  // Helpers

  Ballot.prototype.updateOnCheck = function() {
    var numChecked = this.getCheckedCount();

    this.$count.html(numChecked);

    if (numChecked === 0) { this.disableSubmit(); }
    else if (numChecked > this.max) { this.disableSubmit(); }
    else { this.enableSubmit(); }
  };

  Ballot.prototype.enableSubmit = function() {
    this.$submitButton.removeAttr('disabled');
  };

  Ballot.prototype.disableSubmit = function() {
    this.$submitButton.attr('disabled', '');
  };

  Ballot.prototype.getCheckedCount = function() {
    var $checkedCandidates = this.$candidates.filter(':checked');

    return $checkedCandidates.length;
  };

  return Ballot;
});
