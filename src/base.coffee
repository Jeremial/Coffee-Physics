### RequestAnimationFrame shim. ###
((w)->
    requestAnimationFrame = w.requestAnimationFrame ||
        w.mozRequestAnimationFrame ||
        w.webkitRequestAnimationFrame ||
        w.msRequestAnimationFrame
    cancelAnimationFrame = w.cancelAnimationFrame ||
        w.mozCancelAnimationFrame ||
        w.webkitCancelAnimationFrame ||
        w.msCancelAnimationFrame
    if !requestAnimationFrame or !cancelAnimationFrame
        TARGET_FPS = 60
        aAnimQueue = []
        processing = []
        iRequestId = 0
        iIntervalId = null

        # create a mock requestAnimationFrame function
        w.requestAnimationFrame = (callback)->
            aAnimQueue.push [ ++iRequestId, callback ]

            if !iIntervalId
                iIntervalId = setInterval ->
                    if aAnimQueue.length
                        iTime = +new Date()
                        # Process all of the currently outstanding frame
                        # requests, but none that get added during the
                        # processing.
                        # Swap the arrays so we don't have to create a new
                        # array every frame.
                        temp = processing
                        processing = aAnimQueue
                        aAnimQueue = temp
                        while processing.length
                            processing.shift()[ 1 ] iTime
                    else
                        # don't continue the interval, if unnecessary
                        clearInterval iIntervalId
                        iIntervalId = undefined
                , 1000 / TARGET_FPS  # estimating support for #{TARGET_FPS} frames per second
            iRequestId

        w.cancelAnimationFrame = (requestId)->
            # find the request ID and remove it
            for i in [0...aAnimQueue.length]
                if aAnimQueue[ i ][ 0 ] is requestId
                    aAnimQueue.splice i, 1
                    return

            # If it's not in the queue, it may be in the set we're currently
            # processing (if cancelAnimationFrame is called from within a
            # requestAnimationFrame callback).
            for i in [0...processing.length]
                if processing[ i ][ 0 ] is requestId
                    processing.splice i, 1
                    return
)(window)
