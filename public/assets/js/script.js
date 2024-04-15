function signin() {
    let email = document.querySelector('.emailLogin').value
    let password = document.querySelector('.passwordLogin').value

    let user = {
        email_user: email,
        password_user: password,
    }

    let params = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=utf-8',
        },
        body: JSON.stringify(user),
    }

    fetch('./treatments/login.php', params)
        .then((res) => res.text())
        .then((data) => {
            if (data === 'connected') {
                let loginForm = document.querySelector('.loginForm')
                loginForm.classList.add('hidden')
            } else {
                console.log('no accounts')
            }
            console.log(data)
        })
        .catch((e) => {
            alert('failed')
        })
}