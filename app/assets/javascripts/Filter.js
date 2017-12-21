define(function(require){ // eslint-disable-line
  'use strict';

  // Required Modules
  var $ = require('jquery');
  var List = require('list');
  var ListFuzzySearch = require('list.fuzzysearch');

  var EL_ID = 'js-filter';
  var LIST_CLASS = 'js-filter';
  var INPUT_CLASS = 'js-filter-search';
  var FILTER_CLASSES = [ 'js-filter-title', 'js-filter-artist', 'js-filter-album' ];
  var SORT_CLASS = 'js-filter-sort';

  var Filter = function() {
    // The containing DOM element
    this.$el = $('#' + EL_ID);

    this.fuzzyOptions = {
      searchClass: INPUT_CLASS,
      location: 0,
      distance: 100,
      threshold: 0.4,
      multiSearch: true
    };

    this.options = {
      listClass: LIST_CLASS,
      searchClass: INPUT_CLASS,
      sortClass: SORT_CLASS,
      page: 1000,
      plugins: [
        ListFuzzySearch(this.fuzzyOptions)
      ],
      valueNames: FILTER_CLASSES
    };
  };

  Filter.prototype.init = function() {
    this.list = new List(EL_ID, this.options); // eslint-disable-line no-unused-vars

    this.selectElements()
        .bindEventHandlers();
  };

  Filter.prototype.selectElements = function() {
    this.$input = this.$el.find('.' + INPUT_CLASS);
    this.$clearButton = this.$el.find('#js-filter-clear');

    return this;
  };

  Filter.prototype.bindEventHandlers = function() {
    this.$input.on('keyup', this.onInputKeyup.bind(this));
    this.$clearButton.on('click', this.onClearClick.bind(this));

    this.list.on('updated', function() {
      // The scroll event is a hacky way to get lazy loader to update images on search
      // until we find a better plugin or write it ourselves
      $(window).trigger('scroll');
    });

    return this;
  };

  // Event Handlers

  Filter.prototype.onInputKeyup = function() {
    this.checkInputText();
  };

  Filter.prototype.onClearClick = function() {
    this.$input.val('');
    this.$clearButton.hide();
    this.list.search();
  };

  // Helpers
  Filter.prototype.checkInputText = function() {
    if (this.$input.val().length > 0) {
      this.$clearButton.show();
    } else {
      this.$clearButton.hide();
    }
  };


  return Filter;
});
