document.addEventListener('turbolinks:load', function() {
    let progress = document.querySelector('.myprogress-bar');

    if (progress) { passageProgress(progress) }

    function passageProgress(progress) {
        progress.style.width = progress.dataset.progressInfo + "%"
    }
})

