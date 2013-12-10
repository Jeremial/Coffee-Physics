module.exports = ->

  # init the config
  @initConfig

    pkg: @file.readJSON 'package.json'

    # compile coffee to js files
    coffee:
      main:
        options:
          bare: true
          join: true # first concat all files into one, then compile that file to .js
          separator: '\n\n'
        files:
          'build/Physics.js': [
            'src/base.coffee'
            'src/math/Random.coffee'
            'src/math/Vector.coffee'
            'src/engine/Particle.coffee'
            'src/engine/Spring.coffee'
            'src/engine/Physics.coffee'
            'src/engine/integrator/Integrator.coffee'
            'src/engine/integrator/Euler.coffee'
            'src/engine/integrator/ImprovedEuler.coffee'
            'src/engine/integrator/Verlet.coffee'
            'src/behaviour/Behaviour.coffee'
            'src/behaviour/Attraction.coffee'
            'src/behaviour/Collision.coffee'
            'src/behaviour/ConstantForce.coffee'
            'src/behaviour/EdgeBounce.coffee'
            'src/behaviour/EdgeWrap.coffee'
            'src/behaviour/Wander.coffee'
          ]
          'build/Demo.js': [
            'src/demos/renderer/Renderer.coffee'
            'src/demos/renderer/CanvasRenderer.coffee'
            'src/demos/renderer/WebGLRenderer.coffee'
            'src/demos/renderer/DOMRenderer.coffee'
            'src/demos/Demo.coffee'
            'src/demos/AttractionDemo.coffee'
            'src/demos/BalloonDemo.coffee'
            'src/demos/BoundsDemo.coffee'
            'src/demos/ClothDemo.coffee'
            'src/demos/ChainDemo.coffee'
            'src/demos/CollisionDemo.coffee'
          ]

    # watch all coffee files change
    watch:
      main:
        files: ['src/**/*.coffee']
        tasks: ['coffee']

  @loadNpmTasks 'grunt-contrib-coffee'
  @loadNpmTasks 'grunt-contrib-watch'

  @registerTask 'default', ['coffee']
  @registerTask 'dev', ['coffee', 'watch']