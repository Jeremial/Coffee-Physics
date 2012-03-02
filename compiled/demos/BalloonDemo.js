/* BalloonDemo
*/
var BalloonDemo,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

BalloonDemo = (function(_super) {

  __extends(BalloonDemo, _super);

  function BalloonDemo() {
    BalloonDemo.__super__.constructor.apply(this, arguments);
  }

  BalloonDemo.prototype.setup = function(full) {
    var attraction, i, max, p, s, _results;
    if (full == null) full = true;
    BalloonDemo.__super__.setup.apply(this, arguments);
    this.physics.integrator = new ImprovedEuler();
    attraction = new Attraction(this.mouse.pos);
    max = full ? 400 : 200;
    _results = [];
    for (i = 0; 0 <= max ? i <= max : i >= max; 0 <= max ? i++ : i--) {
      p = new Particle(Random(0.25, 4.0));
      p.setRadius(p.mass * 8);
      p.behaviours.push(new Wander(0.2));
      p.behaviours.push(attraction);
      p.moveTo(new Vector(Random(this.width), Random(this.height)));
      s = new Spring(this.mouse, p, Random(30, 300), 1.0);
      this.physics.particles.push(p);
      _results.push(this.physics.springs.push(s));
    }
    return _results;
  };

  return BalloonDemo;

})(Demo);
