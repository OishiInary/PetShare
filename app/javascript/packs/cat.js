document.addEventListener('DOMContentLoaded', function() {
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
    const catX = catRect.left + window.pageXOffset;
    const catY = catRect.top + window.pageYOffset;
    const distX = mouseX - catX;
    const distY = mouseY - catY;
    cat.style.left = catX + distX * 0.1 + 'px';
    cat.style.top = (catY + distY * 0.1 + 5 )+ 'px';
    requestAnimationFrame(followCat);
};
    followCat();
});