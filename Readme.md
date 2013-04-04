# bound

  Object data binding to DOM elements

## Installation

    $ component install fouad/bound

## API
```javascript
var bound = require('bound');

var model = {
  id: 123,
  name: {
    value: "Steve Jobs",
    handler: function(val) {
      return val + " is smart";
    }
  },
  talking: {
    value: 17,
    handler: function(val) {
      return val+"%";
    }
  }
};

var o = bound(model, ".certain-identifier");

o.render();

setTimeout(function() {
  o.set("name", "Tim Cook")
}, 1000);
```
## License

  MIT
