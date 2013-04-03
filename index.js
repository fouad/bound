// Generated by CoffeeScript 1.6.1
(function() {
  var Bound, bound, query;

  query = require("query");

  Bound = (function() {

    function Bound(obj, selector) {
      var key;
      this.attributes = {};
      this.frozen = false;
      this.selector = selector;
      for (key in obj) {
        if (obj[key]['value'] != null) {
          this.attributes[key] = obj[key];
        } else {
          this.attributes[key] = {
            value: obj[key]
          };
        }
      }
    }

    Bound.prototype.get = function(key) {
      return this.attributes[key]['value'];
    };

    Bound.prototype.set = function(key, value) {
      var $el;
      if (this.attributes[key] == null) {
        this.attributes[key] = {
          value: value
        };
      }
      if (this.attributes[key]['handler'] != null) {
        value = this.attributes[key]['handler'](value);
      }
      this.attributes[key]['value'] = value;
      if (!this.frozen) {
        $el = query("" + this.selector + " .bound-" + key);
        return $el.textContent = this.attributes[key]['value'];
      }
    };

    Bound.prototype.render = function() {
      var key, _results;
      _results = [];
      for (key in this.attributes) {
        _results.push(this.set(key, this.attributes[key]['value']));
      }
      return _results;
    };

    Bound.prototype.freeze = function() {
      return this.frozen = !this.frozen;
    };

    return Bound;

  })();

  bound = function(obj, selector) {
    if ((obj == null) || (selector == null)) {
      throw new Error("bound - missing parameter");
    }
    return new Bound(obj, selector);
  };

  module.exports = bound;

}).call(this);
