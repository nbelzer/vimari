/*
 * Code in this file is taken directly from sVim, it has been adjusted to
 * work with Vimari.
 */

// We assume settings to be defined globally, as described in `injected.js`.

let animationFrame = null;

function sVimScrollBy(x, y) {
    // If smooth scroll is off then use regular scroll
    if (!settings.smoothScroll) {
        window.scrollBy(x, y);
        return;
    }

    // Smooth scroll
    let i = 0;
    let delta = 0;

    // Ease function
    function easeOutExpo(t, b, c, d) {
        return c * (-Math.pow(2, -10 * t / d) + 1) + b;
    }

    // Animate the scroll
    function animLoop() {
        const toScroll = Math.round(easeOutExpo(i, 0, y, settings.scrollDuration) - delta);
        if (toScroll !== 0) {
            if (y) {
                window.scrollBy(0, toScroll);
            } else {
                window.scrollBy(toScroll, 0);
            }
        }

        if (i < settings.scrollDuration) {
            // By requesting the animation frame we tell the browser that we
            // want to perform an animation and that before the redraw we
            // would like it to call our animLoop function.
            animationFrame = window.requestAnimationFrame(animLoop);
        }

        delta = easeOutExpo(i, 0, (x || y), settings.scrollDuration);
        i += 1;
    }

    // Start scroll
    animLoop();
}

