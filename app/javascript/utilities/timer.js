document.addEventListener('turbolinks:load', function() {
    let timeMinut = document.getElementById("minutes").dataset.leftTime;
    let timerShow = document.getElementById("timer");
    let form = document.forms[0]

    timer = setInterval(function () {
        seconds = Math.floor(timeMinut) % 60
        minutes = Math.floor(timeMinut) / 60 % 60
        if (timeMinut <= 0) {
            clearInterval(timer);
            alert("Время закончилось");
            form.submit()
        } else {
            let strTimer = `${Math.trunc(minutes)}:${seconds}`;
            timerShow.innerHTML = strTimer;
        }
        --timeMinut;
    }, 1000)
})
