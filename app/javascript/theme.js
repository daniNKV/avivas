import { themeChange } from 'theme-change'

function updateLogoBasedOnTheme(theme) {
    const logoBlack = document.getElementById('site-logo-black')
    const logoWhite = document.getElementById('site-logo-white')
    if (theme === 'black') {
        logoBlack.style.display = 'none';
        logoWhite.style.display = 'block';
    } else {
        logoBlack.style.display = 'block';
        logoWhite.style.display = 'none';
    }
}

function updateIconBasedOnTheme(theme) {
    const iconDark = document.getElementById('dark-icon')
    const iconLight = document.getElementById('light-icon')
    if (theme === 'black') {
        iconDark.style.display = 'none';
        iconLight.style.display = 'block';
    } else {
        iconDark.style.display = 'block';
        iconLight.style.display = 'none';
    }
}

function updateNavbar() {
    const theme = localStorage.getItem('theme') === 'black' ? 'black' : 'lofi';
    updateLogoBasedOnTheme(theme);
    updateIconBasedOnTheme(theme);
}
document.addEventListener('turbo:load', () => {
    const toggleButton = document.getElementById("theme-toggle")
    themeChange(false)
    updateNavbar();

    toggleButton.addEventListener('click', (e) => updateNavbar())
})

