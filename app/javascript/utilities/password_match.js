document.addEventListener('turbolinks:load', function() {
    var password = document.getElementById('user_password')
    var password_confirmation = document.getElementById('user_password_confirmation')

    let pass, re_pass;

    password.addEventListener('input',()=> {
        pass = password.value
        re_pass.length === 0 && pass === re_pass  ?
            (password.style.backgroundColor = 'rgba(32,178,170,0.4)',
            password_confirmation.style.backgroundColor = 'rgba(32,178,170,0.4)' )
            :
            (password.style.backgroundColor = 'rgba(255,69,0,0.3)',
             password_confirmation.style.backgroundColor = 'rgba(255,69,0,0.3)'
            )}
            )

    password_confirmation.addEventListener('input',()=> {
        re_pass = password_confirmation.value
        pass === re_pass ? (
             password.style.backgroundColor = 'rgba(32,178,170,0.4)',
             password_confirmation.style.backgroundColor = 'rgba(32,178,170,0.4)' )
            :
            (password.style.backgroundColor = 'rgba(255,69,0,0.3)',
             password_confirmation.style.backgroundColor = 'rgba(255,69,0,0.3)'
            )}
    )
})