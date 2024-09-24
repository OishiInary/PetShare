document.addEventListener('turbolinks:load', function() {
    const cat = document.createElement('img');
    cat.src = '/chiko-aruku-toumei.gif';
    cat.style.width = '30px';
    cat.style.height = '30px';
    cat.style.position = 'fixed';
    cat.style.zIndex = '9999';
    cat.style.pointerEvents = 'none';
    document.body.appendChild(cat);

    let mouseX = 0;
    let mouseY = 0;

    document.addEventListener('mousemove', function(e) {
        mouseX = e.pageX;
        mouseY = e.pageY;
    });

    const followCat = () => {
        const catRect = cat.getBoundingClientRect();

        const distX = mouseX - catRect.left;
        const distY = mouseY - catRect.top;

        cat.style.left = (catRect.left +  distX) + 30 + 'px';
        cat.style.top = (catRect.top + distY) + 30 + 'px';

        requestAnimationFrame(followCat);
    };

    followCat();
});
