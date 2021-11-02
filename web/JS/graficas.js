var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['ETS', 'Anticonceptivos', 'Embarazo', 'Salud sexual femenina', 'Salud sexual masculina'],
        datasets: [{
            label: 'Puntos',
            data: [16, 10, 15, 16, 13],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
        aspectRatio: 1,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
var ctx = document.getElementById('piechart').getContext('2d');
var piechart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Aceptadas', 'Rechazadas'],
        datasets: [{
            label: 'Preguntas',
            data: [11, 2],
            backgroundColor: [
                'rgba(75, 192, 192, 0.2)',
                'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
                'rgba(75, 192, 192, 1)',
                'rgba(255, 99, 132, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
        aspectRatio: 1,
    }
});