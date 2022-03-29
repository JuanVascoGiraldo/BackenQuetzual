const openEls = document.querySelectorAll("[data-open]");
const isVisible = "is-visible";

for (const el of openEls) {
    el.addEventListener("click", function() {
        const modalId = this.dataset.open;
        document.getElementById(modalId).classList.add(isVisible);
    });
}

document.addEventListener("click", e => {
    if (e.target == document.querySelector(".modal.is-visible")) {
        document.querySelector(".modal.is-visible").classList.remove(isVisible);
    }
});

$('.Estrellas').starRating({
    disableAfterRate: true,
    useFullStars: true,
    totalStars: 5,
    emptyColor: 'lightgray',
    hoverColor: 'yellow',
    initialRating: 0,
    strokeWidth: 0,
    useGradient: false,
    minRating: 1,
    callback: function(currentRating) {
        document.getElementById('modalR').classList.add(isVisible);
    }
});

function crm() {
    document.getElementById('modalR').classList.remove(isVisible);
}

function crm1() {
    document.getElementById('modalR1').classList.remove(isVisible);
}