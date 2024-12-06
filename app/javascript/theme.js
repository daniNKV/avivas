function updateLogoBasedOnTheme(theme) {
    const logoBlack = document.getElementById('site-logo-black')
    const logoWhite = document.getElementById('site-logo-white')
    const currentTheme = document.documentElement.getAttribute('data-theme') || 'black'
    if (currentTheme === 'black') {
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
    const currentTheme = document.documentElement.getAttribute('data-theme') || theme
    if (currentTheme === 'black') {
        iconDark.style.display = 'none';
        iconLight.style.display = 'block';
    } else {
        iconDark.style.display = 'block';
        iconLight.style.display = 'none';
    }
}

function updateNavbar(theme) {
    updateLogoBasedOnTheme(theme);
    updateIconBasedOnTheme(theme);
}
document.addEventListener('DOMContentLoaded', () => {
    const theme = localStorage.getItem('theme') === 'black' ? 'black' : 'lofi';
    updateNavbar(theme);
})

document.addEventListener('click', (e) => updateNavbar(e))
